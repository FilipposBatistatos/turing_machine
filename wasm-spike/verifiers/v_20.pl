:- multifile card_variants/2.
:- multifile card_rule/3.

card_variants(20, [2, 1, 0]).
card_rule(20, 2, Code) :- count_duplicates(Code, 2).
card_rule(20, 1, Code) :- count_duplicates(Code, 1).
card_rule(20, 0, Code) :- count_duplicates(Code, 0).