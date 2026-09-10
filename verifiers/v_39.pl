:- multifile card_rule/3.
:- multifile card_variants/2.

/* A number is greater or equal to one */
card_variants(39, [eq1, gt1, eq2, gt2, eq3, gt3]).
card_rule(39, eq1, [D1, D2, D3]) :- D1 =:= 1.
card_rule(39, gt1, [D1, D2, D3]) :- D1 > 1.
card_rule(39, eq2, [D1, D2, D3]) :- D2 =:= 1.
card_rule(39, gt2, [D1, D2, D3]) :- D2 > 1.
card_rule(39, eq3, [D1, D2, D3]) :- D3 =:= 1.
card_rule(39, gt3, [D1, D2, D3]) :- D3 > 1.