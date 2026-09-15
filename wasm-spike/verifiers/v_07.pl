:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(7, [even, odd]).
card_rule(7, even, Code) :- nth1_even(3, Code).
card_rule(7, odd, Code) :- nth1_odd(3, Code).

