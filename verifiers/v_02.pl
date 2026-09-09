card_variants(02, [lt, eq, gt]).
card_rule(02, lt, Code) :- nth1(1, Code, D), D < 3.
card_rule(02, eq, Code) :- nth1(1, Code, D), D =:= 3.
card_rule(02, gt, Code) :- nth1(1, Code, D), D > 3.
