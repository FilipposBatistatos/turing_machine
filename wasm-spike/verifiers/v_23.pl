:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(23, [lt, eq, gt]).
card_rule(23, lt, [D1, D2, D3]) :- D1 + D2 + D3 < 6.
card_rule(23, eq, [D1, D2, D3]) :- D1 + D2 + D3 =:= 6.
card_rule(23, gt, [D1, D2, D3]) :- D1 + D2 + D3 > 6.