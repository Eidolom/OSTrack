# OSTrack — Mascot System
*Collector identity, pixel art culture, and a monetization model that earns goodwill*

---

## Overview

Mascots are 32×32 pixel art characters that users equip to their profile and collect in a personal cabinet. They appear everywhere a username appears — in the feed, in forum threads, on shelf attributions — making every user's presence on the platform visually distinct and memorable.

The system operates on three layers: **house characters** created by OSTrack, **composer partnership drops** licensed from real composers, and **community artist submissions** from the pixel art community. Together they form a living, expanding catalog that becomes one of OSTrack's most distinctive features.

Mascots are non-transferable. What you own, you own — it cannot be sold, traded, or gifted. This keeps the catalog clean and prevents a secondary market from undermining the primary store.

---

## The Three Layers

### Layer A — House Characters

OSTrack's canonical cast. Designed by a single commissioned pixel artist to ensure a consistent visual identity across the entire house roster. These are the foundation of the system — always available, no scarcity, entry-level price point.

**Pricing:** $1.99 per mascot

**Availability:** Permanent — never retired, always purchasable

**Launch Roster (6 characters):**

| Name | Concept | Notes |
|---|---|---|
| **Conductor Skeleton** | A tiny skeleton in a conductor's tuxedo, baton raised | OSTrack's de facto mascot |
| **Kitsune Archivist** | A fox spirit holding a scroll and a vinyl record | Represents the cataloging identity |
| **Cassette Ghost** | A translucent ghost emerging from a cassette tape | Nostalgia + soundtrack culture |
| **Chibi Beethoven** | A miniature Beethoven with wild hair and a quill | Historical composer, public domain |
| **Shrine Maiden** | An anime-adjacent shrine maiden with music note motifs | Represents the anime OST category |
| **Pixel Composer** | A small figure hunched over sheet music under a lamp | The archivist at work |

**Cadence:** One new house character added quarterly after launch.

**Creative Director:** A single pixel artist is hired as the house style lead. They produce the launch roster, write the style guide (grid conventions, palette limits, animation frame rules), and approve all community submissions for visual consistency.

---

### Layer B — Composer Partnership Drops

The prestige tier. Each drop is a limited event with a real story — a real composer, their real character, officially licensed for OSTrack. These feel like album release events, not store updates.

**Pricing:** $4.99 per mascot

**Availability:** Limited window — **7 days only**, then permanently retired

**Hard cap:** 1,000 units per drop. Once 1,000 are sold the drop closes early even if the 7-day window hasn't expired. Edition numbers are assigned at purchase (#1 of 1,000 through #1,000 of 1,000).

**First target composer: Toby Fox (Undertale)**

Toby Fox is the ideal first partnership for several reasons: he is indie, owns his IP entirely, has been publicly generous with fan communities, and his work (Undertale, Deltarune) is canonical listening for OSTrack's core audience. An Annoying Dog mascot from an official Toby Fox partnership would be the most credible possible signal that OSTrack is worth taking seriously.

**Outreach pipeline (in priority order):**
1. Toby Fox — Undertale / Deltarune
2. Lena Raine — Celeste, Minecraft
3. Christopher Larkin — Hollow Knight
4. Disasterpeace — Hyper Light Drifter, It Follows
5. Aivi & Surasshu — Steven Universe

**Drop event structure:**
- Announcement post 2 weeks before drop opens (in OSTrack feed + external)
- Composer writes a short note about the mascot design (displayed on the store page)
- Countdown timer appears on store page 48 hours before drop opens
- Drop opens — 7-day window or 1,000 units, whichever closes first
- Post-drop: mascot permanently retired, cabinet shows "SOLD OUT" on the store entry
- Edition number displayed permanently in the owner's cabinet

**Cadence:** One composer partnership drop per quarter. Four per year. This keeps them rare enough to feel significant.

---

### Layer C — Community Artist Program

The long tail. An open submission program where pixel artists apply to have original characters sold in the OSTrack store. OSTrack handles the transaction and storefront; the artist gets distribution, exposure, and income.

**Pricing:** $2.49 per mascot (artist-set within a $1.99–$3.99 range)

**Revenue split:** 70% to the artist, 30% to OSTrack

**Availability:** Rotating catalog — artists can choose to make their mascot permanent or set a retirement date. A retired community mascot is gone from the store but remains in the cabinets of everyone who bought it.

**Submission requirements:**
- Original character only — no recognizable IP, no existing characters
- Must conform to the house style guide (resolution, palette limits, animation spec)
- Artist retains copyright of their character design
- OSTrack receives a license to sell and display the mascot on the platform
- Artist must provide: idle animation (2–4 frames), static version, and a short character description

**Submission review:** The creative director reviews each submission against the style guide. Approval or rejection within 2 weeks. Feedback provided on rejection so artists can resubmit.

**Drop cadence:** One new community artist mascot added every 2 weeks.

**Discovery:** Community mascots are featured with the artist's username and a short bio. Tapping the artist name opens their OSTrack profile if they have one, or their linked portfolio if they don't. This turns accepted artists into OSTrack users by default.

---

## The Equipped Mascot — Main Slot

Each user has one active mascot at a time — the **main mascot**. This is the one that appears everywhere their username appears across the platform.

### Placement

| Location | Treatment |
|---|---|
| Feed cards | 32×32 beside avatar, idle animation running |
| Forum posts | 32×32 beside username, idle animation running |
| Profile hero | 48×48 beside avatar, idle animation running |
| Shelf attribution | 24×24 beside "by @username", static |
| Contributor leaderboard | 32×32 beside username, static |
| Scene tag submissions | 24×24 beside username, static |

Animated idle loop runs wherever the mascot is 32×32 or larger. Static version used at 24×24 and below to avoid visual noise in dense layouts.

### Changing Your Main Mascot

Done from the Collection page in the profile. Tapping any owned mascot and selecting "Equip" triggers a short animation — the new mascot walks in from the right of the avatar slot, the old one waves and exits left. 800ms total, skippable by tapping anywhere. This is the kind of detail that gets screenshotted.

### Animation Specification

**Idle loop:** 2–4 frames, 200–400ms per frame, seamless loop. Subtle — a slight bob, a blinking eye, a swaying baton. Not distracting.

**Equip animation:** Unique per mascot where possible. The Conductor Skeleton taps their baton twice before settling. The Cassette Ghost spins once. The Kitsune Archivist flicks their tail. These are small but make equipping feel earned.

**No animation on static placements** (shelf attribution, small sizes) — respects the reading experience and device performance.

---

## The Collection Cabinet

A dedicated section on every user's profile page, positioned below the bio and stats block, above the shelves. Labeled **COLLECTION** in the standard mono label style.

### Layout

A grid of display cases — **4 columns, unlimited rows**, expanding downward as the collection grows. Each case is a slightly elevated square with a subtle border, like a display case with interior lighting. House characters, partnership drops, and community mascots all share the same grid — no segregation by tier in the visual layout, though filtering is available.

```
COLLECTION  ·  12 owned  ────────────────────────
┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐
│  🦊  │  │  💀  │  │  👻  │  │  🎵  │
│      │  │      │  │      │  │      │
│ #—   │  │ #47  │  │ #—   │  │ #—   │
└──────┘  └──────┘  └──────┘  └──────┘
Kitsune   Conductor  Cassette   Chibi
Archivist  Skeleton   Ghost    Beethoven

┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐
│  ░░  │  │  ░░  │  │  ░░  │  │  ░░  │
│  ░░  │  │  ░░  │  │  ░░  │  │  ░░  │
│  ??  │  │  ??  │  │  ??  │  │  ??  │
└──────┘  └──────┘  └──────┘  └──────┘
 [locked]  [locked]  [locked]  [locked]
```

### Owned Mascot Display

- Mascot rendered at 2× or 3× scale, idle animation running for the equipped mascot only
- Mascot name below the case in small body text
- Edition number below the name for limited drops (`#47 of 1,000`)
- A `★ LIMITED` badge on the case border for composer partnership mascots
- A `✦ FOUNDING` label for beta-exclusive mascots
- The currently equipped mascot's case has a gold border — immediately identifiable

