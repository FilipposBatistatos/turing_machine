:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(17, [0,1,2,3]).
card_rule(17, 0, Code) :- count_even(Code, 0).
card_rule(17, 1, Code) :- count_even(Code, 1).
card_rule(17, 2, Code) :- count_even(Code, 2).
card_rule(17, 3, Code) :- count_even(Code, 3).
