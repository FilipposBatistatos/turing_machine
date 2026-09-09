:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(13, [lt, eq, gt]).
card_rule(13, lt, [D1, D2, D3]) :- D2 < D3.
card_rule(13, eq, [D1, D2, D3]) :- D2 =:= D3.
card_rule(13, gt, [D1, D2, D3]) :- D2 > D3.