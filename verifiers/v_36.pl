:- multifile card_rule/3.
:- multifile card_variants/2.

/* The sum is a mutliple of 3 4 or 5 */
card_variants(36, [3, 4, 5]).
card_rule(36, N, [D1, D2, D3]) :- 0 is (D1 + D2 + D3) mod N. 
