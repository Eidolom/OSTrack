# Phase 0 Media Seed Targets

Last updated: 2026-04-09
Status: Draft

## Goal
Build the first ingestion set for OSTrack search and alias coverage before the 50k-scale expansion.

## Target Principles
- Prioritize globally recognizable OSTs with strong cross-platform presence.
- Include a balanced mix of games, anime, films/TV, and niche titles.
- Favor releases with stable metadata on Spotify, Apple Music, MusicBrainz, AniList, and IGDB.
- Include title variants that exercise alias and multilingual search logic.

## Batch Structure

### Batch 1 - Canonical Anchor Set
Purpose: establish clean, high-confidence examples for schema, aliasing, and search verification.

Recommended size: 250-500 OSTs

Examples:
- Final Fantasy series
- NieR / NieR:Automata
- The Legend of Zelda series
- Persona series
- Metal Gear Solid series
- Attack on Titan
- Cowboy Bebop
- Your Name
- Interstellar
- The Bear

### Batch 2 - High-Activity Community Set
Purpose: capture the titles that generate the most discussion and user search traffic.

Recommended size: 1,000-2,000 OSTs

Selection criteria:
- Most-followed OSTs in community spaces
- High-frequency soundtrack mentions on social platforms
- Broad regional availability
- Multi-album franchises with recurring composers

### Batch 3 - Alias Stress Test Set
Purpose: validate multilingual alias generation and title normalization.

Recommended size: 500-1,000 OSTs

Selection criteria:
- Japanese titles with English romanizations
- Korean titles with Hangul + Romaja variants
- Punctuation-heavy and symbol-heavy titles
- Long album or cue names
- Works with multiple official translations

### Batch 4 - Long Tail Expansion
Purpose: expand breadth into niche and community-maintained catalog gaps.

Recommended size: rolling batches until 50k+ threshold is met

Selection criteria:
- Visual novels
- Indie games
- Doujin works
- Obscure anime and TV specials
- Regional soundtrack variants

## Metadata Capture Per Title
For each target OST, capture:
- Canonical name
- Media source type
- Primary platform IDs
- Known aliases
- Composer(s)
- Release year
- Source confidence
- Notes on edge cases

## Ingestion Order
1. Media source record
2. Track list import
3. Alias generation and normalization
4. Composer linking
5. Platform ID mapping
6. Search indexing
7. Spot-check QA

## Initial QA Checks
- Duplicate title grouping is correct.
- Alias variants collapse to one track group.
- Search can find romanized, English, and native-script queries.
- Track counts match source expectations where source data is complete.

## Exit Criteria for Batch 1
- Batch 1 imported without blocking schema changes.
- Search results are stable for representative queries.
- QA spot-check pass rate is acceptable for review.
