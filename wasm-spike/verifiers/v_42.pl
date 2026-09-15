:- multifile card_rule/3.
:- multifile card_variants/2.

/* A number is greater, equal or greater than four */
card_variants(42, [gt1, lt1, gt2, lt2, gt3, lt3]).
card_rule(42, gt1, [D1, D2, D3]) :- D1 > D3, D1 > D2.
card_rule(42, lt1, [D1, D2, D3]) :- D1 < D3, D1 < D2.
card_rule(42, gt2, [D1, D2, D3]) :- D2 > D3, D2 > D1.
card_rule(42, lt2, [D1, D2, D3]) :- D2 < D3, D2 < D1.
card_rule(42, gt3, [D1, D2, D3]) :- D3 > D1, D3 > D2.
card_rule(42, lt3, [D1, D2, D3]) :- D3 < D1, D3 < D2.