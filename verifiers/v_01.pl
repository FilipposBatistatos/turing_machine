card_variants(01, [eq, gt]).
card_rule(01, eq, Code) :- nth1(1, Code, D), D =:= 1.
card_rule(01, gt, Code) :- nth1(1, Code, D), D > 1.