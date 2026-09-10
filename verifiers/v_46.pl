:- multifile card_rule/3.
:- multifile card_variants/2.

/* How many threes or how many fours */
card_variants(46, [zero4, one4, two4, zero3, one3, two3]).
card_rule(46, zero4, Code) :- count_matching(=(4), Code, 0).
card_rule(46, one4, Code) :- count_matching(=(4), Code, 1).
card_rule(46, two4, Code) :- count_matching(=(4), Code, 2).
card_rule(46, zero3, Code) :- count_matching(=(3), Code, 0).
card_rule(46, one3, Code) :- count_matching(=(3), Code, 1).
card_rule(46, two3, Code) :- count_matching(=(3), Code, 2).