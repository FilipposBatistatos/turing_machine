:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(31, [1, 2, 3]).
card_rule(31, 1, [D1, D2, D3]) :- D1 > 1.
card_rule(31, 2, [D1, D2, D3]) :- D2 > 1.
card_rule(31, 3, [D1, D2, D3]) :- D3 > 1.