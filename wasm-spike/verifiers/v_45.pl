:- multifile card_rule/3.
:- multifile card_variants/2.

/* How many ones or how many threes */
card_variants(45, [zero1, one1, two1, zero3, one3, two3]).
card_rule(45, zero1, Code) :- count_matching(=(1), Code, 0).
card_rule(45, one1, Code) :- count_matching(=(1), Code, 1).
card_rule(45, two1, Code) :- count_matching(=(1), Code, 2).
card_rule(45, zero3, Code) :- count_matching(=(3), Code, 0).
card_rule(45, one3, Code) :- count_matching(=(3), Code, 1).
card_rule(45, two3, Code) :- count_matching(=(3), Code, 2).