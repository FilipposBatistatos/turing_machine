:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(33, [1e, 1o, 2e, 2o, 3e, 3o]).
card_rule(33, 1e, Code) :- nth1_even(1, Code).
card_rule(33, 1o, Code) :- nth1_odd(1, Code).
card_rule(33, 2e, Code) :- nth1_even(2, Code).
card_rule(33, 2o, Code) :- nth1_odd(2, Code).
card_rule(33, 3e, Code) :- nth1_even(3, Code).
card_rule(33, 3o, Code) :- nth1_odd(3, Code).