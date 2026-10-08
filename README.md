# Turing Machine solver

A Prolog planner for the board game *Turing Machine*. Give it the verifier cards in
play and what you've observed so far. It tells you which secret codes are still
possible, which code to propose next, and which verifiers to test (and in what order)
to narrow it down.

## Setup

```bash
sudo apt update
sudo apt install swi-prolog
swipl                      # start the query engine
```

```prolog
?- [generalised_turing_machine].   % load the solver
?- halt.                           % exit
```

Run `swipl` from the repository root: the solver loads `./verifiers/...` relative to
the working directory.

## Quick start

```prolog
% Fresh puzzle, nothing observed yet
?- produce_plan([4,9,11,14], []).   % The numbers of the verifier cards
```

Output:

```
7 Possible codes: [[2,2,1],[2,3,1],[2,4,1],[4,4,3],[5,4,3],[5,4,5],[5,5,3]]
Propose [4,4,1] (worst case 0 codes left)
Test verifier 4
  YES ->
    Test verifier 9
      YES ->
        Test verifier 14
          YES ->
            => CODE: [2,4,1]
          NO ->
            => CODE: [5,4,5]
      NO ->
        Test verifier 11
          YES ->
            => CODE: [4,4,3]
          NO ->
            => CODE: [5,4,3]
  NO ->
    Test verifier 9
      YES ->
        => CODE: [2,2,1]
      NO ->
        Test verifier 11
          YES ->
            => CODE: [5,5,3]
          NO ->
            => CODE: [2,3,1]
```

How to read it:

1. **Propose `[4,4,1]`** to the machine.
2. **Test verifier 4** with that code. **YES** means the verifier accepted it (tick).
   **NO** means it rejected it (cross).
3. Follow the branch. Each test depends on the previous result.
4. `=> CODE: [...]` means that's the secret code, so submit it.

"Worst case 0 codes left" means the plan is guaranteed to finish within three tests,
whatever the answers.

## When the plan can't finish in three tests

Some puzzles can't be fully resolved in one round. The tree then has `STUCK` leaves:

```
STUCK, remaining codes: [[3,1,1],[3,3,3]]
```

That is not a failure. Do the round as far as the tree goes, then **tell the solver
what you saw** and ask again:

```prolog
?- produce_plan([4,9,13,17], [
       round([3,2,2], [4-yes, 13-yes, 17-no])   % For test code 322, verifier 4 was a tick, 13 was a tick and 17 was a cross
   ]).
```

`round(Code, Results)` records one round: the code you proposed and the verifier
results you saw, as `Card-pass` or `Card-fail`. You can pass any number of rounds, and
the solver prunes its hypotheses so the next plan starts from what you know:

```prolog
?- produce_plan([4,9,13,17], [
       round([3,2,2], [4-pass, 13-pass, 17-fail]),
       round([3,3,3], [9-pass])
   ]).
```

Possible results:

| Output | Meaning |
|---|---|
| A plan | Several codes remain; follow the tree |
| `Only one code possible: submit [...]` | Observations pin it down |
| `No hypothesis fits these observations` | Your observations contradict each other or the cards. Look for a mistyped card, code or pass/fail |
| `Error, bad input: ...` | Wrong card count, bad test code, a result that isn't `Card-pass`/`Card-fail`, or a card not in your list |

## Input rules

- Cards: a list of 4 to 6 ids, e.g. `[4,9,11,14]`.
- Test codes: three digits, each 1 to 5.
- Results: `Card-pass` or `Card-fail`, where `Card` must be in your card list.
- Only `round/2` is accepted. Don't tell it which variant a card is; it works that
  out (see *Why*).

## Lower-level predicates

`produce_plan/2` is a wrapper. The pieces are available if you want to inspect or
experiment:

```prolog
?- load_cards([4,9,11,14]).                       % consult the verifier files

?- hyps_gen([4,9,11,14], [], Hyps).               % hypotheses, no observations

?- hyps_gen([4,9,11,14], Obs, Hyps),              % with observations
   best_code_full(Hyps, [4,9,11,14], 3, Code, Worst, Plan).
```

