:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(1, [eq, gt]).
card_rule(1, eq, Code) :- nth1(1, Code, D), D =:= 1.
card_rule(1, gt, Code) :- nth1(1, Code, D), D > 1.