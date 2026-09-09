:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(19, [lt, eq, gt]).
card_rule(19, lt, [D1, D2, D3]) :- D1 + D2 < 6.
card_rule(19, eq, [D1, D2, D3]) :- D1 + D2 =:= 6.
card_rule(19, gt, [D1, D2, D3]) :- D1 + D2 > 6.