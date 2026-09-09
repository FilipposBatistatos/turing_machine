:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(09, [0,1,2,3]).
card_rule(09, 0, Code) :- count_matching(=(3), Code, 0).
card_rule(09, 1, Code) :- count_matching(=(3), Code, 1).
card_rule(09, 2, Code) :- count_matching(=(3), Code, 2).
card_rule(09, 3, Code) :- count_matching(=(3), Code, 3).