:- multifile card_rule/3.
:- multifile card_variants/2.

/* How many ones or how many fours */
card_variants(47, [zero4, one4, two4, zero1, one1, two1]).
card_rule(47, zero4, Code) :- count_matching(=(4), Code, 0).
card_rule(47, one4, Code) :- count_matching(=(4), Code, 1).
card_rule(47, two4, Code) :- count_matching(=(4), Code, 2).
card_rule(47, zero1, Code) :- count_matching(=(1), Code, 0).
card_rule(47, one1, Code) :- count_matching(=(1), Code, 1).
card_rule(47, two1, Code) :- count_matching(=(1), Code, 2).