:- consult('./verifiers/helpers').

digit(D) :- member(D, [1,2,3,4,5]).

code([D1, D2, D3]) :-
    digit(D1),
    digit(D2),
    digit(D3).

load_cards(CardIds) :-
    forall(
        member(CardId, CardIds),
        ( format(atom(Path), './verifiers/v_~|~`0t~d~2+', [CardId]), 
            consult(Path)
        )
    ).

/* Pick one variant for every card in the list */
assign_variants([], _, []).
assign_variants([CardId|Rest], Obs, [CardId-Variant|Assignment]) :- 
    card_variants(CardId, Variants),
    member(Variant, Variants),
    \+ contradicts(CardId, Variant, Obs),
    assign_variants(Rest, Obs, Assignment).

/* Narrows down search using contradictions from previous information */
contradicts(CardId, Variant, Obs) :-
    member(round(Test, Results), Obs),
    member(CardId-pass, Results),
    \+ card_rule(CardId, Variant, Test).
contradicts(CardId, Variant, Obs) :-
    member(round(Test, Results), Obs),
    member(CardId-fail, Results),
    card_rule(CardId, Variant, Test).

/* Check every card-variant pair actually holds for Code */ 
consistent(Code, Assignment) :-
    code(Code),
    check_all(Code, Assignment).

check_all(_, []).
check_all(Code, [CardId-Variant|Rest]) :- 
    card_rule(CardId, Variant, Code),
    check_all(Code, Rest).

unique_solutions_gen(CardIds, Obs, Assignment, Code) :- 
    assign_variants(CardIds, Obs, Assignment),
    findall(C, consistent(C, Assignment), [Code]).

/* Find all the unique solutions available based on the available verifiers */
hyps_gen(CardIds, Obs, Hyps) :-
    findall(hyp(Assignment, Code), 
        unique_solutions_gen(CardIds, Obs, Assignment, Code), Hyps).

hyp_answers_yes(CardId, TestCode, hyp(Assignment, _)) :- 
    member(CardId-Variant, Assignment),
    card_rule(CardId, Variant, TestCode).

split_hyps(CardId, TestCode, Hyps, YesHyps, NoHyps) :-
    partition(hyp_answers_yes(CardId, TestCode), Hyps, YesHyps, NoHyps).

/* Distinct secret codes left */
codes_of(Hyps, Codes) :-
    findall(C, member(hyp(_, C), Hyps), Cs),
    sort(Cs, Codes).

worst_remaining(Hyps, _Available, _TestCode, _MaxDepth, 0, solved(Code)) :-
    codes_of(Hyps, [Code]), !.

worst_remaining(Hyps, _Available, _TestCode, 0, Worst, stuck(Codes)) :- !,
    codes_of(Hyps, Codes), length(Codes, Worst).

worst_remaining(Hyps, Available, TestCode, MaxDepth, Worst, Plan) :-
    Depth1 is MaxDepth - 1,
    findall(
        W-V0-PY-PN,
        ( select(V0, Available, Remaining),
          split_hyps(V0, TestCode, Hyps, Yes, No),
          Yes \== [], No \== [],            % a test that splits nothing is useless
          worst_remaining(Yes, Remaining, TestCode, Depth1, WYes, PY),
          worst_remaining(No,  Remaining, TestCode, Depth1, WNo,  PN),
          W is max(WYes, WNo)
        ),
        Candidates),
    (   Candidates == []                    % no useful verifier left
    ->  codes_of(Hyps, Codes), length(Codes, Worst), Plan = stuck(Codes)
    ;   min_member(Worst-V-PY-PN, Candidates), Plan = query(V, PY, PN)
    ).

best_code_full(Hyps, Available, MaxDepth, BestCode, BestWorst, BestPlan) :-
    findall(
        Worst-Code-Plan,
        ( code(Code),
          worst_remaining(Hyps, Available, Code, MaxDepth, Worst, Plan)
        ),
        Triples
    ),
    min_member(BestWorst-BestCode-BestPlan, Triples).

/* Reject bad input */
bad_input(Cards, _, card_count_must_be_4_to_6(N)) :-
    length(Cards, N), \+ between(4, 6, N).
bad_input(_, Obs, observations_must_be_a_list) :- \+ is_list(Obs).
bad_input(_, Obs, not_a_round(O)) :-
    member(O, Obs), O \= round(_, _).
bad_input(_, Obs, bad_test_code(T)) :-
    member(round(T, _), Obs), \+ valid_code(T).
bad_input(Cards, Obs, bad_result(R)) :-
    member(round(_, Rs), Obs),
    (   is_list(Rs) -> member(R, Rs), \+ valid_result(Cards, R) ; R = Rs ).

valid_code(T) :- is_list(T), T = [_,_,_], forall(member(D, T), (integer(D), digit(D))).
valid_result(Cards, Card-Outcome) :- memberchk(Card, Cards), memberchk(Outcome, [pass, fail]).

/* Single entry point */
produce_plan(Cards, Obs) :-
    ( bad_input(Cards, Obs, Why)
    -> format("Error, bad input: ~w~n", [Why])
    ;   load_cards(Cards),
        hyps_gen(Cards, Obs, Hyps),
        codes_of(Hyps, Codes),
        ( Hyps == []
        -> format("No hypothesis fits these observations, double check your work!~n")
        ;   Codes = [Code]
        -> format("Only one code possible: submit ~w~n", [Code])
        ;   best_code_full(Hyps, Cards, 3, Code, Worst, Plan),
            length(Codes, N),
            format("~d Possible codes: ~w~n", [N, Codes]),
            format("Propose ~w (worst case ~d codes left)~n", [Code, Worst]),
            print_plan(Plan)
        )
    ).

/* Formating and user friendly printing */
print_plan(Plan) :- print_plan(Plan, 0).

print_plan(solved(Code), Depth) :-
    !,
    tab(Depth), format("=> CODE: ~w~n", [Code]).

print_plan(stuck(Codes), Depth) :-
    !,
    tab(Depth), format("STUCK, remaining codes: ~w~n", [Codes]).

print_plan(query(Verifier, PlanYes, PlanNo), Depth) :-
    tab(Depth), format("Test verifier ~w~n", [Verifier]),
    Depth1 is Depth + 2,
    Depth2 is Depth1 + 2,
    tab(Depth1), format("YES ->~n", []),
    print_plan(PlanYes, Depth2),
    tab(Depth1), format("NO ->~n", []),
    print_plan(PlanNo, Depth2).
