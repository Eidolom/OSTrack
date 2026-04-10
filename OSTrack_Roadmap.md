# OSTrack — Product Roadmap
*Version 0.2 · April 2026*

## Current Build Status

- Phase: 0 — Foundation
- Focus: Flutter scaffold, seed catalog, onboarding flow, local persistence, settings, Auth0 login, Phase 0 deliverable docs
- [x] Project scaffold created
- [x] Starter counter app replaced
- [x] Data model and seed catalog
- [x] Auth and onboarding flow
- [x] Local preferences persistence (onboarding + platform)
- [x] Settings screen wired to preferences
- [x] Auth0-based Google + Apple login integration in onboarding Step 1
- [x] ERD sign-off draft package added
- [x] Typesense validation plan added
- [x] Staging infrastructure checklist added
- [x] Privacy Policy + Terms of Service draft docs added

### Implementation Log

- 2026-04-09 — Created the Flutter project scaffold in the existing workspace.
- 2026-04-09 — Replaced the starter app with a branded 5-tab OSTrack shell and page placeholders.
- 2026-04-09 — Added a structured seed catalog and wired the shell to read from it.
- 2026-04-09 — Added a multi-step onboarding flow that hands off into the main shell.
- 2026-04-09 — Added SharedPreferences-backed app bootstrap: onboarding state, selected platform, and onboarding choices now persist across restarts.
- 2026-04-09 — Added Settings screen from Profile for platform preference updates and onboarding reset.
- 2026-04-09 — Added auth service stubs and provider selection UX in onboarding Step 1.
- 2026-04-09 — Replaced auth stubs with Google Sign-In and Sign in with Apple SDK flows, plus typed auth error handling.
- 2026-04-09 — Wired native auth platform setup: Android Google Services Gradle plugin, iOS Apple Sign-In entitlements, and Google URL scheme placeholders.
- 2026-04-09 — Added credential templates and setup checklist (`AUTH_SETUP.md`) for final provider file drop-in.
- 2026-04-09 — Simplified auth to a single Auth0 Universal Login path and removed Firebase/GoogleService file requirements.
- 2026-04-09 — Fixed Android Auth0 callback wiring by setting `manifestPlaceholders["auth0Domain"]` to the active tenant domain used in app auth config.
- 2026-04-09 — Added Phase 0 ERD sign-off draft package (`docs/phase0/ERD_SIGNOFF.md`).
- 2026-04-09 — Added Typesense multilingual validation plan (`docs/phase0/TYPESENSE_VALIDATION_PLAN.md`).
- 2026-04-09 — Added staging infrastructure provisioning checklist (`docs/phase0/STAGING_INFRA_CHECKLIST.md`).
- 2026-04-09 — Added a concrete staging environment plan for app hosting, database, storage, search, CI/CD, and smoke tests (`docs/phase0/STAGING_ENVIRONMENT_PLAN.md`).
- 2026-04-09 — Added legal draft documents for Privacy Policy and Terms of Service (`docs/legal/PRIVACY_POLICY_DRAFT.md`, `docs/legal/TERMS_OF_SERVICE_DRAFT.md`).
- 2026-04-09 — Added a legal review plan to drive finalization of the Privacy Policy and Terms of Service (`docs/legal/LEGAL_REVIEW_PLAN.md`).
- 2026-04-09 — Added a Phase 0 execution backlog to drive completion of remaining exit criteria (`docs/phase0/PHASE0_EXECUTION_BACKLOG.md`).
- 2026-04-09 — Locked Phase 0 ERD decisions: composer relationships use a `track_composers` join table and constrained values use native Postgres enums.
- 2026-04-09 — Added initial Phase 0 seed target and ingestion batching plan (`docs/phase0/MEDIA_SEED_TARGETS.md`).
- 2026-04-09 — Added a concrete Typesense smoke-test matrix for multilingual search validation (`docs/phase0/TYPESENSE_SMOKE_TESTS.md`).
- 2026-04-09 — Refactored shared app contracts and UI primitives: moved `PreferencesUpdater` to `app_preferences.dart` and extracted backdrop/card/pill widgets into `lib/src/ostrack_widgets.dart` to remove shell-layer coupling.
- 2026-04-09 — Updated Phase 0 entry criteria wording to align with the open-data ingestion strategy instead of a VGMdb partnership prerequisite.
- 2026-04-09 — Removed committed Auth0 tenant values from tracked source files; auth config now uses `--dart-define` and local Android Gradle property overrides.
- 2026-04-09 — Updated ERD alias source enum to replace `vgmdb` with `musicbrainz` for launch-aligned ingestion sources.
- 2026-04-09 — Hardened ERD sign-off draft: added `media_sources`, `composers`, and `scene_timeline_votes`; resolved `track_composers` FK to `composers.id`; replaced mutable timeline vote counter design; added canonical language policy and baseline index plan.
- 2026-04-09 — Replaced stale inline Phase 0.1 schema snippets with a canonical pointer to `docs/phase0/ERD_SIGNOFF.md` to eliminate roadmap/ERD drift.
- 2026-04-09 — Clarified ERD semantics: `consent_log` keeps `recorded_at` only, and `track_platform_ids` explicitly uses a natural composite primary key `(track_id, platform)`.
- 2026-04-09 — UI/UX Step 1 foundation pass completed: new typography stack (Playfair Display, Space Mono, Outfit, DM Mono), desaturated palette tokens, flatter elevation model (no card shadows), and simplified solid backdrop baseline.
- 2026-04-09 — UI/UX Step 2 Home pass completed: redesigned On This Day as a featured editorial card and refactored feed activity cards with avatar-led social hierarchy and clearer activity metadata.
- 2026-04-09 — UI/UX Step 3 Explore pass completed: redesigned category tiles into destination-style art blocks with count labels and replaced trending rows with a horizontal artwork rail.
- 2026-04-09 — UI/UX Step 4 Library pass completed: redesigned Shelves into a visual grid (with create-shelf tile), added Ratings summary/list treatment, and converted History into timeline-style listening entries.
- 2026-04-09 — UI/UX Step 5 Profile pass completed: added collector identity hero, dedicated collector stats sheet, and horizontal shelf showcase tiles with richer visual treatment.
- 2026-04-09 — UI/UX Step 6 Player pass completed: redesigned player into an artwork-dominant card with quote-styled scene context and clearer primary/secondary action hierarchy.
- 2026-04-09 — UI/UX Step 7 micro-interaction pass started: added staggered reveal animations for Home feed cards to make feed entry feel more alive.
- 2026-04-09 — UI/UX Step 8 structure pass completed: replaced 5-tab nav with a 4-tab layout plus persistent mini-player context bar, and added a first fully navigable Media Source page (hero, rating distribution, tracklist expansion, scene tags, and forum tabs) wired from Explore tiles.
- 2026-04-09 — UI/UX Step 9 interaction pass completed: added player ambient color transitions when switching related tracks and implemented a tactile half-star rating widget with staggered fill, haptic pulses, and a brief completion burst.
- 2026-04-09 — UI/UX Step 9 polish follow-up: removed deprecated `withOpacity` usages across onboarding and shell UI surfaces; analyzer now reports zero issues.
- 2026-04-10 — Implemented the mascot monetization foundation: added persisted mascot ownership/equip state, a public Profile collection cabinet, and a mascot store with house, partnership, community, and founding catalog entries, purchase/equip actions, and settings/profile entry points.
- 2026-04-10 — Mascot monetization polish: replaced emoji placeholders with an animated sprite-style mascot renderer, gated background tickers for stable testing, and made the cabinet tier filters interactive.
- 2026-04-10 — Architecture upgrade: introduced `flutter_riverpod` for global preferences/auth state, wrapped the app in `ProviderScope`, and added `go_router` routes for `/`, `/onboarding`, `/home`, and `/store` with deep-link-aware redirects.
- 2026-04-10 — Router lifecycle fix: removed state-watching router recreation, added `refreshListenable` bridge via a Riverpod-backed `_RouterNotifier`, and switched route/redirect state access to `ref.read` to preserve navigation stack during preference/auth updates.