### Unowned Mascot Display

Locked slots show the mascot silhouette at reduced opacity — dark, slightly blurred, clearly not owned but clearly present. A small `?` appears in the lower corner. Tapping a locked slot opens the store page for that mascot if it's available, or shows "No longer available" with the edition count and sale date if it's retired.

This creates desire without being manipulative — you can see what exists, you know you don't have it, but you're never shown a price or a "Buy Now" button without choosing to tap in.

### Filtering

A small filter row above the grid: **ALL · HOUSE · PARTNERSHIP · COMMUNITY**. Defaults to ALL. Allows collectors to organize how they browse their own cabinet.

### Visibility

**Public by default, with an option to hide.** The collection is part of a user's public taste identity — hiding it is available but discourage-by-design. The value of the cabinet is that other people see it.

A small eye icon in the section header toggles visibility. When hidden, the section is replaced on the public profile with a lock icon and "Collection private." The user still sees their full cabinet in their own view.

---

## Free Mascot — Founding Archivist Exclusive

Beta users who contribute during the founding period (beta through public launch) receive **one free exclusive mascot** — the **Founding Archivist**.

This character is a small pixel-art figure holding a quill and a magnifying glass, wearing an archivist's jacket with a tiny OSTrack logo pin. Designed to be clearly distinct from the purchasable house characters.

**Rules:**
- Awarded automatically when a user meets the Founding Contributor threshold during beta
- Never sold in the store — not before launch, not after, not ever
- Displays a permanent `✦ FOUNDING` label in every cabinet it appears in
- The founding mark is visible on the mascot itself — a small star detail built into the pixel art

This mascot becomes the most recognizable status symbol on the platform. Seeing it on someone's profile immediately communicates "this person was here from the beginning." That signal is worth more than any amount of promotion.

**No other free mascots.** New users after launch do not receive a free mascot. The founding exclusive is meaningful precisely because it has a hard cutoff.

---

## Mascot Store

Accessible from the profile (Collection page → Store button) and from a dedicated tab in the app's settings/account area.

### Store Structure

**Featured** — the current composer partnership drop if active, with countdown timer and edition progress bar ("743 of 1,000 remaining")

**House Characters** — all 6 (growing) permanent characters, always available

**Community Artists** — rotating catalog, newest first. Each entry shows the mascot, artist name, short character description, and price.

**Archive** — retired mascots you don't own. Not purchasable. Shows the edition count, sale dates, and how many OSTrack users own it. Satisfying to browse, creates historical context.

### Store Page Per Mascot

- Mascot rendered large (128×128 or animated at 4×) with idle loop running
- Character name and short description (2–3 sentences)
- For partnership mascots: composer note and collaboration context
- For community mascots: artist name, bio link, submission date
- Edition information for limited drops
- Price and purchase button
- "X users have this mascot" — social proof
- If retired: "No longer available · Owned by X users · Sold [date range]"

### Purchase Flow

1. Tap "Add to Collection" — $1.99 / $2.49 / $4.99
2. Standard in-app purchase confirmation (App Store / Play Store sheet)
3. On completion: mascot slides into the collection grid with a small "NEW" flash
4. A notification card appears: "[Mascot name] added to your collection. Equip now?"
5. Tapping "Equip now" triggers the equip animation immediately

No dark patterns. No fake urgency on permanent items. The countdown and edition counter on limited drops are real — the scarcity is genuine.

---

## Revenue Model

### Projections

| Scenario | Users | Conversion | Avg. Price | Monthly Revenue |
|---|---|---|---|---|
| Beta (500 users) | 500 | 20% | $1.99 | ~$200 |
| Phase 2 launch (10k users) | 10,000 | 15% | $2.49 | ~$3,735 |
| Phase 3 scale (150k users) | 150,000 | 12% | $2.49 | ~$44,820 |

Partnership drops add a significant spike — at 1,000 units × $4.99 that's **$4,990 per quarterly drop**, with composer receiving none (the licensing fee is paid upfront as a flat rate negotiated with the composer, not a revenue share on this tier).

