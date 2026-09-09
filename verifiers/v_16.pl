:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(16, [even, odd]).
card_rule(16, even, Code) :- count_even(Code, E), count_odd(Code, O), E > O.
card_rule(16, odd, Code) :- count_even(Code, E), count_odd(Code, O), E < O.
