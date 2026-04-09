# OSTrack Phase 0 ERD Sign-Off

Status: Draft for peer review
Owner: Product + Backend
Last updated: 2026-04-09

## Scope
This document is the schema sign-off package for Phase 0. Once approved, schema changes must include a migration plan.

## Core Entities

### tracks
- id (uuid, pk)
- canonical_name (text, not null)
- canonical_lang (enum: ja, en, ko, other)
- duration_seconds (int, nullable)
- media_source_id (uuid, fk -> media_sources.id)
- created_at (timestamptz)
- updated_at (timestamptz)

### track_composers
- track_id (uuid, fk -> tracks.id)
- composer_id (uuid, fk -> users.id or composers.id depending on identity model)
- sort_order (int, default 0)
- role (text, nullable)

Unique constraint:
- (track_id, composer_id)

### track_aliases
- id (uuid, pk)
- track_id (uuid, fk -> tracks.id)
- name (text, not null)
- lang (text, not null)
- source (enum: spotify, apple_music, musicbrainz, user_submitted, internal)
- verified (bool, default false)

### track_platform_ids
- track_id (uuid, fk -> tracks.id)
- platform (enum: spotify, apple_music, youtube, youtube_music)
- platform_track_id (text, not null)

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

### consent_log
- id (uuid, pk)
- user_id (uuid, fk -> users.id)
- consent_type (enum: essential, recommendations, marketing)
- granted (bool)
- ip_hash (text, not null)
- recorded_at (timestamptz)

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
- upvotes (int, default 0)

## Relationship Notes
- One track can have many aliases and many platform IDs.
- One media source can contain many tracks.
- One track can have many scene timeline entries.
- One user can submit many scene timeline entries and many consent_log rows.

## Required Validation Rules
- Alias names are case-preserving but compared case-insensitively for duplicate detection per track.
- timestamp_seconds must be >= 0 when present.
- recommendation_consent defaults to false for all new users.
- ip_hash must never store raw IP values.

## Open Decisions
- Composer modeling: normalized to a `track_composers` join table rather than a `composer_ids` array on `tracks`.
- Enum strategy: use native Postgres enums for constrained values that are part of the locked Phase 0 schema surface.

## Decision Rationale
- A join table supports multiple composers, ordering, and role annotations without array-query complexity.
- Native enums keep core state constrained and readable for the locked schema set at this phase.

## Locked Conventions
- language/source/fidelity/consent/platform values are treated as controlled enums.
- track composer relationships are modeled through joins, not arrays.

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
