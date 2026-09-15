:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(32, [1, 2, 3]).
card_rule(32, 1, [D1, D2, D3]) :- D1 > 3.
card_rule(32, 2, [D1, D2, D3]) :- D2 > 3.
card_rule(32, 3, [D1, D2, D3]) :- D3 > 3.