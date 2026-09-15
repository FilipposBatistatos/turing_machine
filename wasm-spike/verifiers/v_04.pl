:- multifile card_variants/2.
:- multifile card_rule/3.

card_variants(4, [lt, eq, gt]).
card_rule(4, lt, Code) :- nth1(2, Code, D), D < 4.
card_rule(4, eq, Code) :- nth1(2, Code, D), D =:= 4.
card_rule(4, gt, Code) :- nth1(2, Code, D), D > 4.
