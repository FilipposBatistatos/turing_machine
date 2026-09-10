:- multifile card_variants/2.
:- multifile card_rule/3.

card_variants(04, [lt, eq, gt]).
card_rule(04, lt, Code) :- nth1(2, Code, D), D < 4.
card_rule(04, eq, Code) :- nth1(2, Code, D), D =:= 4.
card_rule(04, gt, Code) :- nth1(2, Code, D), D > 4.
