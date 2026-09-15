:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(2, [lt, eq, gt]).
card_rule(2, lt, Code) :- nth1(1, Code, D), D < 3.
card_rule(2, eq, Code) :- nth1(1, Code, D), D =:= 3.
card_rule(2, gt, Code) :- nth1(1, Code, D), D > 3.
