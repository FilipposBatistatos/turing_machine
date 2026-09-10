:- multifile card_rule/3.
:- multifile card_variants/2.

/* Number two compared to another */
card_variants(44, [lt1, eq1, gt1, lt3, eq3, gt3]).
card_rule(44, lt1, [D1, D2, D3]) :- D2 < D1.
card_rule(44, eq1, [D1, D2, D3]) :- D2 =:= D1.
card_rule(44, gt1, [D1, D2, D3]) :- D2 > D1.
card_rule(44, lt3, [D1, D2, D3]) :- D2 < D3.
card_rule(44, eq3, [D1, D2, D3]) :- D2 =:= D3.
card_rule(44, gt3, [D1, D2, D3]) :- D2 > D3.