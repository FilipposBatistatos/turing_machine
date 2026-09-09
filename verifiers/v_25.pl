:- multifile card_rule/3.
:- multifile card_variants/2.

sequence_label(Code, 1) :-
    longest_sequence_run(Code, 1), !.
sequence_label(Code, 2) :-
    longest_sequence_run(Code, 2), !.
sequence_label(Code, 3) :-
    longest_sequence_run(Code, 3), !.

card_variants(25, [1,2,3]).
card_rule(25, Label) :- sequence_label(Code, Label).