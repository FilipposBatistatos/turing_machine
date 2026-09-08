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

best_code_for_verifier