Community artist revenue at scale — with 50 active community mascots averaging 20 purchases each per month at $2.49 with 30% to OSTrack: **$748/month** from community tier alone, growing with catalog size.

### Why This Works With OSTrack Pro

Mascots and Pro target entirely different motivations. Pro is for power users who want more capability. Mascots are for anyone who wants to express identity — including casual users who would never pay for Pro. The two monetization streams don't compete and together serve a much wider slice of the user base.

---

## Technical Specification

### Asset Format

- **Source:** 32×32 PNG with transparent background
- **Animation:** Sprite sheet (frames horizontal), 2–4 frames
- **Palette:** Maximum 16 colors per mascot (enforced by style guide)
- **Delivery:** Static PNG + animated GIF + sprite sheet PNG

### Display Implementation (Flutter)

- Static display: `Image.asset` at specified scale
- Animated display: `AnimatedSprite` or `flutter_animate` frame cycling
- Scaling: nearest-neighbor only — no bilinear interpolation on pixel art
- The `FilterQuality.none` flag must be set on all pixel art image renders to preserve crisp edges

### Storage

- Mascot assets stored on Cloudflare R2
- Served via Cloudflare CDN — mascots load instantly because they're tiny files
- Ownership stored in PostgreSQL: `user_mascots` table with `user_id`, `mascot_id`, `purchased_at`, `edition_number`
- Equipped mascot stored in `users` table: `equipped_mascot_id`

### Database

```
mascots
  ├── id (uuid, pk)
  ├── name (text)
  ├── tier (enum: house, partnership, community)
  ├── artist_id (uuid → artists or composers, nullable)
  ├── price_cents (int)
  ├── edition_cap (int, nullable)      -- null = unlimited
  ├── editions_sold (int, default 0)
  ├── available_from (timestamptz, nullable)
  ├── available_until (timestamptz, nullable)
  ├── retired (bool, default false)
  ├── asset_url (text)
  ├── sprite_sheet_url (text)
  ├── frame_count (int)
  ├── frame_duration_ms (int)
  └── created_at (timestamptz)

user_mascots
  ├── id (uuid, pk)
  ├── user_id (uuid → users)
  ├── mascot_id (uuid → mascots)
  ├── edition_number (int, nullable)
  ├── purchased_at (timestamptz)
  └── source (enum: purchased, founding_grant)

Unique constraint: (user_id, mascot_id)
```

---

## Drop Calendar (Year 1)

| Month | Drop Type | Content |
|---|---|---|
| Launch | House | Full launch roster (6 mascots) |
| Month 1 | Community | First community artist mascot |
| Month 1.5 | Community | Second community artist mascot |
| Month 2 | Community | Third community artist mascot |
| Month 3 | Partnership | **Toby Fox drop** — 7 days, 1,000 units |
| Month 3 | House | Q1 new house character |
| Month 3.5 | Community | Continues every 2 weeks... |
| Month 6 | Partnership | Second composer drop |
| Month 6 | House | Q2 new house character |
| Month 9 | Partnership | Third composer drop |
| Month 9 | House | Q3 new house character |
| Month 12 | Partnership | Fourth composer drop |
| Month 12 | House | Q4 new house character |
| Anniversary week | House (special) | Annual exclusive — available 7 days only |

---

## Open Questions

| # | Question | Recommendation |
|---|---|---|
| 1 | Flat fee vs. royalty for composer partnerships? | Flat fee upfront — simpler, no ongoing accounting |
| 2 | App Store cut (30%) impact on pricing? | Price at $1.99/$2.49/$4.99 accounting for 30% cut; effective revenue $1.39/$1.74/$3.49 |
| 3 | Physical merchandise tie-in? (sticker packs, pins) | Phase 4+ opportunity — validate digital demand first |
| 4 | Community artist application process? | Simple Google Form → creative director review → approval email |
| 5 | What happens to community mascots if artist requests removal? | 30-day notice, retire from store, existing owners keep theirs |

---

*Document version 1.0 · April 2026*
*Mascot System — designed to earn goodwill, not extract it*
