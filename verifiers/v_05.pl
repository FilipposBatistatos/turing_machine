:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(05, [even, odd]).
card_rule(05, even, Code) :- nth1_even(1, Code).
card_rule(05, odd, Code) :- nth1_odd(1, Code).