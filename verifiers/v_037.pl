:- multifile card_rule/3.
:- multifile card_variants/2.

/* The sum of two digits is 4 */
card_variants(37, [12, 13, 23]).
card_rule(37, 12, [D1, D2, D3]) :- D1 + D2 =:= 4.
card_rule(37, 13, [D1, D2, D3]) :- D1 + D3 =:= 4.
card_rule(37, 23, [D1, D2, D3]) :- D3 + D2 =:= 4.