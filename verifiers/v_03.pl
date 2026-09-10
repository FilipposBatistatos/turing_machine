:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(03, [lt, eq, gt]).
card_rule(03, lt, Code) :- nth1(2, Code, D), D < 3.
card_rule(03, eq, Code) :- nth1(2, Code, D), D =:= 3.
card_rule(03, gt, Code) :- nth1(2, Code, D), D > 3.
