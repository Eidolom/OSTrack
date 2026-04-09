# OSTrack — App Design Document
*A social cataloging and discovery platform for OST & BGM enthusiasts*

---

## Table of Contents
1. [Vision & Concept](#vision--concept)
2. [Target Audience](#target-audience)
3. [Media Categories](#media-categories)
4. [Core Features](#core-features)
5. [Screen Architecture](#screen-architecture)
6. [Onboarding Flow](#onboarding-flow)
7. [Content Strategy — OSTrack Originals](#content-strategy--ostrack-originals)
8. [Copyright & Legal Strategy](#copyright--legal-strategy)
9. [Social & Community Layer](#social--community-layer)
10. [Discovery & Recommendations](#discovery--recommendations)
11. [Notifications](#notifications)
12. [Monetization](#monetization)
13. [Design Direction](#design-direction)
14. [Tech Stack](#tech-stack)
15. [Open Questions](#open-questions)
16. [Roadmap](#roadmap)
17. [Architectural Pressure-Test & Enhancements](#architectural-pressure-test--enhancements)

---

## Vision & Concept

OSTrack is the definitive home for soundtrack culture. While mainstream music apps treat OSTs as a genre, OSTrack treats them as *worlds* — inseparable from the media that gave birth to them, full of context, memory, and meaning that casual listeners barely scratch the surface of.

The closest analogies:
- **Letterboxd** — for the social cataloging and community identity layer
- **MusicBrainz** — for deep, community-maintained metadata
- **Last.fm** — for listening history and taste-based discovery
- **Bandcamp** — for the ethos of supporting composers directly

But none of those exist for soundtrack culture specifically. OSTrack fills that gap.

> *"Every piece of music has a scene it belongs to. OSTrack remembers it."*

---

## Target Audience

**Primary: Hardcore fans & collectors**
People who know the difference between a battle theme and a boss theme. Who have opinions on whether Yoko Shimomura or Nobuo Uematsu defined the JRPG sound. Who rewatch a scene just to isolate the cue. Who seek out vinyl pressings of game OSTs.

**Secondary (future growth):** Casual listeners who discover the app through a friend's shelf or a viral "On This Day" notification.

---

## Media Categories

| Category | Examples |
|---|---|
| **Video Games** | Final Fantasy, Elden Ring, Undertale, The Legend of Zelda, NieR |
| **Anime** | Attack on Titan, Cowboy Bebop, Your Name, Demon Slayer |
| **Movies & TV** | Interstellar, The Bear, Twin Peaks, Dune |
| **K-Dramas** | Goblin, My Mister, Reply 1988 |
| **Other** | Visual novels, indie games, web series, short films |
| **OSTrack Originals** | In-house copyright-free and commissioned cover arrangements |

---

## Core Features

### 1. Media Source Pages
Each game, anime, series, or film gets a dedicated page — the canonical reference point for that soundtrack in the app.

**A Media Source Page contains:**
- Full tracklist with individual track ratings
- Overall community score (aggregate of track ratings)
- Composer(s) linked to their profile pages
- Release info: year, label, physical formats (vinyl, CD)
- Scene Timeline — community-tagged moments for each track
- Forum thread for general discussion
- "Add to Shelf" shortcut
- Playback launcher (routes to user's linked platform)

**Example:** *Elden Ring* page shows all 285 tracks, links to Yuka Kitamura and Tsukasa Sagi, notes that "Margit, the Fell Omen" plays at the first legacy dungeon boss, and has a forum thread debating whether the Crumbling Farum Azula themes are the best in FromSoftware history.

---

### 2. Scene Timelines
The feature that sets OSTrack apart from every other music app. Users tag where a track appears in context — not just metadata, but *memory*.

**Tags can include:**
- Scene description: *"plays during the final confrontation with Sephiroth"*
- Episode/chapter: *"Episode 7, ~22:14"*
- Emotional context: *"this starts when [spoiler] dies"*
- Game context: *"ambient BGM in Majula, Dark Souls II"*

**Contribution model:** Open submission, reviewed by a pool of trusted community moderators (earned through activity and reputation). Think Wikipedia with a lighter editorial layer.

---

### 3. Composer & Artist Profiles
Full pages for composers, arrangers, and performing artists.

**Profile contains:**
- Bio and nationality
- Full discography within OSTrack's catalog
- Community ratings across their work
- Forum thread
- Cross-linked media (all games/films they've scored)
- "Most loved tracks" — community-curated highlight reel

**Notable profiles at launch:** Nobuo Uematsu, Yoko Shimomura, Joe Hisaishi, Yasunori Mitsuda, Hans Zimmer, Akira Yamaoka, Yuka Kitamura, Toby Fox, Jung Jae-il, Yann Tiersen.

---

### 4. Public Shelves
The social currency of OSTrack. Shelves are named, curated collections of tracks or OSTs — the collector's answer to a playlist, but with personality and permanence.

**Shelf features:**
- Custom name and cover image
- Public or private toggle
- Followable by other users
- Featured on profile like a record shelf / bookcase
- Can mix tracks from different media freely
- Optional description / liner notes

**Example shelves:**
- *"Tracks that make me feel like I'm the protagonist"*
- *"Best use of silence in a score"*
- *"OSTs that hit harder after you finish the game"*
- *"Crying in the car playlist"*

---

### 5. Discussion Forums
Threaded comment sections attached to every Media Source Page, Composer Page, and individual Track Page. Not a separate social network — always anchored to content.

**Forum features:**
- Nested replies
- Spoiler tags (critical for story-heavy games/anime)
- Upvoting
- Mod tools for community-elected moderators
- Pinned "Staff Pick" threads for high-quality discussions

---

### 6. Track Pages
The atomic unit of OSTrack. Every individual track gets its own page.

**Track Page contains:**
- Composer, arranger, performers
- Parent OST / Media Source link
- Scene Timeline entries (community-tagged)
- Community rating
- Available arrangements/covers (including OSTrack Originals)
- Playback launcher
- "Add to Shelf" + quick rating action
- Related tracks (same composer, same mood)
- Comments

---

### 7. Flexible Playback
OSTrack is a *context layer*, not a music player. Users link their preferred streaming service during onboarding. Tapping play on any track launches it in the linked platform, or uses the native OSTrack player for Originals.

**Supported platforms:**
- Spotify
- Apple Music
- YouTube Music
- YouTube (fallback for tracks not on streaming)

**OSTrack Originals** play natively in-app — the only audio OSTrack hosts itself.

---

## Screen Architecture

### Bottom Navigation (5 tabs)
`Home` · `Explore` · `Library` · `Player` · `Profile`

---

### 🏠 Home — Social Feed
Activity stream from followed users. OSTrack's pulse.

**Feed card types:**
- *Shelf activity* — "@yukirose added 'One-Winged Angel' to 'Tracks That Changed Me'"
- *New review* — "@ostnerdd reviewed the NieR:Automata OST ★★★★★"
- *Scene tag* — "@melodyarchive tagged a moment in Shadow of the Colossus"
- *Originals drop* — "New OSTrack Original: Zelda's Lullaby (Orchestral)"
- *On This Day* — "10 years ago, Bloodborne released. Here's its most loved track."

Ad placements appear as native cards, between every ~8–10 content cards.

---

### 🔍 Explore — Category Browser
No search bar on the landing screen. Entry is intentional and visual — large tiles for each category.

```
[ Video Games ]   [ Anime ]
[ Movies & TV ]   [ K-Drama ]
[ Composers ]     [ Originals ]
```

Inside each category:
- **Trending** — most activity this week
- **New Releases** — recently added OSTs
- **Hidden Gems** — high-rated, low-traffic
- **Search bar** — available inside categories, not globally

---

### 📚 Library — Personal Space
The collector's control center. Three sub-tabs:

**Shelves** — all shelves (public and private), with drag-to-reorder  
**Ratings** — every track/OST rated, filterable by category, era, composer  
**History** — full listening log; feeds the recommendation engine

---

### ▶️ Player — Dedicated Screen
A full-tab player, not just a mini-bar. OST listeners study what they hear.

**Player screen contains:**
- Track + OST artwork (full bleed, cinematic)
- Composer name, linked
- Media source badge (e.g. "From: Hollow Knight")
- Scene timeline tag for current track
- Platform selector — swap streaming service on the fly
- Rating widget — rate without leaving the player
- "Related tracks" horizontal scroll
- Quick-add to shelf

---

### 👤 Profile — Collector Identity
Public-facing page. This is a fan's *taste identity*.

**Profile contains:**
- Avatar, bio, location (optional)
- Favorite media badges (pinned, user-chosen)
- Public shelves — displayed as a visual shelf/rack
- Stats panel: total ratings, top category, top composer, most active month
- Recent activity log
- Followers / Following counts

---

### Supporting Screens

| Screen | Purpose |
|---|---|
| Media Source Page | Full OST hub for one game/film/show |
| Composer Page | Full discography + community discussion |
| Track Page | Individual track detail, tags, covers, comments |
| OSTrack Originals Hub | Browse & play native copyright-free content |
| Shelf Detail | View/edit a shelf, see followers |
| Notifications Center | Aggregated alerts |
| Settings | Platform links, theme, notification prefs |

---

## Onboarding Flow

Designed to be fast, delightful, and immediately personal. No walls of text.

### Step 1 — Sign Up
*(Decision pending — recommend: Social login first, email as fallback. See Open Questions.)*

### Step 2 — Pick Your Worlds *(the hook)*
A scrollable, visually rich grid of 40–60 media titles with cover art. Users tap to select 5 or more they love.

> *"Pick at least 5 soundtracks you love. We'll do the rest."*

Covers are large, beautiful, recognizable — Final Fantasy VII, Spirited Away, Parasite, The Last of Us, Cowboy Bebop. Tapping one gives a satisfying selection animation.

### Step 3 — Link Your Platform
One-tap connection to Spotify, Apple Music, or YouTube Music. Skippable — can be done later in Settings.

### Step 4 — Follow Suggestions
3–5 suggested users based on selected media. Optionally import contacts.

### Step 5 — Home Feed
Lands directly in a pre-seeded feed with activity from followed users and recommended content based on selections. No empty state.

---

## Content Strategy — OSTrack Originals

OSTrack Originals is the app's native content moat — the one thing no competitor can simply replicate.

### Two Content Streams

**Stream A — Copyright-Free Originals**
Curated catalog of OSTs released under Creative Commons or similar licenses. Primarily:
- Indie game composers (itch.io ecosystem is rich here)
- Composers who self-release CC versions of their work
- Public domain scores (pre-1928 film music, classical game arrangements)

**Stream B — Commissioned Arrangements**
OSTrack partners with independent arrangers and musicians to create high-quality re-arrangements of beloved OSTs, cleared via mechanical licenses.

**Arrangement styles:**
- Orchestral re-arrangements
- Lo-fi / study versions
- Piano solos
- Jazz arrangements
- Chiptune / demake versions

**Legal path:** Mechanical licenses (~$0.21/track via services like Songfile or DistroKid). OSTrack owns the master of each commissioned arrangement; the underlying composition royalty is paid and cleared.

### Editorial Voice
Originals are released with liner notes — a short piece about the arranger, why this track was chosen, what the arrangement explores. Drops feel like events, not uploads.

### Release Cadence
- 2–4 new Originals per week at launch
- "Drop" notifications for followers
- Monthly "Originals Collection" — a curated mini-album

---

## Copyright & Legal Strategy

### Guiding Principle
OSTrack is a **metadata and community platform first**. It does not host, stream, or reproduce copyrighted audio — except for Originals, which are fully licensed.

### What Is Safe
| Activity | Status |
|---|---|
| Storing metadata (titles, composers, tracklists) | ✅ Safe |
| User reviews, ratings, shelf names | ✅ Safe |
| Scene timeline tags (descriptive text) | ✅ Safe |
| Linking out to Spotify / Apple Music / YouTube | ✅ Safe |
| Hosting OSTrack Originals (CC or mechanically licensed) | ✅ Safe |
| Embedding YouTube player (official uploads) | ⚠️ Gray area — monitor |
| Hosting audio files | ❌ Requires full licensing |
| User-uploaded audio | ❌ Requires Content ID infrastructure |

### Phase 1 Launch Strategy
Launch with zero hosted third-party audio. Playback links out entirely. Build user base.

### Phase 2 (Post-Traction)
Approach publishers and indie composers directly for streaming licensing deals, using platform scale as leverage. Start with independent composers who own their own masters.

---

## Social & Community Layer

### Public Shelves
The primary social object. Shelves appear on profiles, get followed, get shared. They are OSTrack's answer to the playlist — but with curation identity baked in.

### Discussion Forums
Threaded discussions anchored to content (not floating social posts). Spoiler tags are mandatory in game/anime discussions. Moderators are community-elected, reputation-based.

### Reputation System
Users earn **Contributor Points** through:
- Accepted scene timeline tags
- Reviews marked helpful by community
- Shelves with high follower counts
- Forum posts with high upvotes

Points unlock Trusted Contributor status, which grants moderation capabilities and a profile badge.

### No Follower Feed Gaming
Feed shows *activity*, not algorithmic amplification. You see what the people you follow are actually doing — not what the algorithm thinks will keep you scrolling.

---

## Discovery & Recommendations

### Mechanism
Collaborative filtering based on listening history and ratings. "Users who loved the same 5 OSTs as you also rate these highly."

### Discovery Surfaces
| Surface | Logic |
|---|---|
| Home feed "You might like" card | Based on your listening history |
| Explore "Hidden Gems" | High-rated, low-traffic within your preferred categories |
| Track Page "Related tracks" | Same composer or mood tag |
| Weekly Digest notification | Top-rated OSTs of the week, filtered to your categories |

### Cold Start (New Users)
Onboarding media selections seed initial recommendations immediately. No empty state on day one.

---

## Notifications

Deliberately minimal. OST fans are not the target for engagement-bait pings.

### Enabled by Default
| Notification | Trigger |
|---|---|
| **On This Day** | Anniversary of a game/show release featuring a track from your shelves or history |
| **Weekly Digest** | Every Sunday — top-rated OSTs of the week in your categories |

### Opt-In Only
| Notification | Trigger |
|---|---|
| New OSTrack Original drop | New native content published |
| Followed user activity | Someone you follow creates a shelf or posts a review |
| Comment reply | Someone replies to your forum post |

### On This Day — Feature Detail
This is a flagship notification. When a game or film celebrates a birthday (1, 5, 10, 15, 20, 25 year anniversary), users who have tracks from that OST in their history or shelves receive a beautifully designed notification card:

> *"🎂 Today marks 10 years since Bloodborne (2015). Here's its most loved track by the OSTrack community: 'Ludwig, the Accursed/Holy Blade.'"*

Tapping opens the Media Source Page with a special anniversary banner.

---

## Monetization

### Phase 1 — Free with Ads
Ads appear as native cards in the Home feed (every ~8–10 cards) and as banner units on Explore category screens. Never interrupting playback. Never between forum posts mid-read.

**Ad targeting:** Based on media category preferences (not personal data sold to advertisers). A user who loves anime OSTs sees ads for anime streaming services, merch, and related media — relevant and non-hostile.

### Phase 2 — OSTrack Pro (Future)
A natural premium tier:
- Ad-free experience
- Advanced shelf tools (custom ordering, export, analytics)
- Early access to OSTrack Originals drops
- Extended listening history (unlimited vs. 90-day free tier)
- Profile customization extras

Pricing suggestion: **$3.99/month or $29.99/year** — priced below Spotify to feel like a complement, not a competitor.

---

## Design Direction

### Theme
Both light and dark modes, with dark as the default. OST listening is often a nighttime, headphones-on experience. Dark mode feels native.

### Aesthetic *(Proposed — see Open Questions)*
**Cinematic & editorial.** Full-bleed album artwork. Dramatic typographic hierarchy. The app should feel like a high-quality music magazine crossed with a film archive. Not a sterile database — an experience.

**Typography (proposed):**
- Display: A high-contrast serif (e.g. Freight Display, Canela, or similar) for track/album titles — cinematic weight
- Body: A clean geometric sans for UI chrome and metadata
- Mono: For timestamps, track numbers, technical metadata

**Color:**
- Dark default: Near-black backgrounds (#0E0E10 range) with warm off-white text
- Accent: A single rich accent color — deep amber or cobalt — used sparingly for ratings, active states, and Originals branding
- Album art drives ambient color per-screen (like Apple Music's dynamic backgrounds)

**Motion:**
- Shelf reveal animations on profile load
- Track selection ripple effects
- On This Day notification: cinematic entrance with artwork parallax

---

## Tech Stack

### Mobile
**Flutter** — single codebase for iOS and Android. Dart-based, strong animation support (important for the cinematic design direction), excellent performance on both platforms.

**Key Flutter packages (proposed):**
- `just_audio` — for OSTrack Originals native playback
- `url_launcher` — for linking out to Spotify/Apple Music/YouTube
- `flutter_bloc` — state management
- `isar` — local database for offline library/history
- `cached_network_image` — artwork loading

### Backend (Proposed)
| Layer | Technology |
|---|---|
| API | REST + GraphQL hybrid (REST for simple CRUD, GraphQL for complex feed queries) |
| Runtime | Node.js / Bun |
| Database | PostgreSQL (relational data: tracks, composers, media) + Redis (caching, sessions) |
| Search | Meilisearch or Typesense (fast, typo-tolerant OST search) |
| Auth | Supabase Auth or Firebase Auth |
| Media (Originals) | Cloudflare R2 + Cloudflare Stream |
| Push Notifications | Firebase Cloud Messaging (FCM) |
| Recommendations | Custom collaborative filtering service (Python/FastAPI) |

### Third-Party Integrations

**Data Pipeline Sources**

| Source | Role | Access |
|---|---|---|
| **Spotify Web API** | Track metadata, romanized aliases, platform IDs, ISRCs | Free, instant approval |
| **Apple Music / MusicKit** | Cross-reference titles, catch romanization discrepancies | Free, easy registration |
| **MusicBrainz** | Film/TV OST coverage, ISRC linkage, supplementary game data | Free, fully open |
| **AniList API** | Anime media source pages — romaji, kanji, English titles simultaneously | Free, no API key |
| **IGDB (Twitch)** | Game media source pages — release dates, genres, publishers | Free, Twitch login |
| **YouTube Data API v3** | Composer credits from official uploads, fallback playback IDs | Free quota, generous |
| **Wikidata** | Composer profiles, work relationships, cross-linked discographies | Free, open SPARQL |
| **VGMdb** | Pursue post-traction from position of scale (150k+ users) | Future nice-to-have |

**Playback SDKs**
- **Spotify App Remote SDK** — in-app playback control without app-switching on iOS/Android
- **Apple MusicKit** (native SDK) — in-app playback control, keeps user inside OSTrack UI
- **YouTube IFrame / Android Player API** — embedded fallback playback

**Licensing & Originals**
- **Songfile / DistroKid** — mechanical licensing for commissioned Originals arrangements

---

## Open Questions
*Decisions to make before development begins.*

| # | Question | Options | Recommendation |
|---|---|---|---|
| 1 | Rating system | Stars (1–5), Score (1–10), Tier list, Heart only | **Stars (1–5)** — familiar, low friction. Add half-stars for granularity. |
| 2 | Auth method | Email/password, Social (Google/Apple), Both, Anonymous-first | **Social login first** (Google + Apple) — lowest friction for mobile. Email as fallback. |
| 3 | Localization | English only, English + JP + KR, Full multi-language | **English + Japanese + Korean** at launch — mirrors the core OST audience demographics. |
| 4 | Metadata contribution | Open (wiki-style), Trusted contributors, Mod-reviewed | **Mod-reviewed submissions** — quality over speed at launch. Open it up post-scale. |
| 5 | App name | OSTrack (working title) | Validate: is the name available on App Store / Play Store / domain? |
| 6 | Monetization timing | Ads from day one vs. ad-free during beta | Consider ad-free beta to build goodwill, introduce ads at public launch. |

---

## Roadmap

### V1 — Foundation (Months 1–6)
- Data pipeline: Spotify + Apple Music + MusicBrainz + AniList + IGDB ingestion
- Cross-platform alias harvesting engine
- Typesense multi-language index
- Media Source Pages, Composer Profiles, Track Pages
- Public Shelves, Forum comments
- Playback via Spotify App Remote SDK + Apple MusicKit
- Onboarding (media selection → recommendations)
- OSTrack Originals — first 20–30 tracks
- On This Day + Weekly Digest notifications
- iOS & Android launch via Flutter

### V2 — Community (Months 7–12)
- Scene Timeline contributions + moderation tools
- Reputation / Trusted Contributor system
- Expanded Originals catalog (commissioned arrangements)
- OSTrack Pro subscription tier
- Improved recommendation engine
- Localization: Japanese + Korean

### V3 — Scale (Year 2)
- Direct composer licensing deals for streaming
- Artist/composer verification + official profiles
- Label and publisher partnership program
- API access for third-party integrations
- Web companion app
- VGMdb partnership re-approach from position of scale

---

---

## Architectural Pressure-Test & Enhancements

*This section stress-tests the core system against real operational friction points identified during design review.*

---

### 1. The Metadata Localization Problem

**The Issue:** Soundtrack metadata — especially for Japanese games and anime — is notoriously fragmented across platforms. A single track may appear under three different names simultaneously:

| Platform | Name |
|---|---|
| Spotify | *Tatakai no Toki* (Romaji) |
| Apple Music | *Time of Battle* (English) |
| MusicBrainz | *戦いの時* (Kanji) |

If the database doesn't link these, playback routing breaks silently and searches fail invisibly — the worst kind of bug, because users just think the track doesn't exist.

**The Solution: Track Aliasing Engine + Cross-Platform Harvesting**

Rather than relying on a single gated data source, OSTrack harvests aliases automatically by diffing the same OST across multiple freely accessible APIs. Spotify and Apple Music frequently carry different romanizations and English translations of the same track — this discrepancy is the alias data.

```
For each target OST:
  1. Query Spotify  → romanized Japanese title + English title + Spotify ID
  2. Query Apple Music → often different romanization or translation
  3. Diff variants  → automatic alias pair
  4. Cross-ref MusicBrainz → append kanji/hangul forms
  5. Result: 3-language alias set, zero partnerships required
```

The data schema supports a canonical primary name with an array of localized aliases:

```json
{
  "id": "track_00812",
  "canonical_name": "戦いの時",
  "canonical_lang": "ja",
  "aliases": [
    { "name": "Tatakai no Toki", "lang": "ja-Latn", "source": "spotify" },
    { "name": "Time of Battle",  "lang": "en",       "source": "apple_music" },
    { "name": "Battle Theme",    "lang": "en",       "source": "user_submitted" }
  ],
  "platform_ids": {
    "spotify": "4uLU6hMCjMI75M1A2tKUQC",
    "apple_music": "1234567890",
    "youtube": "dQw4w9WgXcQ"
  }
}
```

Typesense's multi-language fuzzy matching handles the search layer — a query for "tatakai" will resolve to the same track as "time of battle" or the Kanji form.

**Data Source Strategy**

VGMdb is the gold standard for game/anime OST metadata but is historically closed to unknown developers — partnership attempts before achieving meaningful scale are likely to be ignored. The cross-platform harvesting pipeline above achieves equivalent alias coverage for the top 1,000+ OSTs with zero gatekeeping. The 20% it misses (doujin games, obscure OVA BGMs, deep regional cuts) is precisely what the Founding Archivist community will want to contribute themselves.

Community sources: recruit 50–100 beta users from OST communities (VGMdb forums, r/gamindustri, anime OST Discord servers). Offer a "Founding Archivist" badge — permanently non-earnable after public launch. These fans have been contributing to VGMdb for years with no social recognition; OSTrack gives them a home.

---

### 2. Scene Timeline UX: Designing for Memory Friction

**The Issue:** Contributing to Scene Timelines is inherently high-friction. Users rarely know exact timestamps from memory, and they won't stop watching a dramatic scene to open an app and tag it.

**The Enhancement: Fuzzy-Logic Contribution + Bounty System**

The contribution flow should never demand precision upfront. Instead it accepts contributions at multiple fidelity levels:

| Fidelity Level | Example | Status |
|---|---|---|
| **Scene description only** | "Plays during the final confrontation" | Valid, shown with 🌀 *unverified* badge |
| **Episode / chapter anchor** | "Episode 7, second half" | Valid, shown with 🟡 *approximate* badge |
| **Verified timestamp** | "22:14" | Full ✅ *verified* badge |

**Bounty System:** Any user can flag a timeline entry as needing timestamp verification. This creates a public "Request" in the track's forum thread. Resolving a bounty earns Contributor Points toward Trusted status. This gamifies precision without gatekeeping contribution.

**Async Contribution Flow:**
- "I'll tag this later" bookmark — saves a track to a private "Tag Queue" in Library
- Push reminder: "You bookmarked a scene in Shadow of the Colossus — got a moment to add the timestamp?"

---

### 3. Data Privacy & GDPR Architecture

**The Requirement:** Processing detailed listening histories for collaborative filtering triggers full GDPR obligations for European users — including data portability and the Right to be Forgotten.

**Schema Design: Soft Deletes + PII Anonymization**

User account deletion must not orphan community contributions (forum posts, scene tags, shelf entries are community assets) but must irrecoverably destroy PII.

```sql
-- User table: soft delete pattern
ALTER TABLE users ADD COLUMN deleted_at TIMESTAMPTZ;
ALTER TABLE users ADD COLUMN anonymized_at TIMESTAMPTZ;

-- On deletion:
-- 1. Set deleted_at = NOW()
-- 2. After 30-day grace period: set anonymized_at, replace all PII fields
--    username → [deleted_user_8a3f], email → NULL, avatar → NULL
-- 3. Forum posts/scene tags retain anonymized author reference
-- 4. Listening history → DELETE (not anonymized, this is behavioral PII)
-- 5. Recommendation model embeddings for this user → DELETE
```

**Consent Separation at Onboarding:**

Two distinct consent prompts — not bundled — at the end of onboarding:

> ✅ **Essential:** OSTrack uses your ratings and shelves to make the app work.  
> ⬜ **Optional:** Allow OSTrack to analyze your listening patterns to power personalized recommendations.

Users who decline optional consent get editorial recommendations only (curated picks, trending) — not collaborative filtering. This is both legally correct and a better UX than blocking features behind consent walls.

**GDPR Tooling:**
- Data export endpoint: generates a full JSON archive of user's ratings, shelves, posts, history (standard portability requirement)
- Right to be Forgotten: triggers the anonymization pipeline above
- Consent log: immutable append-only table recording every consent decision with timestamp

---

### 4. Playback Architecture: Solving the App-Switch Problem

**The Issue:** On iOS, a naive URI scheme (`spotify://track/...`) kicks the user out of OSTrack and into the Spotify app. The dedicated Player screen — with its scene tags, composer notes, and rating widget — becomes useless if users are constantly being ejected.

**The Solution: Playback SDK Integration**

| SDK | Platform | Capability |
|---|---|---|
| Spotify App Remote SDK | iOS + Android | Controls Spotify playback while keeping user in OSTrack. Requires Spotify app installed. |
| Apple MusicKit (native) | iOS | Full in-app playback control; no app-switch. Requires Apple Music subscription. |
| YouTube IFrame / Android Player API | Both | Embedded playback for YouTube fallback. More permissive but lower audio quality. |

**Graceful Degradation Stack:**

```
User taps ▶ on a track
  → Has Spotify linked + installed?       → Spotify App Remote SDK (in-app control)
  → Has Apple Music linked?               → MusicKit in-app control
  → Has YouTube Music linked?             → Deep link (acceptable app-switch)
  → No platform linked                   → Prompt to link a platform
  → Track is an OSTrack Original         → Native in-app playback (always works)
```

The Player screen remains useful in all cases because scene tags, ratings, and composer info render regardless of playback state. Audio is the enhancement, not the prerequisite.

---

### 5. Revised Data Architecture Summary

```
┌─────────────────────────────────────────────────────┐
│                    OSTrack Backend                   │
│                                                      │
│  PostgreSQL                                          │
│  ├── media_sources (games, anime, films)             │
│  ├── tracks + track_aliases (multi-lang)             │
│  ├── composers                                       │
│  ├── scene_timeline_entries (fidelity levels)        │
│  ├── users (soft-delete + anonymization)             │
│  ├── shelves + shelf_tracks                          │
│  ├── ratings                                         │
│  ├── forum_posts (anonymizable, not deletable)       │
│  └── consent_log (append-only)                       │
│                                                      │
│  Redis                                               │
│  ├── Session cache                                   │
│  ├── Feed assembly cache                             │
│  └── Bounty/request queue                            │
│                                                      │
│  Typesense                                           │
│  └── Full-text search index (all aliases, all langs) │
│                                                      │
│  Python / FastAPI                                    │
│  └── Collaborative filtering service                 │
│      (opt-in users only, GDPR-partitioned)           │
│                                                      │
│  Cloudflare R2 + Stream                              │
│  └── OSTrack Originals audio hosting                 │
└─────────────────────────────────────────────────────┘
```

---

### Next Design Targets

| Priority | Task |
|---|---|
| 🔴 High | Relational DB schema — full ERD for track aliases, timeline fidelity, consent log |
| 🔴 High | Scene Timeline contribution wireframe — full UX flow |
| 🟡 Medium | Playback SDK integration architecture — fallback chain implementation |
| 🟡 Medium | GDPR consent flow — onboarding screens |
| 🟢 Low | VGMdb data pipeline — seed strategy and field mapping |

---

*Document version 0.3 — updated with revised data pipeline strategy (no VGMdb dependency)*
*Last updated: April 2026*
