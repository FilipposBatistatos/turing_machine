:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(6, [even, odd]).
card_rule(6, even, Code) :- nth1_even(2, Code).
card_rule(6, odd, Code) :- nth1_odd(2, Code).
