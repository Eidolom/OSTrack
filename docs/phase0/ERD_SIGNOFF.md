# OSTrack Phase 0 ERD Sign-Off

Status: Draft for peer review
Owner: Product + Backend
Last updated: 2026-04-09

## Scope
This document is the schema sign-off package for Phase 0. Once approved, schema changes must include a migration plan.

## Core Entities

### media_sources
- id (uuid, pk)
- title (text, not null)
- media_type (enum: game, anime, film, tv, kdrama, other)
- release_year (int, nullable)
- igdb_id (text, nullable)
- anilist_id (text, nullable)
- created_at (timestamptz)
- updated_at (timestamptz)

### composers
- id (uuid, pk)
- canonical_name (text, not null)
- nationality (text, nullable)
- bio (text, nullable)
- verified (bool, default false)
- wikidata_id (text, nullable)
- created_at (timestamptz)
- updated_at (timestamptz)

### tracks
- id (uuid, pk)
- canonical_name (text, not null)
- canonical_lang (enum: ja, en, ko, ja_Latn, other)
- duration_seconds (int, nullable)
- media_source_id (uuid, fk -> media_sources.id)
- created_at (timestamptz)
- updated_at (timestamptz)

### track_composers
- track_id (uuid, fk -> tracks.id)
- composer_id (uuid, fk -> composers.id)
- sort_order (int, default 0)
- role (text, nullable)
- created_at (timestamptz)

Unique constraint:
- (track_id, composer_id)

### track_aliases
- id (uuid, pk)
- track_id (uuid, fk -> tracks.id)
- name (text, not null)
- lang (text, not null)
- source (enum: spotify, apple_music, musicbrainz, user_submitted, internal)
- verified (bool, default false)
- created_at (timestamptz)
- updated_at (timestamptz)

### track_platform_ids
- track_id (uuid, fk -> tracks.id)
- platform (enum: spotify, apple_music, youtube, youtube_music)
- platform_track_id (text, not null)
- created_at (timestamptz)

Unique constraint:
- (platform, platform_track_id)

### users
- id (uuid, pk)
- username (text, unique)
- email (text, unique)
- avatar_url (text, nullable)
- deleted_at (timestamptz, nullable)
- anonymized_at (timestamptz, nullable)
- recommendation_consent (bool, default false)
- created_at (timestamptz)
- updated_at (timestamptz)

### consent_log
- id (uuid, pk)
- user_id (uuid, fk -> users.id)
- consent_type (enum: essential, recommendations, marketing)
- granted (bool)
- ip_hash (text, not null)
- recorded_at (timestamptz)
- created_at (timestamptz)

### scene_timeline_entries
- id (uuid, pk)
- track_id (uuid, fk -> tracks.id)
- media_source_id (uuid, fk -> media_sources.id)
- description (text, not null)
- episode_chapter (text, nullable)
- timestamp_seconds (int, nullable)
- fidelity (enum: description, approximate, verified)
- submitted_by (uuid, fk -> users.id)
- verified_by (uuid, fk -> users.id, nullable)
- bounty_open (bool, default false)
- created_at (timestamptz)
- updated_at (timestamptz)

### scene_timeline_votes
- entry_id (uuid, fk -> scene_timeline_entries.id)
- user_id (uuid, fk -> users.id)
- created_at (timestamptz)

Unique constraint:
- (entry_id, user_id)

## Relationship Notes
- One media source can contain many tracks.
- One track can have many aliases, many platform IDs, many composer links, and many scene timeline entries.
- One composer can be linked to many tracks via track_composers.
- One scene timeline entry can have many votes, one vote per user.
- One user can submit many scene timeline entries, many votes, and many consent_log rows.

## Required Validation Rules
- Alias names are case-preserving but compared case-insensitively for duplicate detection per track.
- timestamp_seconds must be >= 0 when present.
- recommendation_consent defaults to false for all new users.
- ip_hash must never store raw IP values.
- release_year must be >= 1900 when present.
- sort_order must be >= 0.

## Open Decisions
- Canonical language policy approved: `canonical_lang` may use `ja_Latn` when the canonical release title is officially romanized; otherwise native script title remains canonical and romanization is represented as alias entries.

## Decision Rationale
- A join table supports multiple composers, ordering, and role annotations without array-query complexity.
- Separate composer entities avoid forcing non-user real-world composers into the users table.
- Votes modeled as rows prevent double-voting and remove race-prone integer counter writes.
- Native enums keep core state constrained and readable for the locked schema set at this phase.

## Locked Conventions
- language/source/fidelity/consent/platform values are treated as controlled enums.
- track composer relationships are modeled through joins, not arrays.
- scene timeline voting is modeled as one-row-per-user-per-entry, not a mutable integer source of truth.

## Index Plan (Phase 0 minimum)
- track_aliases(track_id)
- track_aliases(name)
- track_platform_ids(track_id)
- track_composers(composer_id)
- tracks(media_source_id)
- scene_timeline_entries(track_id)
- scene_timeline_entries(media_source_id)
- scene_timeline_votes(entry_id)
- users(deleted_at)

## Review Checklist
- [ ] Backend review completed
- [ ] Product review completed
- [ ] Data ingestion review completed
- [ ] Privacy review completed
- [ ] Migration policy agreed
- [ ] Schema decisions locked

## Sign-Off
- Technical owner:
- Product owner:
- Date:
