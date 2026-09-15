:- multifile card_variants/2.
:- multifile card_rule/3.

card_variants(24, [3,2,1]).
card_rule(24, 3, Code) :- longest_consecutive_ascending_run(Code, 3).
card_rule(24, 2, Code) :- longest_consecutive_ascending_run(Code, 2).
card_rule(24, 1, Code) :- longest_consecutive_ascending_run(Code, 1).