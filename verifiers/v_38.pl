:- multifile card_rule/3.
:- multifile card_variants/2.

/* The sum of two digits is 6 */
card_variants(38, [12, 13, 23]).
card_rule(38, 12, [D1, D2, D3]) :- D1 + D2 =:= 6.
card_rule(38, 13, [D1, D2, D3]) :- D1 + D3 =:= 6.
card_rule(38, 23, [D1, D2, D3]) :- D2 + D3 =:= 6.
