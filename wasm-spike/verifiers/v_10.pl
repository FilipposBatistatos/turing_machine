:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(10, [0,1,2,3]).
card_rule(10, 0, Code) :- count_matching(=(4), Code, 0).
card_rule(10, 1, Code) :- count_matching(=(4), Code, 1).
card_rule(10, 2, Code) :- count_matching(=(4), Code, 2).
card_rule(10, 3, Code) :- count_matching(=(4), Code, 3).