:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(30, [1, 2, 3]).
card_rule(30, 1, [D1, D2, D3]) :- D1 =:= 4.
card_rule(30, 2, [D1, D2, D3]) :- D2 =:= 4.
card_rule(30, 3, [D1, D2, D3]) :- D3 =:= 4.