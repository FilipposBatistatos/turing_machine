:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(34, [1,2,3]).
card_rule(34, 1, [D1, D2, D3]) :- D1 >= D2, D1 >= D3.
card_rule(34, 2, [D1, D2, D3]) :- D2 >= D1, D2 >= D3.
card_rule(34, 3, [D1, D2, D3]) :- D3 >= D1, D3 >= D2.