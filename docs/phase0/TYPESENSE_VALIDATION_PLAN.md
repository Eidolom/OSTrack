# Phase 0 Typesense Validation Plan

Status: Draft
Last updated: 2026-04-09

## Goal
Validate multilingual OST lookup quality and latency before Phase 0 exit.

## Index Requirements
- Include canonical track names and all aliases.
- Include language metadata for aliases.
- Support partial matching and typo tolerance.
- Include platform IDs as non-search filter fields.

## Test Dataset
Prepare a staging dataset with at least:
- 10,000 tracks (minimum smoke set)
- Japanese, English, Korean aliases for representative tracks
- Known edge cases (punctuation, apostrophes, hyphens, long titles)

## Functional Test Cases
- Query: tatakai
Expected: finds track entries also searchable by Japanese alias.

- Query: 戦いの時
Expected: resolves to same track group as romanized variant.

- Query: one winged
Expected: returns One-Winged Angel in top results.

- Query: Nier automata amusement park
Expected: returns intended OST entries despite spacing/case variance.

- Query: Korean Hangul and Romaja equivalents
Expected: both forms return equivalent result groups.

## Performance Benchmarks
- p95 query latency < 80ms in staging.
- p99 query latency < 120ms in staging.
- No query timeout under 50 concurrent search users.

## Observability
- Capture request latency percentiles.
- Capture zero-result query rate.
- Capture top 100 failed query strings per day.

## Exit Checks
- [ ] Functional multilingual tests pass
- [ ] Latency thresholds achieved
- [ ] Zero-result rate reviewed and accepted
- [ ] Regression checklist signed off