> This roadmap is organized into phases, not fixed calendar quarters. Each phase has clear **entry criteria** (what must be true before it starts) and **exit criteria** (what must be true before the next phase begins). Timelines are estimates assuming a small founding team of 3–5 engineers + 1 designer.

---

## Table of Contents
1. [Phase 0 — Foundation](#phase-0--foundation-months-0-2)
2. [Phase 1 — Private Beta](#phase-1--private-beta-months-2-5)
3. [Phase 2 — Public Launch](#phase-2--public-launch-months-5-8)
4. [Phase 3 — Community Scale](#phase-3--community-scale-months-9-14)
5. [Phase 4 — Monetization & Growth](#phase-4--monetization--growth-months-15-20)
6. [Phase 5 — Platform Expansion](#phase-5--platform-expansion-months-21)
7. [Parallel Tracks](#parallel-tracks)
8. [Risk Register](#risk-register)
9. [Success Metrics](#success-metrics)

---

## Phase 0 — Foundation `Months 0–2`

*Build the skeleton. Nothing user-facing ships in this phase.*

### Entry Criteria
- Core team assembled (minimum: 2 backend, 1 Flutter, 1 design)
- Legal entity formed
- Open-data ingestion source stack defined (Spotify, Apple Music, MusicBrainz, AniList, IGDB)

### Goals
Get the data model right before writing a single UI component. Migrations are expensive; a bad schema is a tax you pay forever.

---

### 0.1 — Data Architecture

**Track Aliasing Engine**

Design and implement the multi-language alias schema. This is the most load-bearing decision in the entire backend.

Canonical schema source of truth:
- [docs/phase0/ERD_SIGNOFF.md](docs/phase0/ERD_SIGNOFF.md)

This roadmap intentionally avoids duplicating full table snippets to prevent drift. Any Phase 0 schema updates must be made in the ERD sign-off document first.

**Deliverable:** Full ERD reviewed and signed off. No schema changes allowed after Phase 0 exit without a formal migration plan.

---

### 0.2 — Data Pipeline

VGMdb is the gold standard for game/anime OST metadata but is historically closed to developers with no prior track record — partnership attempts at this stage are likely to be ignored or declined. The strategy below achieves equivalent coverage through freely accessible APIs and a community bootstrap, with VGMdb treated as a post-traction nice-to-have.

**Cross-Platform Alias Harvesting (Primary)**

The core insight: the same OST on Spotify and Apple Music often carries different romanizations and English translations. Diffing the two gives alias pairs automatically — without any gated partnership.

```
For each target OST:
  1. Query Spotify Web API → tracklist in romanized Japanese + English titles + Spotify track IDs
  2. Query Apple Music API  → same album, often different romanizations or translations
  3. Diff title variants    → auto-generated alias pairs
  4. Cross-ref MusicBrainz  → append any kanji/hangul forms on record
  5. Result: 3-language alias set, zero partnerships required
```

Run this pipeline across the top 1,000 OSTs by community popularity and you have a strong alias corpus before a single user signs up.

**Source Stack by Role**

| Source | Role | Access |
|---|---|---|
| Spotify Web API | Track metadata, romanized aliases, platform IDs, ISRCs | Free, instant approval |
| Apple Music / MusicKit | Cross-reference titles, catch romanization discrepancies | Free, easy registration |
| MusicBrainz | Film/TV OST coverage, ISRC linkage, supplementary game data | Free, fully open |
| AniList API | Anime media source pages — titles in romaji, kanji, English simultaneously | Free, no API key required |
| IGDB (Twitch) | Game media source pages — release dates, genres, studios | Free, Twitch login |
| YouTube Data API | Composer credits from official uploads, fallback track IDs | Free quota, generous |
| Wikidata | Composer profiles, work relationships, cross-linked discographies | Free, open SPARQL |
| Community seeding | Gap-filling, deep cuts, doujin/indie titles, kanji corrections | Founding Archivist drive |
| VGMdb | Pursue post-traction from a position of scale | Future nice-to-have |

**Ingestion Priority Order**

1. Media source scaffold first — build game/anime/film pages from IGDB + AniList (fast, structured)
2. Attach tracks — pull tracklists from Spotify + Apple Music per media source
3. Alias layer — diff platform titles, append MusicBrainz kanji forms
4. Composer linking — Wikidata SPARQL queries for composer → works relationships
5. Platform ID mapping — store Spotify + Apple Music + YouTube IDs per track for playback routing

**Community Bootstrap — Founding Archivist Drive**

Recruit 50–100 beta users from OST communities (r/gamindustri, r/anime, dedicated Discord servers, VGMdb's own forum). These are fans who've been contributing to VGMdb for years with no social layer or recognition. Offer them a "Founding Archivist" badge — permanently non-earnable after Phase 2 launch — and first-class contribution tools from day one. Their domain knowledge fills the gaps no API can cover: doujin game music, obscure OVA BGMs, regional release variants.

**Target: 50,000+ tracks seeded with alias coverage before beta opens.**

**Typesense Index**
- Index all tracks including all alias variants across all ingested languages
- Validate: query `tatakai` resolves same as `戦いの時` resolves same as `time of battle`
- Validate: Korean Hangul + Romaja crossover queries
- Validate: partial title matching (e.g. `one winged` finds `One-Winged Angel`)

**Deliverable:** Search index live in staging. Benchmark: p95 query latency < 80ms.

---

### 0.3 — Infrastructure Setup

| Component | Decision |
|---|---|
| Hosting | Railway or Render for MVP (migrate to AWS/GCP post-scale) |
| Database | Supabase (PostgreSQL + Auth + Storage bundled) |
| CDN / Storage | Cloudflare R2 (Originals audio, artwork) |
| Search | Typesense Cloud |
| Push Notifications | Firebase Cloud Messaging |
| CI/CD | GitHub Actions → TestFlight (iOS) + Play Internal Track (Android) |
| Error Monitoring | Sentry |
| Analytics | PostHog (self-hostable, privacy-respecting) |

**Deliverable:** All infrastructure provisioned. Staging environment mirrors production config.

---

### Phase 0 Exit Criteria
- [ ] ERD finalized and peer-reviewed
- [ ] 50k+ tracks seeded with alias coverage
- [ ] Typesense index passing multilingual search tests
- [ ] All infrastructure provisioned in staging
- [ ] Legal: Privacy Policy + Terms of Service drafted (GDPR-compliant)

---

## Phase 1 — Private Beta `Months 2–5`

*Ship something real to a small, trusted audience. Prioritize depth over breadth.*

### Entry Criteria
- Phase 0 exit criteria met
- Flutter app scaffolding complete (navigation, design system, auth)
- 5–10 beta testers identified from OST community (Discord, Reddit, VGMdb)

### Goals
Validate the core loop: **discover → catalog → discuss → share**. Get real data on which features resonate and which have friction. Scene Timeline contribution UX is the primary experiment.

---

### 1.1 — Core App (Flutter)

**Design System**
- Pixel-modern aesthetic implemented as Flutter theme
  - Press Start 2P for display/labels, DM Mono for body
  - Gold (#FFD600) + Teal (#00FFCC) accent palette
  - Dark default, light mode toggle
  - Pixel corner cutouts, scanline textures, ambient glow effects
- Reusable component library: TrackCard, MediaHero, ShelfTile, ComposerBadge

**Authentication**
- Google Sign-In + Apple Sign-In (primary)
- Consent flow at end of onboarding (essential vs. recommendation profiling — separate prompts)

**Onboarding**
- Step 1: Sign up
- Step 2: Pick 5+ media — visual grid with large cover art tiles, satisfying tap animations
- Step 3: Link streaming platform (Spotify / Apple Music / YouTube Music — skippable)
- Step 4: Follow 3–5 suggested users (seeded from beta cohort)
- Step 5: Home feed (pre-seeded, never empty)

---

### 1.2 — Core Features (Beta Scope)

**Media Source Pages**
- Full tracklist with individual track ratings
- Community aggregate score
- Composer links
- Basic metadata (year, label, track count)
- Forum thread (one thread per OST)

**Track Pages**
- Rating widget
- Scene Timeline entries (read + contribute)
- Platform playback launcher

**Scene Timeline Contribution Flow** *(primary UX experiment)*
- Three-fidelity input: description only → episode/chapter → timestamp
- "Tag Queue": bookmark a track to tag later
- Bounty flag: "I need a timestamp for this"
- Moderation: submitted entries show 🌀 until verified by Trusted Contributor

**Shelves**
- Create, name, add tracks
- Public/private toggle
- Visible on profile

**Profile**
- Avatar, bio, stats
- Public shelves
- Activity log
- Follower / following

**Playback**
- Spotify App Remote SDK integration (in-app control, no app-switch)
- Apple MusicKit native integration
- YouTube deep-link fallback
- Platform selector on Player screen

---

### 1.3 — OSTrack Originals — Soft Launch

- 20–30 tracks commissioned and cleared before beta opens
- Categories: piano solos, lo-fi arrangements, orchestral re-scores
- Native in-app playback via Cloudflare Stream
- Originals drop card in Home feed

---

### 1.4 — Beta Instrumentation

Track every action that matters for validating the core loop:

| Event | Why |
|---|---|
| `shelf_created` | Social currency adoption |
| `timeline_entry_submitted` | Contribution friction test |
| `timeline_bounty_opened` | Demand signal for timestamps |
| `track_played` | Platform routing success rate |
| `platform_switch` | Preference data |
| `search_zero_results` | Alias coverage gaps |
| `onboarding_completed` | Drop-off funnel |

---

### Phase 1 Exit Criteria
- [ ] 50+ active beta users, 2+ weeks of retention data
- [ ] At least 200 scene timeline entries submitted organically
- [ ] Search zero-results rate < 5% for known tracks
- [ ] Playback routing success rate > 90% (Spotify + Apple Music combined)
- [ ] No critical GDPR compliance gaps identified in external review
- [ ] NPS from beta cohort ≥ 40

---

## Phase 2 — Public Launch `Months 5–8`

*Open the doors. First impression is permanent.*

### Entry Criteria
- Phase 1 exit criteria met
- App Store + Play Store submissions approved
- Press kit ready; 3+ OST-community publications briefed

### Goals
Establish OSTrack as the real thing — not another music app, but the home for soundtrack culture. The launch narrative centers on Scene Timelines and OSTrack Originals as the two proof points.

---

### 2.1 — Launch Hardening

**Performance**
- Cold start time < 2s on mid-range Android
- Feed load time < 1s (Redis cache warm)
- Image lazy-loading with pixelated placeholder (aesthetic AND functional)

**Stability**
- Crash-free rate target: > 99.5%
- Sentry alerts on P0/P1 errors with 15-min response SLA

**Moderation**
- Minimum viable mod tooling: flag content, temp-ban, delete entry
- Elect 5–10 Trusted Contributors from beta cohort before launch

**Localization**
- English (default), Japanese, Korean UI strings
- Right-to-left not required at launch (no Arabic/Hebrew target languages)

---

### 2.2 — Launch Features (Additions to Beta)

**On This Day Notifications**
- Anniversary detection engine: cross-reference media release dates against user's history and shelves
- Notification design: cinematic card with artwork parallax
- Anniversary banner on Media Source Page on relevant dates

**Weekly Digest**
- Every Sunday, 9am local time
- Top-rated OSTs of the week, filtered to user's active categories
- "Hidden gem of the week" — high-rated, low-traffic pick

**Explore Screen — Full Launch**
- Category tiles (Games, Anime, Film, TV, K-Drama, Composers, Originals)
- Per-category: Trending / New Releases / Hidden Gems sections
- In-category search with Typesense

**Ad Integration**
- Native feed cards (every 8–10 content cards)
- Category page banners
- Targeting: media category preference only (no behavioral data sold)
- Ad partner: start with direct outreach to anime/game streaming services (Crunchyroll, Funimation, Nintendo eShop)

---

### 2.3 — Database Expansion Sprint

Goal: hit 250,000 tracks across all categories before launch day.

| Category | Target Track Count |
|---|---|
| Video Games | 120,000 |
| Anime | 80,000 |
| Movies & TV | 35,000 |
| K-Drama | 15,000 |

Run a **Community Contribution Drive** during the final 3 weeks of this phase — beta users who add verified metadata entries get a "Founding Contributor" badge on their profile permanently.

---

### Phase 2 Exit Criteria
- [ ] 10,000 downloads in first 30 days
- [ ] Day-7 retention ≥ 35%
- [ ] 250,000+ tracks in catalog
- [ ] Scene Timeline: 2,000+ verified entries
- [ ] Zero P0 GDPR compliance incidents
- [ ] OSTrack Originals catalog: 60+ tracks

---

## Phase 3 — Community Scale `Months 9–14`

*The app works. Now make the community self-sustaining.*

### Entry Criteria
- 50,000+ registered users
- Trusted Contributor system active with 50+ contributors
- Revenue from ads covering basic infrastructure costs

### Goals
Shift from "team maintains the platform" to "community maintains the platform." The Scene Timeline database, alias corrections, and metadata quality must become community-owned.

---

### 3.1 — Reputation & Contribution System V2

**Contributor Points**
Earned through:
- Accepted scene timeline entries (+10 pts per fidelity level achieved)
- Timeline bounties resolved (+25 pts)
- Alias submissions accepted (+5 pts)
- Forum posts upvoted (+1 pt each, capped at +20/post)
- Shelves reaching 50+ followers (+15 pts)

**Tiers**
| Tier | Points | Privileges |
|---|---|---|
| Listener | 0 | Standard user |
| Archivist | 100 | Can verify other users' scene tags |
| Chronicler | 500 | Can approve alias submissions, pin forum posts |
| Curator | 1,500 | Can nominate tracks for Originals arrangements, early feature access |
| Lorekeeper | 5,000 | Advisory role, direct line to OSTrack team |

**Founding Contributor Badge** — permanent, awarded to users who contributed during the beta/launch drive. Non-earnable after Phase 2 ends.

---

### 3.2 — Scene Timeline V2

- **Timestamp Verification Mode:** Show two submitted timestamps side-by-side; community votes on correct one
- **Scene type tags:** standardized vocabulary (boss fight, exploration, cutscene, credits, title screen, combat, emotional, ambient)
- **Spoiler graduation:** entries marked as spoilers require account age > 7 days to view, collapsible by default
- **Timeline visualization:** horizontal scrubber on Track Page showing all tagged moments

---

### 3.3 — Composer Profiles V2

- Official composer verification program (outreach to indie composers first)
- Verified composers can add bio, link to their own platforms, post announcements
- "Composed for OSTrack Originals" badge
- Direct tip/support links (Bandcamp, Patreon) on verified profiles — OSTrack takes no cut (goodwill play)

---

### 3.4 — Recommendation Engine V2

- Upgrade from basic collaborative filtering to a hybrid model:
  - Collaborative filtering (users with similar taste)
  - Content-based filtering (same composer, mood tags, instrumentation)
  - Editorial signals (Trusted Contributor shelf follows)
- Recommendation explanations: "Because you loved NieR:Automata" — shown on feed cards
- Opt-in users only; GDPR-partitioned data pipeline

---

### 3.5 — Expanded Originals Program

- **Open submissions:** Any composer can submit a CC-licensed original or arrange a commission
- **OSTrack Originals Collections:** themed monthly mini-albums (e.g., "Final Boss Season," "Rainy Day BGMs")
- **Composer revenue share:** Originals commission income shared 70/30 with arranger
- Target: 250+ Originals tracks by end of Phase 3

---

### Phase 3 Exit Criteria
- [ ] 150,000+ registered users
- [ ] Day-30 retention ≥ 25%
- [ ] 100+ Trusted Contributors active monthly
- [ ] Scene Timeline: 20,000+ entries, 70%+ verified
- [ ] Recommendation engine serving opt-in users with measurable lift in session length
- [ ] 250+ OSTrack Originals tracks

---

## Phase 4 — Monetization & Growth `Months 15–20`

*Ads are proving but not scaling. Introduce the premium tier and direct licensing.*

### Entry Criteria
- 150,000+ registered users
- Retention metrics stable
- Ad revenue covering infrastructure + half of team cost

### Goals
Introduce OSTrack Pro without alienating the core user base. Begin the licensing conversations that Phase 1 made possible by building scale.

---

### 4.1 — OSTrack Pro

**Pricing:** $3.99/month · $29.99/year

**Included in Pro:**
- Ad-free experience (all placements removed)
- Unlimited listening history (free tier: 90 days)
- Advanced shelf tools: custom sort order, export to CSV, shelf analytics (top track, most played week)
- Early access to Originals drops (48hr before free users)
- Profile customization: animated avatar border, custom shelf cover art
- Extended search filters: mood, era, instrumentation, scene type

**What stays free:** Every core feature — shelves, scene timelines, ratings, forums, discovery, recommendations. Pro is pure enhancement, never gating.

**Pricing philosophy:** At $3.99/month, OSTrack Pro is priced to feel like a complement to Spotify, not a competitor. A user who already pays $11/month for Spotify should feel zero friction adding $4 for the context layer on top.

---

### 4.2 — Direct Licensing Program

Use platform scale as leverage to approach rights holders directly.

**Tier 1 — Indie Composers (Immediate)**
- Composers who own their own masters (most indie game devs, many anime composers)
- Offer: revenue share on Originals + "licensed streaming" badge on their Media Source Page
- Target: 20+ direct agreements by end of Phase 4

**Tier 2 — Mid-tier Publishers**
- Companies like Nippon Columbia, Lantis, Aniplex (anime OST specialists)
- Offer: promoted placement + revenue share
- Realistic timeline: 6–12 month negotiation cycles

**Tier 3 — Major Labels / Game Publishers**
- Square Enix, Sony Music, Konami, Capcom
- These take years. Begin relationship-building now; don't plan revenue around it.

---

### 4.3 — Web Companion App

- Read-only web interface for catalog browsing and profile viewing
- Useful for shareable links (shelf URLs, media source pages, composer profiles)
- Drives acquisition: Google indexes OSTrack's catalog pages
- Tech: Next.js, same API as mobile
- No playback on web (SDK limitations) — link out to platforms

---

### Phase 4 Exit Criteria
- [ ] OSTrack Pro: 5,000+ paying subscribers (≈ 3% conversion of 150k users)
- [ ] Pro MRR covering 60%+ of operating costs
- [ ] 20+ direct licensing agreements with indie composers
- [ ] Web companion app live with SEO indexing
- [ ] App Store rating ≥ 4.6 stars

---

## Phase 5 — Platform Expansion `Month 21+`

*OSTrack has an identity, a community, and a revenue base. Now grow the ceiling.*

### Goals
Expand into adjacent use cases without diluting the core product identity.

---

### 5.1 — OSTrack for Composers

A creator-facing layer for the composers OSTrack already hosts.

- **Analytics dashboard:** See where in the world your music is cataloged, which tracks are most scene-tagged, which shelves you appear in
- **Direct fan connection:** Post listening notes, production stories, alternate takes
- **Commissions marketplace:** Fans can commission a personalized arrangement through OSTrack; composer sets price, OSTrack handles transaction (15% fee)

---

### 5.2 — Live Event Integration

- Concert and live performance pages: anime symphony orchestras, game music concerts (like Distant Worlds)
- "I attended this" check-in for live events — links to setlist, which OSTrack tracks were performed
- Pre-concert shelf builder: "going to see a Nobuo Uematsu concert — here's my setlist prediction"

---

### 5.3 — API Access Program

- Public read API for OSTrack catalog data (track metadata, aliases, scene tags)
- Rate-limited free tier; Pro API tier for developers
- Use case: fan wikis, game databases, anime databases can embed OSTrack track data
- Drives inbound links and catalog trust

---

### 5.4 — Label & Publisher Partnership Program

By this phase, the platform has enough scale to negotiate structured deals.

- Formal partnership tiers with rights holders
- Co-branded "Official Soundtrack" verified pages (like Twitter's verified accounts)
- Publishers can submit corrections to their own catalog entries
- Promotional tools: featured placement during media release windows (a new game drops → its OST is featured on OSTrack launch day)

---

## Parallel Tracks

These workstreams run continuously across all phases, not tied to a single phase.

### Security & Compliance (Ongoing)
- Annual GDPR audit
- Penetration testing before each major launch
- COPPA assessment if under-13 usage is detected
- SOC 2 Type II consideration at Phase 4+ scale

### Community Health (Ongoing)
- Quarterly moderation review: are Trusted Contributors burning out?
- Spoiler policy evolution as catalog grows
- Harassment and ban appeal process
- Transparency reports (how many entries moderated, why) — builds trust with power users

### Originals Pipeline (Ongoing)
- Maintain 2–4 new Originals per week cadence
- Quarterly "Originals Collection" drops (themed mini-albums)
- Composer roster diversity: ensure geographic and genre spread
- Quality bar: every Originals track reviewed by internal team before publish

### Metadata Quality (Ongoing)
- Weekly automated scan: tracks with zero aliases flagged for community attention
- Bounty leaderboard: most resolved timestamp bounties per month, featured on Explore
- Cross-platform re-sync: re-query Spotify + Apple Music for updated metadata quarterly
- VGMdb relationship: revisit partnership once platform reaches 150k+ users (Phase 3)

---

## Risk Register

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| VGMdb refuses data partnership | High | Low | No longer a dependency — cross-platform alias harvesting + community bootstrap is the primary strategy; VGMdb is post-traction nice-to-have |
| Spotify Web API access revoked or terms changed | Low | High | Apple Music + MusicBrainz cover the gap; alias data already ingested is retained in our own DB |
| Apple Music API changes break alias pipeline | Low | Medium | Spotify alone provides most alias pairs; pipeline is multi-source by design |
| Spotify App Remote SDK deprecated | Low | High | Apple MusicKit + YouTube fallback always maintained in parallel |
| GDPR enforcement action | Low | Critical | Consent architecture baked in from Phase 0; legal counsel engaged before launch |
| Scene Timeline stays empty (contribution failure) | Medium | High | Bounty system + Founding Archivist drive; team seeds top 100 OSTs manually |
| Core community hostile to ads | Medium | Medium | Ads never interrupt playback or forum reading; Pro tier available early |
| Copycat app from well-funded competitor | Medium | Medium | Community moat is the defense — Originals catalog + Trusted Contributor network can't be bought overnight |
| Apple MusicKit licensing terms change | Low | Medium | Maintain YouTube fallback; SDK abstraction layer allows swap |
| Key composer dies or withdraws Originals license | Low | Low | Contracts include archival clause; CC-licensed tracks unaffected |
| Community seeding fails to attract Founding Archivists | Low | Medium | VGMdb, r/gamindustri, OST Discord servers are rich recruiting grounds; badge incentive is strong for this demographic |

---

## Success Metrics

### North Star Metric
**Monthly Active Catalogers** — users who rate, shelf, tag, or review at least once per month. Not passive listeners. Active collectors.

### Phase Gates

| Metric | Phase 1 Target | Phase 2 Target | Phase 3 Target | Phase 4 Target |
|---|---|---|---|---|
| Registered users | 500 | 10,000 | 150,000 | 300,000 |
| Monthly Active Catalogers | 200 | 4,000 | 60,000 | 120,000 |
| Day-7 retention | 40% | 35% | 35% | 38% |
| Day-30 retention | — | 20% | 25% | 28% |
| Scene Timeline entries (verified) | 200 | 2,000 | 20,000 | 80,000 |
| Tracks in catalog | 50,000 | 250,000 | 400,000 | 600,000 |
| OSTrack Originals tracks | 30 | 60 | 250 | 500 |
| Pro subscribers | — | — | — | 9,000 |
| App Store rating | — | 4.4+ | 4.5+ | 4.6+ |

### Anti-Metrics (Things We Actively Avoid Optimizing)
- **Session length** — we don't want to trap users; we want them to find what they love and go listen to it
- **Notification open rate** — we'd rather send 2 meaningful notifications than 10 engagement-bait ones
- **Ad impressions per session** — revenue, yes; hostile UX, never

---

*Document version 0.3 · OSTrack Product Team · April 2026*
*This is a living document. Update after each phase retrospective.*
