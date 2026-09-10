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

ascending_pairs([_], _) :- !.
ascending_pairs([A,B|Rest], all) :- 
    A < B, 
    ascending_pairs([B|Rest], all).

descending_pairs([_], _) :- !.
descending_pairs([A,B|Rest], all) :- 
    A > B, 
    descending_pairs([B|Rest], all).

is_ascending(Code) :- ascending_pairs(Code, all).
is_descending(Code) :- descending_pairs(Code, all).

order_type(Code, ascending) :- is_ascending(Code), !.
order_type(Code, ascending) :- is_descending(Code), !.
order_type(_, none).

consecutive_ascending_runs([_], [1]) :- !.
consecutive_ascending_runs([X,Y|Rest], [Len|Lengths]) :- 
    Y =:= X + 1, !,
    consecutive_ascending_runs([Y|Rest], [SubLen|Lengths]),
    Len is SubLen + 1.
consecutive_ascending_runs([_,Y|Rest], [1|Lengths]) :-
    consecutive_ascending_runs([Y|Rest], Lengths).

longest_consecutive_ascending_run(Code, Length) :-
    consecutive_ascending_runs(Code, Lengths),
    max_list(Lengths, Length).

consecutive_descending_runs([_], [1]) :- !.
consecutive_descending_runs([X,Y|Rest], [Len|Lengths]) :- 
    Y =:= X - 1, !,
    consecutive_descending_runs([Y|Rest], [SubLen|Lengths]),
    Len is SubLen + 1.
consecutive_descending_runs([_,Y|Rest], [1|Lengths]) :-
    consecutive_descending_runs([Y|Rest], Lengths).

longest_consecutive_descending_run(Code, Length) :-
    consecutive_descending_runs(Code, Lengths),
    max_list(Lengths, Length).

longest_sequence_run(Code, Length) :-
    longest_consecutive_ascending_run(Code, AscLen),
    longest_consecutive_descending_run(Code,DesLen),
    Length is Max(AscLen, DesLen).