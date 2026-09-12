:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(9, [0,1,2,3]).
card_rule(9, 0, Code) :- count_matching(=(3), Code, 0).
card_rule(9, 1, Code) :- count_matching(=(3), Code, 1).
card_rule(9, 2, Code) :- count_matching(=(3), Code, 2).
card_rule(9, 3, Code) :- count_matching(=(3), Code, 3).