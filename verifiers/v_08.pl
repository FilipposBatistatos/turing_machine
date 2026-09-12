:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(8, [0,1,2,3]).
card_rule(8, 0, Code) :- count_matching(=(1), Code, 0).
card_rule(8, 1, Code) :- count_matching(=(1), Code, 1).
card_rule(8, 2, Code) :- count_matching(=(1), Code, 2).
card_rule(8, 3, Code) :- count_matching(=(1), Code, 3).

