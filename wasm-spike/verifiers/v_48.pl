:- multifile card_rule/3.
:- multifile card_variants/2.

/* A colour comprared to another */
card_variants(48, [1lt2, 1eq2, 1gt2, 1lt3, 1eq3, 1gt3, 2lt3, 2eq3, 2gt3]).
card_rule(48, 1lt2, [D1, D2, D3]) :- D1 < D2.
card_rule(48, 1eq2, [D1, D2, D3]) :- D1 =:= D2.
card_rule(48, 1gt2, [D1, D2, D3]) :- D1 > D2.
card_rule(48, 1lt3, [D1, D2, D3]) :- D1 < D3.
card_rule(48, 1eq3, [D1, D2, D3]) :- D1 =:= D3.
card_rule(48, 1gt3, [D1, D2, D3]) :- D1 > D3.
card_rule(48, 2lt3, [D1, D2, D3]) :- D2 < D3.
card_rule(48, 2eq3, [D1, D2, D3]) :- D2 =:= D3.
card_rule(48, 2gt3, [D1, D2, D3]) :- D2 > D3.