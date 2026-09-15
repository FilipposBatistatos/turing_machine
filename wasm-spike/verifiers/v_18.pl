:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(18, [even, odd]).
card_rule(18, even, [D1, D2, D3]) :- is_even(D1 + D2 + D3).
card_rule(18, odd, [D1, D2, D3]) :- is_odd(D1 + D2 + D3).