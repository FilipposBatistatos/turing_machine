# Turing Machine

### Installing Prolog on Ubuntu
```bash
sudo apt update
sudo apt install swi-prolog
```
Get the prolog query engine running 
```bash
swipl
```

To exit prolog
```bash
halt.
```

Loading a file
```prolog
?- [fileName].
```

## Usage

```prolog
-- Load the verifier cards
load_cards([4,9,11,14]).

-- See the possible combinations that yield a single number combination
hyps_gen([4,9,11,14], Hyps).

-- Produce a plan for finding the answer
best_code_full(Hyps, [4,9,11,14], 3, Code, Worst, Plan).

-- Hyps variable is out of scope after the command runs, so we need to run the commands together to get a plan

hyps_gen([4,9,11,14], Hyps), best_code_full(Hyps, [4,9,11,14], 3, Code, Worst, Plan).
```

Reading the plan output
```prolog
Hyps = [hyp([4-lt,9-0,11-eq,14-3],[2,2,1]),hyp([4-lt,9-1,11-lt,14-3],[2,3,1]),hyp([4-eq,9-0,11-lt,14-3],[2,4,1]),hyp([4-eq,9-0,11-gt,14-2],[5,4,5]),hyp([4-eq,9-1,11-eq,14-3],[4,4,3]),hyp([4-eq,9-1,11-gt,14-3],[5,4,3]),hyp([4-gt,9-1,11-eq,14-3],[5,5,3])],
Code = [4,4,1],
Worst = 0,
Plan = query(4,query(9,query(14,solved(hyp([4-eq,9-0,11-lt,14-3],[2,4,1])),solved(hyp([4-eq,9-0,11-gt,14-2],[5,4,5]))),query(11,solved(hyp([4-eq,9-1,11-eq,14-3],[4,4,3])),solved(hyp([4-eq,9-1,11-gt,14-3],[5,4,3])))),query(9,solved(hyp([4-lt,9-0,11-eq,14-3],[2,2,1])),query(11,solved(hyp([4-gt,9-1,11-eq,14-3],[5,5,3])),solved(hyp([4-lt,9-1,11-lt,14-3],[2,3,1]))))).
```

A little hard to read but we can simplify it a little bit with better indentation

```prolog
query(4,
    -- If Query 4 returns True
    query(9,
        -- If Query 9 returns True
        query(14,
            -- If Query 14 returns True
            solved(hyp([4-eq,9-0,11-lt,14-3],[2,4,1])),
            -- If Query 14 returns False
            solved(hyp([4-eq,9-0,11-gt,14-2],[5,4,5]))),
        -- If Query 9 returns False
        query(11,
            -- If Query 11 returns True
            solved(hyp([4-eq,9-1,11-eq,14-3],[4,4,3])),
            -- If Query 11 return False
            solved(hyp([4-eq,9-1,11-gt,14-3],[5,4,3])))),
    -- If Query 4 returns False
    query(9,
        -- If Query 9 returns True
        solved(hyp([4-lt,9-0,11-eq,14-3],[2,2,1])),
        -- If Query 9 returns False
        query(11,
            -- If Query 11 returns True
            solved(hyp([4-gt,9-1,11-eq,14-3],[5,5,3])),
            -- If Query 11 return False
            solved(hyp([4-lt,9-1,11-lt,14-3],[2,3,1]))
        )
    )
).
```

But what happens when you cannot quarantee a solve in three quesses. Worry not, it updates the hypothesis space from which you can generate new moves. 
```prolog
Plan = 
query(4,
    query(13,
        query(17,
            -- In this case the algorith is stuck between a number of new combinations. Running The algorith with there hypothesis will return the new correct line of questioning
            stuck([hyp([4-lt,9-1,13-eq,17-0],[3,1,1]),hyp([4-lt,9-3,13-eq,17-0],[3,3,3])]),
            solved(hyp([4-lt,9-1,13-eq,17-2],[3,2,2]))),
        query(17,
            solved(hyp([4-lt,9-2,13-gt,17-0],[3,3,1])),
            solved(hyp([4-lt,9-2,13-gt,17-1],[3,3,2])))),
    query(13,
        query(17,
            solved(hyp([4-gt,9-1,13-eq,17-0],[3,5,5])),
            solved(hyp([4-eq,9-1,13-eq,17-2],[3,4,4]))),
        query(17,
            solved(hyp([4-gt,9-2,13-gt,17-0],[3,5,3])),
            stuck([hyp([4-eq,9-1,13-lt,17-1],[3,4,5]),hyp([4-eq,9-2,13-gt,17-1],[3,4,3])]
            )
        )
    )
).
```

## Human readable output
```prolog
?- load_cards([4,9,11,14]),
   hyps_gen([4,9,11,14], Hyps),
   best_code_full(Hyps, [4,9,11,14], 3, Code, Worst, Plan),
   format("Test code: ~w~n", [Code]),
   print_plan(Plan).

Test code: [4,4,1]
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