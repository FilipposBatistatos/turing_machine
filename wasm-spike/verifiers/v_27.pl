:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(27, [1, 2, 3]).
card_rule(27, 1, [D1, D2, D3]) :- D1 < 4.
card_rule(27, 2, [D1, D2, D3]) :- D2 < 4.
card_rule(27, 3, [D1, D2, D3]) :- D3 < 4.