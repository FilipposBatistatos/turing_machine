:- multifile card_rule/3.
:- multifile card_variants/2.

/* A number is greater, equal or greater than three */
card_variants(40, [eq1, gt1, lt1, eq2, gt2, lt2, eq3, gt3, lt3]).
card_rule(40, eq1, [D1, D2, D3]) :- D1 =:= 3.
card_rule(40, gt1, [D1, D2, D3]) :- D1 > 3.
card_rule(40, lt1, [D1, D2, D3]) :- D1 < 3.
card_rule(40, eq2, [D1, D2, D3]) :- D2 =:= 3.
card_rule(40, gt2, [D1, D2, D3]) :- D2 > 3.
card_rule(40, lt2, [D1, D2, D3]) :- D2 < 3.
card_rule(40, eq3, [D1, D2, D3]) :- D3 =:= 3.
card_rule(40, gt3, [D1, D2, D3]) :- D3 > 3.
card_rule(40, lt3, [D1, D2, D3]) :- D3 < 3.