`Hyps` is a variable that disappears after the query finishes, so run the steps in
one query as above.

| Predicate | Description |
|---|---|
| `load_cards(Ids)` | Consults `./verifiers/v_NN.pl` for each id |
| `hyps_gen(Cards, Obs, Hyps)` | All variant assignments that leave exactly one code and fit the observations |
| `best_code_full(Hyps, Cards, MaxTests, Code, Worst, Plan)` | Best code to propose and its test tree |
| `codes_of(Hyps, Codes)` | Distinct secret codes among the hypotheses |
| `print_plan(Plan)` | Prints the tree |

A hypothesis is `hyp(Assignment, Code)`, for example
`hyp([4-lt, 9-0, 11-eq, 14-3], [2,2,1])`: cards 4, 9, 11 and 14 are the variants
`lt`, `0`, `eq` and `3`, and the only code satisfying all four is `[2,2,1]`.

A plan is one of three terms:

```prolog
solved(Code)                    % exactly one code left
stuck(Codes)                    % out of tests; these codes remain
query(Card, OnYes, OnNo)        % test Card, then follow the matching branch
```

For the example above:

```prolog
Plan = query(4,
         query(9,
           query(14, solved([2,4,1]), solved([5,4,5])),
           query(11, solved([4,4,3]), solved([5,4,3]))),
         query(9,
           solved([2,2,1]),
           query(11, solved([5,5,3]), solved([2,3,1])))).
```

## Files

```
generalised_turing_machine.pl     the solver
verifiers/helpers.pl              shared predicates for card rules
verifiers/v_01.pl ... v_NN.pl     one file per card, id zero-padded to 2 digits
```

### Writing a verifier card

```prolog
:- multifile card_rule/3.
:- multifile card_variants/2.

card_variants(23, [lt, eq, gt]).
card_rule(23, lt, [D1, D2, D3]) :- D1 + D2 + D3 < 6.
card_rule(23, eq, [D1, D2, D3]) :- D1 + D2 + D3 =:= 6.
card_rule(23, gt, [D1, D2, D3]) :- D1 + D2 + D3 > 6.
```

- `card_variants(Id, Variants)` lists every rule the card might have in this game.
  The names are up to you.
- `card_rule(Id, Variant, Code)` succeeds if `Code` (a list of three digits) satisfies
  that variant.
- The `multifile` lines let many card files add clauses to the same predicates.
- A rule must **fail**, not raise an error, for codes it rejects. Don't use a
  catch-all final clause.

### Helpers

`helpers.pl` holds reusable checks (`count_even/2`, `is_ascending/1`,
`longest_sequence_run/2`, and so on). Because the solver calls rules with the variant
already known, helper predicates must work with every argument bound. In particular,
`order_type/2` must be written as one if-then-else; a trailing `order_type(_, none)`
clause would succeed for every code:

```prolog
order_type(Code, Type) :-
    (   is_ascending(Code)  -> Type = ascending
    ;   is_descending(Code) -> Type = descending
    ;   Type = none
    ).
```

## How it works

1. **Code space.** A code is three digits from 1 to 5, so there are 125 codes.
2. **Hypotheses.** `hyps_gen` tries every combination of one variant per card. A
   combination is kept only if exactly one of the 125 codes satisfies every chosen
   rule, because the real puzzles are built to have a unique answer.
3. **Observations prune early.** While choosing variants, any variant that
   contradicts a recorded round is dropped before the 125-code check runs. A variant
   contradicts a round if it accepts a code the card rejected, or rejects one the
   card accepted.
4. **Choosing a code.** For each of the 125 candidate codes, the solver builds the
   best test tree for that code, then keeps the code with the best result.
5. **The test tree.** For a fixed proposed code, each verifier splits the remaining
   hypotheses into "accepts the code" and "rejects it". The solver tries every
   verifier at every step, recurses on both branches up to 3 tests deep, and keeps
   the verifier whose worse branch is best. This is minimax.
6. **Scoring.** The score is the largest number of distinct codes that could remain
   at the end of any branch. 0 means every branch ends solved. Ties go to the first
   found in Prolog's standard term order.

