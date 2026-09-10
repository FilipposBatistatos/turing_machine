:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(01, [eq, gt]).
card_rule(01, eq, Code) :- nth1(1, Code, D), D =:= 1.
card_rule(01, gt, Code) :- nth1(1, Code, D), D > 1.