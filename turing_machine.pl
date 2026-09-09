digit(D) :- member(D, [1,2,3,4,5]).

code([D1, D2, D3]) :-
    digit(D1),
    digit(D2),
    digit(D3).

/* Verifiers for game #1, a tutorial game */
/* Verifier A test the value of D2 against 4 */
verifierA(gt, Code) :- nth1(2, Code, D), D > 4.
verifierA(eq, Code) :- nth1(2, Code, D), D =:= 4.
verifierA(lt, Code) :- nth1(2, Code, D), D < 4.

/* Verifier B tests the number of occurences of the number "3" */
count_value(Val, Code, N) :-
    include(=(Val), Code, Matches),
    length(Matches, N).

verifierB(0, Code) :- count_value(3, Code, 0).
verifierB(1, Code) :- count_value(3, Code, 1).
verifierB(2, Code) :- count_value(3, Code, 2).
verifierB(3, Code) :- count_value(3, Code, 3).

/* Verifier C tests whether D1 is lt, eq or gt D2 */
verifierC(lt, Code) :- nth1(1, Code, D1), nth1(2, Code, D2), D1 < D2. 
verifierC(eq, Code) :- nth1(1, Code, D1), nth1(2, Code, D2), D1 =:= D2. 
verifierC(gt, Code) :- nth1(1, Code, D1), nth1(2, Code, D2), D1 > D2. 

/* Verifier D tests which digit is the smallest */
verifierD(1, [D1, D2, D3]) :- D1 < D2, D1 < D3.
verifierD(2, [D1, D2, D3]) :- D2 < D1, D2 < D3.
verifierD(3, [D1, D2, D3]) :- D3 < D1, D3 < D2.


consistent(Code, VA, VB, VC, VD) :-
    code(Code),
    verifierA(VA, Code),
    verifierB(VB, Code),
    verifierC(VC, Code),
    verifierD(VD, Code).

variantA(gt). variantA(eq). variantA(lt).
variantB(0). variantB(1). variantB(2). variant(3).
variantC(lt). variantC(eq). variantC(gt).
variantD(1). variantD(2). variantD(3).

unique_solutions(VA, VB, VC, VD, Code) :-
    variantA(VA),
    variantB(VB),
    variantC(VC),
    variantD(VD),
    findall(C, consistent(C, VA, VB, VC, VD), [Code]).

hyps([
    hyp(gt,1,eq,3,[5,5,3]),
    hyp(eq,0,lt,3,[2,4,1]),
    hyp(eq,0,gt,2,[5,4,5]),
    hyp(eq,1,eq,3,[4,4,3]),
    hyp(eq,1,gt,3,[5,4,3]),
    hyp(lt,0,eq,3,[2,2,1]),
    hyp(lt,1,lt,3,[2,3,1])
]).

verifier_pred(a, verifierA).
verifier_pred(b, verifierB).
verifier_pred(c, verifierC).
verifier_pred(d, verifierD).

hyp_variant(a, hyp(VA,_,_,_,_), VA).
hyp_variant(b, hyp(_,VB,_,_,_), VB).
hyp_variant(c, hyp(_,_,VC,_,_), VC).
hyp_variant(d, hyp(_,_,_,VD,_), VD).

hyp_answers_yes(Verifier, TestCode, Hyp) :-
    hyp_variant(Verifier, Hyp, Variant),
    verifier_pred(Verifier, Pred),
    call(Pred, Variant, TestCode).

split_hyps(Verifier, TestCode, Hyps, YesHyps, NoHyps) :-
    partition(hyp_answers_yes(Verifier, TestCode), Hyps, YesHyps, NoHyps).

best_query([Hyp], _Available, _TestCode, 0, none) :- !.

best_query([Hyp], _Available, _TestCode, 0, solved(Hyp)) :- !.

best_query(Hyps, Available, TestCode, Depth, query(V, PlanYes, PlanNo)) :-
    findall(
        D-V0-PY-PN,
        ( member(V0, Available),
          split_hyps(V0, TestCode, Hyps, Yes, No),
          select(V0, Available, Remaining),
          branch_depth(Yes, Remaining, TestCode, DYes, PY),
          branch_depth(No, Remaining, TestCode, DNo, PN),
          D is 1 + max(DYes, DNo)
        ),
        Candidates
    ),
    min_member(Depth-V-PlanYes-PlanNo, Candidates).

branch_depth([], _, _, 0, vacuous) :- !.
branch_depth(Hyps, Available, TestCode, D, Plan) :-
    best_query(Hyps, Available, TestCode, D, Plan).