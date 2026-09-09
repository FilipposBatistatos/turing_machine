:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(11, [lt, eq, gt]).
card_rule(11, lt, [D1, D2, D3]) :- D1 < D2.
card_rule(11, eq, [D1, D2, D3]) :- D1 =:= D2.
card_rule(11, gt, [D1, D2, D3]) :- D1 > D2.