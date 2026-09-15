:- multifile card_variants/2.
:- multifile card_rule/3.

card_variants(21, [pair, no_pair]).
card_rule(21, no_pair, Code) :- count_duplicates(Code, 1).
card_rule(21, pair, Code) :- count_duplicates(Code, 0).