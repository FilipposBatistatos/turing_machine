is_even(N) :- 0 is N mod 2.
is_odd(N) :- 1 is N mod 2.

nth1_even(Pos, Code) :- nth1(Pos, Code, D), is_even(D).
nth1_odd(Pos, Code) :- nth1(Pos, Code, D), is_odd(D).

count_matching(Pred, Code, N) :- 
    include(Pred, Code, Matches),
    length(Matches, N).

count_even(Code, N) :- count_matching(is_even, Code, N).
count_odd(Code, N) :- count_matching(is_odd, Code, N).

count_duplicates(Code, N) :-
    length(Code, Len),
    sort(Code, Sorted),
    length(Sorted, SLen),
    N is Len - DLen.