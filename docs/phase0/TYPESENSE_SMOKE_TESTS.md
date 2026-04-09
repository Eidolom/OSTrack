# Typesense Phase 0 Smoke Test Matrix

Last updated: 2026-04-09
Status: Draft

## Scope
This matrix provides a concrete query set for validating alias grouping, multilingual lookup, and normalization behavior in staging.

## Test Cases

| ID | Query | Expected Outcome |
|---|---|---|
| T-01 | tatakai | Returns the intended Japanese battle-theme track group. |
| T-02 | 戦いの時 | Returns the same logical result group as T-01 or its canonical equivalent. |
| T-03 | one winged | Returns One-Winged Angel in top results. |
| T-04 | Nier automata amusement park | Returns the correct OST/track group despite spacing and case variation. |
| T-05 | いのちの名前 | Returns the correct Japanese-native result group. |
| T-06 | inochi no namae | Returns the same logical result group as T-05. |
| T-07 | battle theme | Returns multiple strong OST candidates and does not drop canonical matches. |
| T-08 | final fantasy vii | Returns Final Fantasy VII related results, including aliases. |
| T-09 | shadow of the colossus | Returns the intended media source and soundtrack entries. |
| T-10 | sephiroth | Returns related track and media source entries with high relevance. |
| T-11 | jukebox hero | Returns zero or clearly unrelated results unless seeded content exists, used to validate false-positive control. |
| T-12 | \"one-winged angel\" | Returns the exact canonical track group with punctuation normalization intact. |

## Pass Criteria
- Exact or canonical-equivalent results appear in the first result page for each positive query.
- Negative control queries do not produce spurious canonical matches.
- Alias grouping keeps native-script and romanized variants together.
- Result ranking is stable across repeated runs.

## Measurement Notes
- Record latency for each query at least 10 times.
- Compute p50, p95, and p99 latency.
- Note any query that times out or returns zero results unexpectedly.

## Follow-Up Actions
- Attach the matrix to the staging search report.
- Re-run whenever alias logic or search ranking changes.
