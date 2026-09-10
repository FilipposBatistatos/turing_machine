:- multifile card_rule/3.
:- multifile card_variants/2.

/* A number is greater, equal or greater than four */
card_variants(41, [eq1, gt1, lt1, eq2, gt2, lt2, eq3, gt3, lt3]).
card_rule(41, eq1, [D1, D2, D3]) :- D1 =:= 4.
card_rule(41, gt1, [D1, D2, D3]) :- D1 > 4.
card_rule(41, lt1, [D1, D2, D3]) :- D1 < 4.
card_rule(41, eq2, [D1, D2, D3]) :- D2 =:= 4.
card_rule(41, gt2, [D1, D2, D3]) :- D2 > 4.
card_rule(41, lt2, [D1, D2, D3]) :- D2 < 4.
card_rule(41, eq3, [D1, D2, D3]) :- D3 =:= 4.
card_rule(41, gt3, [D1, D2, D3]) :- D3 > 4.
card_rule(41, lt3, [D1, D2, D3]) :- D3 < 4.