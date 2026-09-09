:- multifile card_variants/2.
:- multifile card_rule/3.

card_variants(22, [ascending, descending, no_order]).
card_rule(22, ascending, Code) :- order_type(Code, ascending).
card_rule(22, descending, Code) :- order_type(Code, descending).
card_rule(22, no_order, Code) :- order_type(Code, none).