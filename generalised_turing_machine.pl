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
assign_variants([], []).
assign_variants([CardId|Rest], [CardId-Variant|Assignment]) :- 
    card_variants(CardId, Variants),
    member(Variant, Variants),
    \+ contradicts(CardId, Variant, Obs),
    assign_variants(Rest, Assignment).

/* Narrows down search using contadictions from previous information */
contradicts(CardId, Variant, Obs) :-
    member(round(Test, Results), obs),
    member(CardId-yes, Results)
    \+ card_rule(CardId, Variant, Test).
contradicts(CardId, Variant, Obs) :-
    member(round(Test, Results), obs),
    member(CardId-no, Results)
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

worst_remaining([Hyp], _Available, _TestCode, _MaxDepth, 0, solved(Hyp)) :-
    codes_of(Hyps, [Code]), !.

worst_remaining(Hyps, _Available, _TestCode, 0, Worst, stuck(Hyps)) :- !,
    codes_of(Hyps, Codes), length(Hyps, Worst).

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

print_plan(Plan) :- print_plan(Plan, 0).

print_plan(solved(hyp(_, Code)), Depth) :-
    !,
    tab(Depth), format("=> CODE: ~w~n", [Code]).

print_plan(stuck(Hyps), Depth) :-
    !,
    tab(Depth), format("STUCK, remaining hypotheses: ~w~n", [Hyps]).

print_plan(vacuous, Depth) :-
    !,
    tab(Depth), format("(this outcome can't occur)~n", []).

print_plan(query(Verifier, PlanYes, PlanNo), Depth) :-
    tab(Depth), format("Test verifier ~w~n", [Verifier]),
    Depth1 is Depth + 2,
    tab(Depth1), format("YES ->~n", []),
    print_plan(PlanYes, Depth1 + 2),
    tab(Depth1), format("NO ->~n", []),
    print_plan(PlanNo, Depth1 + 2).
