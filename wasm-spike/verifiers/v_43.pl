:- multifile card_rule/3.
:- multifile card_variants/2.

/* Number one compared to another */
card_variants(43, [lt2, eq2, gt2, lt3, eq3, gt3]).
card_rule(43, lt2, [D1, D2, D3]) :- D1 < D2.
card_rule(43, eq2, [D1, D2, D3]) :- D1 =:= D2.
card_rule(43, gt2, [D1, D2, D3]) :- D1 > D2.
card_rule(43, lt3, [D1, D2, D3]) :- D1 < D3.
card_rule(43, eq3, [D1, D2, D3]) :- D1 =:= D3.
card_rule(43, gt3, [D1, D2, D3]) :- D1 > D3.