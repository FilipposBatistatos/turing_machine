:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(12, [lt, eq, gt]).
card_rule(12, lt, [D1, D2, D3]) :- D1 < D3.
card_rule(12, eq, [D1, D2, D3]) :- D1 =:= D3.
card_rule(12, gt, [D1, D2, D3]) :- D1 > D3.