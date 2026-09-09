:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(06, [even, odd]).
card_rule(06, even, Code) :- nth1_even(2, Code).
card_rule(06, odd, Code) :- nth1_odd(2, Code).
