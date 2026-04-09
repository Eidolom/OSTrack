# OSTrack — UI/UX Design Roadmap
*From generic scaffold to a platform people want to live in*

---

## The Honest Diagnosis

The current UI is a Material 3 scaffold with teal and gold applied on top. It reads as "Flutter app." The dark backgrounds, glowing orbs, and pixel fonts are design intentions that haven't been executed — they're gestures toward a style, not a committed vision. Nothing about it currently says "I was made for people who cry at the end of NieR:Automata."

The goal is a UI that feels like **Letterboxd met a JRPG**. Letterboxd works because every pixel communicates that it was built by people who love films, for people who love films. OSTrack needs to make the same statement about soundtracks. The gamified layer isn't cosmetic — it's the mechanism that turns passive listeners into obsessive catalogers.

This document is a roadmap from where we are to where we need to be. It's organized by layer, not by screen, because the problems are systemic.

---

## Table of Contents
1. [What Letterboxd Gets Right](#what-letterboxd-gets-right)
2. [The Gamification Model](#the-gamification-model)
3. [Design System Overhaul](#design-system-overhaul)
4. [Screen-by-Screen Redesign](#screen-by-screen-redesign)
5. [Micro-Interactions & Motion](#micro-interactions--motion)
6. [The Emotional Arc](#the-emotional-arc)
7. [Implementation Phases](#implementation-phases)
8. [What to Cut](#what-to-cut)
9. [Reference Material](#reference-material)

---

## What Letterboxd Gets Right

Study these before touching a single widget.

**Typography does the heavy lifting.** Letterboxd's identity is almost entirely typographic. Large, confident display text. Tight tracking on headings. The film title is the hero — everything else is metadata. OSTrack's track names and OST titles should command a screen the way a film poster commands a wall.

**Content density is calibrated, not maxed.** Letterboxd doesn't try to show everything. A film entry on a feed shows the poster, username, star rating, and sometimes one line of review. That's it. The restraint creates trust. OSTrack's current feed cards are information-equal — everything gets the same weight, so nothing stands out.

**The community layer is the product.** On Letterboxd, the experience of seeing what your friends are watching is more compelling than any recommendation algorithm. The social feed IS the app. OSTrack's feed needs to feel like walking into a room where the conversation is already happening.

**Ratings are tactile.** The half-star click on Letterboxd has a satisfying finality. It's a small interaction but it feels deliberate. Rating something should feel like making a statement, not filling in a form.

**Lists are first-class.** Letterboxd's list pages are beautiful. Cover art grid, curator name, follower count. Browsing someone's list is an aesthetic experience. OSTrack's shelves need the same treatment.

**Color comes from content, not from the design system.** Letterboxd pages are dominated by film poster colors. The UI chrome is neutral so the content breathes. OSTrack's gold and teal should be accents used surgically, not the ambient color of every screen.

---

## The Gamification Model

Gamification done wrong is badges slapped on top of existing features. Gamification done right makes the core actions feel like they *mean* something and creates a sense of progression that's intrinsic to the identity of being an OSTrack user.

### The Collector Identity

Every user has a **Collector Profile** — a public-facing taste identity that evolves as they use the app. This isn't a stats page. It's a statement of who they are as a listener.

**Profile tiers based on activity:**

| Tier | Name | Threshold | Visual Treatment |
|---|---|---|---|
| 0 | Listener | New account | Plain avatar ring |
| 1 | Archivist | 50 ratings | Silver avatar ring |
| 2 | Chronicler | 200 ratings + 10 scene tags | Gold avatar ring |
| 3 | Curator | 500 ratings + 50 tags + 5 shelves with followers | Animated gold ring |
| 4 | Lorekeeper | Top 1% contributor | Custom animated ring, permanent profile badge |

The ring animation should feel like an achievement unlock, not a notification badge. Think Dark Souls level-up — understated but meaningful.

### Shelf Achievements

Shelves unlock visual treatments as they grow:

- 0 followers: plain shelf card
- 10 followers: subtle glow border
- 50 followers: "Popular shelf" badge appears
- 100 followers: shelf gets a "Trending" indicator on Explore
- 500 followers: shelf is eligible for "Community Pick" editorial feature

### The Scene Tag Fidelity Chain

Every scene tag contribution shows a visible fidelity ladder on the Track Page. Users can see the chain from a raw description → episode anchor → verified timestamp. Completing a bounty (adding the missing timestamp) shows a small animated "✓ Verified" stamp. It should feel like placing the final puzzle piece.

### Streak Mechanics

**Weekly Archivist Streak** — rate at least one OST per week. A small pixel-art calendar on the profile shows the streak. Miss a week and it resets, but past streaks are permanently visible as a historical record. Don't punish — celebrate.

**Discovery Streak** — listen to a new-to-you OST (one you haven't rated before) three times in a week. Triggers a "Fresh Ears" badge on that rating.

### The Founding Archivist Mark

Users who contribute during the beta and founding period get a permanent founding mark on their profile — a small pixel-art icon next to their name. Non-earnable after launch. This becomes a status symbol in the community, exactly like Letterboxd's "Patron" badge.

---

## Design System Overhaul

### Typography — The Most Urgent Fix

The current `DM Mono` body + `Press Start 2P` display combination reads as "retro game aesthetic kit" rather than a considered typographic system. Press Start 2P at any size above 8px becomes illegible and aggressive. It works as a micro-label — not as a display font for track names.

**Proposed System:**

```
Display / Track Titles:    Canela Text or Playfair Display
                           — high-contrast serif, editorial weight
                           — this is what makes it feel like Letterboxd
                           — use at 28–42px for hero titles

Section Labels / Eyebrows: Space Mono or DM Mono
                           — keeps the technical/archival feeling
                           — all-caps, letter-spaced, small (10–12px)
                           — this is where the "gamified flair" lives
                           — use for "SCENE TAG #042" "SHELF ACTIVITY" "ON THIS DAY"

Body / Metadata:           Outfit or Nunito
                           — clean, readable, warm
                           — NOT Inter (too generic), NOT Roboto (too Android)
                           — 14–16px for body, 12px for metadata

Scores / Numbers:          DM Mono
                           — ratings, timestamps, track numbers
                           — monospaced numbers prevent layout shift
```

**The principle:** The serif display font carries emotional weight. The mono labels carry technical credibility. The warm sans carries readability. Together they say "this was designed by people who take this seriously."

### Color — Restrained and Purposeful

The current gold and teal are applied everywhere, which means they carry no meaning. Color should signal state and category, not fill space.

**Revised palette:**

```
Background:     #0C0C0F  — near-black, slightly cooler than current
Surface:        #141418  — cards and elevated surfaces
Surface Alt:    #1C1C22  — secondary elevation
Border:         rgba(255,255,255,0.07)  — barely visible, like Letterboxd

Text High:      #F0EDE8  — warm off-white, not pure white (too harsh)
Text Mid:       #8A8A9A  — secondary text
Text Low:       #4A4A5A  — placeholder, disabled

Gold:           #E8B84B  — DESATURATED from current FFD600
                          — current gold is neon, reads as "warning"
                          — this gold reads as "achievement"
Teal:           #4ECDC4  — DESATURATED from current 00FFCC
                          — used for scene tags and verified states only
Coral:          #E8624A  — warm, used for ratings in progress, bounties

Rating color:   #E8B84B  — star ratings always gold
Verified:       #4ECDC4  — verified scene tags always teal
Bounty:         #E8624A  — open bounties always coral
```

**Content-driven ambient color:** When a user is on a Media Source Page or Player screen, the dominant color of the album artwork should subtly bleed into the background — extracted palette, blurred, set at 8–12% opacity. This is what Apple Music does and it's the single most effective trick for making a music app feel alive.

### Spacing and Grid

The current layout uses inconsistent padding (sometimes 16, sometimes 20, sometimes 18). Pick a base unit and be religious about it.

**8px base unit system:**
- xs: 4px
- sm: 8px
- md: 16px
- lg: 24px
- xl: 32px
- 2xl: 48px
- 3xl: 64px

All padding, margin, and gap values must be multiples of 8. No exceptions. This alone will make the app feel more considered.

### Elevation Model

Current cards use `BoxShadow` with `blurRadius: 28` — this creates a foggy, undefined look. Letterboxd barely uses shadows at all. Elevation is communicated through background color steps, not drop shadows.

**New elevation model:**
- Level 0 (base): `#0C0C0F`
- Level 1 (cards): `#141418` — just enough to separate from background
- Level 2 (modals, bottom sheets): `#1C1C22`
- Level 3 (tooltips): `#242430`

No box shadows on cards. A `0.5px` border at `rgba(255,255,255,0.08)` instead. Cleaner, more editorial.

---

## Screen-by-Screen Redesign

### Home Feed — The Pulse

**Current problem:** Feed cards are generic row widgets. They look like email list items.

**Target:** Each feed card should feel like a post. The user's avatar is prominent. The content (shelf name, OST title, rating) is the headline. Supporting info is metadata.

**Redesign principles:**

*Shelf activity cards* — show the shelf cover art as a large image tile (4:3 ratio), user avatar + name overlaid bottom-left, shelf name as display serif below. Below that: track count, follower count, small activity timestamp. This is how Letterboxd shows list additions.

*Rating cards* — show the OST artwork (square, full bleed), user avatar + "rated" action above, the star rating large and central below the artwork, and optionally the first line of a review in italic serif below. The rating stars should be rendered as proper star glyphs at 20px — not emoji, not icons.

*Scene tag cards* — show the track name in display serif, the scene description in italic body text (think: a pull quote), the fidelity badge (🌀 unverified / ✓ verified) as a small mono label. This should feel like a film annotation, not a database entry.

*On This Day* — this card deserves special treatment. Full-width, full-bleed artwork, anniversary year overlaid in large display text, track name below. Think magazine cover. This is a marquee moment — design it that way.

**Feed spacing:** 16px between cards. No card borders — just the background color separation. Cards have 16px internal padding. The feed should feel like reading a zine, not browsing a database.

---

### Media Source Page — The World

**Current problem:** It doesn't exist as a real screen — it's described but not built. When it is built, it needs to be the emotional heart of the app.

**Target:** Think Letterboxd's film page. The OST artwork is the hero. Everything else organizes around it.

**Layout:**

```
┌─────────────────────────────────┐
│  [Full-bleed artwork, 16:9]     │
│  gradient fade to background    │
│  ─────────────────────────────  │
│  GAME · 2022 · 285 TRACKS       │  ← mono label, small
│                                 │
│  Elden Ring                     │  ← display serif, large (36px)
│  Original Soundtrack            │  ← display serif, lighter weight
│                                 │
│  Yuka Kitamura · Tsukasa Sagi  │  ← linked composer names, teal
│                                 │
│  ★ 4.9  |  9.2k ratings        │  ← gold stars, mono number
│                                 │
│  [Rate this OST] [Add to Shelf] │  ← primary actions
│                                 │
│  ─────────────────────────────  │
│  TRACKLIST  SCENE TAGS  FORUM   │  ← tab nav
└─────────────────────────────────┘
```

**Tracklist design:** Each track row shows the track number in mono (right-aligned, muted), track name in regular weight, duration right-aligned. Tapping a track expands it inline to show scene tags, rating widget, and playback button. No separate Track Page navigation needed for quick access. Full Track Page is accessed by long-press or a "See full page" action.

**Community rating bar:** Below the star rating, a horizontal bar chart showing rating distribution (1–5 stars). This is Letterboxd's most useful UI element — it tells you at a glance whether an OST is divisive or universally loved.

---

### Explore — The Discovery Layer

**Current problem:** Category tiles are generic cards. There's no sense of what's inside before you tap.

**Target:** Letterboxd's genres page, but for soundtrack worlds. Rich, image-driven, editorial.

**Category tiles redesign:**
- Full-bleed artwork collage (3 OST covers arranged in a staggered grid)
- Category name in large display serif overlaid with a dark gradient
- Track count in mono below
- "Trending" indicator if there's recent activity spike
- Tile height: 180px minimum — tall enough to feel like a destination

**Trending section:** Instead of a list of text rows, show a horizontal scroll of OST artwork tiles (square, 120×120px) with track count badge and activity indicator. Tapping opens the Media Source Page.

**Hidden Gems row:** Curated editorial feel. 2–3 OSTs per week surfaced by the recommendation engine. Each has a short editorial description ("The score nobody talks about but everyone needs to hear"). This is where OSTrack's editorial voice lives.

---

### Library — The Collector Space

**Current problem:** Tab bar with list items. Functional but completely lacking personality.

**Target:** This is the user's museum. It should feel like looking at your collection.

**Shelves tab redesign:**
- Display shelves as a proper grid — 2 columns, square cover art, shelf name below in serif
- Cover art is auto-generated from the first 4 tracks in the shelf (2×2 collage, like Spotify playlist covers)
- Follower count shown as a small badge on the cover art
- "Create new shelf" is a prominent first card with a `+` and "Start a shelf" in serif italic

**Ratings tab redesign:**
- Sort options: by date, by rating (high/low), by media type, by composer
- Each entry shows OST artwork (small, 48×48px), OST name in serif, user's star rating, date rated
- Long-press to edit rating inline — no navigation required
- A "Rating distribution" summary card at the top: "You've rated 284 OSTs. Average: 3.8★"

**History tab redesign:**
- Timeline format — group by day/week
- Small artwork thumbnail, track name, source OST, timestamp
- Listening history is shown with a subtle timeline connector line between entries
- This should feel like a personal listening diary

---

### Player — The Listening Context

**Current problem:** It's a page about a track. It should feel like being *inside* the track.

**Target:** Full-screen, artwork-dominant. More album art viewer than player UI.

**Layout:**

```
┌─────────────────────────────────┐
│                                 │
│   [Full artwork, dominant]      │
│   Content-extracted bg color    │
│                                 │
│                                 │
│  ─────────────────────────────  │
│  City of Tears                  │  ← display serif, 28px
│  Christopher Larkin             │  ← linked, teal, 14px mono
│  From: Hollow Knight            │  ← gold pill badge
│                                 │
│  ✓ Plays during the rain-soaked │  ← verified scene tag
│  descent into Hallownest        │    italic body text
│                                 │
│  ──── [ ▶ Open in Spotify ] ──  │  ← full-width primary button
│                                 │
│  ★★★★☆  Rate this track        │  ← inline rating
│                                 │
│  Related tracks ──────────────→ │  ← horizontal scroll
└─────────────────────────────────┘
```

The scene tag should feel like a caption on a photograph — not a database field. Italic. Slightly indented. Treated as a quote.

---

### Profile — The Taste Identity

**Current problem:** It's a stats page. It should be a statement.

**Target:** This is a user's public face. It should be something people are proud to share.

**Hero section redesign:**

```
┌─────────────────────────────────┐
│  [Avatar with tier ring]        │
│  @melodyarchive                 │  ← display serif, large
│  Lorekeeper  ·  ✦ Founding     │  ← tier badge + founding mark
│                                 │
│  "Collector of sad boss themes  │  ← bio in italic serif
│   and immaculate scene tags."   │
│                                 │
│  1,284 ratings · 14 shelves    │
│  389 followers · 142 following  │
└─────────────────────────────────┘
```

**Shelf showcase redesign:**
- Show shelves as a horizontal scroll of large cover art tiles (3:2 ratio)
- Shelf name in serif below each tile
- Follower count as a small badge
- Feels like browsing a record store, not a list

**Top composers widget:**
- Small circular composer portraits (or placeholder initials)
- Name below, number of tracks rated beside
- Shows at a glance what kind of listener this person is

**Activity log:**
- Timeline format, same as Library history
- Shows ratings, shelf additions, scene tags, and bounty resolutions
- Small, dense, and scannable — not a feed of full cards

**Stats card (the "gamified flair" moment):**
A dedicated collapsible card with collector stats, styled like a character sheet or RPG status screen:

```
┌─────────────────────────────────┐
│  COLLECTOR STATS          ▾    │  ← mono label
│  ─────────────────────────────  │
│  Total tracks rated    1,284    │
│  Scene tags submitted     47    │
│  Bounties resolved        12    │
│  Shelves followed        389    │
│  Avg. rating             3.8 ★  │
│  Top category       Video Games │
│  Top composer   Yoko Shimomura  │
│  Streak             14 weeks ▒▒ │  ← pixel-art streak bar
│  ─────────────────────────────  │
│  ARCHIVIST TIER II              │  ← tier label in gold
└─────────────────────────────────┘
```

The streak bar should be a tiny pixel-art progress visualization — 7 cells per week, filled for days active. This is the most explicitly gamified element and it should look earned.

---

## Micro-Interactions & Motion

Motion communicates meaning. Every animation should have a reason.

### Star Rating — The Most Important Interaction

This needs to feel deliberate, not instant. When a user rates something:

1. Stars fill left-to-right with a 30ms stagger between each
2. A subtle haptic pulse on each star (medium impact)
3. The final star triggers a gold particle burst — brief, 300ms, tasteful
4. The rating number updates with a counter animation

Half-stars: a tap on the left half of a star gives a half rating. The star fills halfway with a slightly different visual treatment (half fill, not full glow). This is Letterboxd's most beloved UX detail.

### Shelf Creation — The Naming Moment

When a user creates a shelf, the naming screen should feel like naming a character. Display the shelf name in large serif as the user types. Show a live preview of how the shelf will look on their profile. Confirm with a satisfying "shelf created" animation — the shelf card slides up from the bottom of the profile grid, settling into position.

### Scene Tag Verification — The Puzzle Complete

When a submitted scene tag gets verified (moves from 🌀 to ✓), show:
- The badge transition animation — unverified icon dissolves, verified icon stamps in
- A brief gold flash on the entry
- +10 Contributor Points counter animation above the entry
- A haptic notification (success pattern)

### Feed Card Appearance

Cards entering the viewport should animate in with a subtle upward slide (20px, 200ms, ease-out). Not every card — only cards that weren't visible on initial load. This creates the sensation of a living feed, not a static list.

### Shelf Cover Art Generation

When a user adds a track to a shelf, the cover art mosaic regenerates with a smooth crossfade. The new artwork tile slides in from the correct quadrant position. This makes the shelf feel alive.

### Player Artwork Ambient Color

When the player changes tracks, the extracted background color transitions over 600ms. Not instant — a slow dissolve that feels like the mood changing. This is the most cinematic interaction in the app and should be prioritized.

---

## The Emotional Arc

The best apps create an emotional arc through their UX. Define what a user should feel at each stage.

**First open:** *"Oh. This is for people like me."*
The onboarding media grid needs to be beautiful enough that scrolling it is a pleasure in itself. Large, rich artwork. Recognizable titles. The act of selecting 5+ favorites should feel like curating, not form-filling.

**First shelf creation:** *"This is mine."*
The moment a user creates their first shelf and gives it a name, they've committed. The UX should honor that. The naming screen should be generous with space. The confirmation should feel celebratory without being annoying.

**First scene tag accepted:** *"I contributed something real."*
The verification animation and Contributor Points notification should make this feel like an achievement, because it is. This is how the database gets populated and it should feel meaningful every time.

**Discovering a shelf with 200 followers:** *"People care about this."*
The follower count badge should be prominent enough that finding a popular shelf surprises you. This creates aspiration — "I want my shelf to look like that."

**Seeing a friend's rating of something you love:** *"We get it."*
The feed should be dense enough with context that this moment happens regularly. Shared taste is the product.

---

## Implementation Phases

### Phase 1 — The Foundation (Do this before anything else)
These changes are systemic. Do them once and don't revisit.

- Implement the new type scale in `ostrack_theme.dart` (serif display + mono labels + warm sans body)
- Load Canela/Playfair, Space Mono, and Outfit from Google Fonts
- Implement the desaturated color palette
- Switch to the 8px grid system — audit every padding value in every file
- Implement the elevation model (color steps instead of shadows)
- Remove all `BoxShadow` from cards
- Replace `Press Start 2P` with Space Mono for labels
- The result: still generic, but no longer visually noisy

### Phase 2 — The Feed
The home feed is what people see first and return to most.

- Redesign feed card components: shelf cards, rating cards, scene tag cards, On This Day card
- Implement avatar with tier ring system (static rings first)
- Implement the star rating micro-interaction (stagger fill + haptic)
- Content-driven card visual hierarchy (artwork as hero, not icon)
- Ad cards styled as native content — not banner ads

### Phase 3 — The Media Source Page
Build the most important screen properly.

- Full-bleed artwork hero with gradient fade
- Rating distribution bar chart
- Tracklist with inline expansion
- Scene Timeline tab with fidelity badges
- Content-extracted ambient background color
- Forum tab (basic threaded view)

### Phase 4 — The Profile
Make collector identity real.

- Profile hero with tier ring (animated for Curator+)
- Collector Stats card (character sheet style)
- Shelf showcase as horizontal scroll grid
- Streak visualization (pixel-art calendar)
- Top composers widget
- Founding Archivist mark

### Phase 5 — Player & Polish
The premium layer.

- Full-screen player with artwork dominance
- Ambient color extraction and background transition
- Scene tag as styled quote
- Related tracks horizontal scroll
- Shelf and rating quick-actions without navigation

### Phase 6 — Motion & Delight
Only after Phase 1–5 are solid.

- Feed card entrance animations
- Shelf cover art mosaic animation
- Scene tag verification stamp animation
- Contributor Points counter animation
- Star rating particle burst
- Achievement unlock animation for tier upgrades

---

## What to Cut

Features that add visual noise and cognitive load without earning their place.

**Cut: The `OstrackBackdrop` glow orbs.** They're trying to add depth but they create a muddy background. Replace with a clean solid `#0C0C0F`. Content provides all the color needed.

**Cut: `OstrackPill` used as a primary UI element.** Pills are fine for tags and status badges. They're not navigation, not section headers, not primary labels. Currently they're doing too much work.

**Cut: The 5-tab bottom nav with a dedicated Player tab.** The Player isn't a destination — it's a context layer that appears when something is playing. Replace with a 4-tab nav (Home, Explore, Library, Profile) and a persistent mini-player bar above the nav bar that expands to full-screen. This is how every great music app handles it.

**Cut: `LinearProgressIndicator` in onboarding.** Replace with a step indicator — small dots or numbered steps. The progress bar is functional but it's not delightful.

**Cut: `CircleAvatar` with a generic person icon.** Every profile needs real avatar initials at minimum, properly styled. The person icon reads as "no data."

---

## Reference Material

Study these in order.

**Primary references:**
- Letterboxd (iOS) — typography, feed design, film pages, list pages
- Letterboxd (web) — rating distribution bars, review display, profile pages
- Dark Sky (archived) — how to make data feel emotional
- Apple Music — artwork-driven player, ambient color extraction

**Secondary references:**
- Untitled UI design system — spacing and elevation model
- Linear (app) — how to make a technical tool feel refined
- Pitch (app) — typography as personality

**Game UI references (for the gamified layer):**
- Hollow Knight — status menus and achievement design
- Hades — how game UI communicates earned progress
- Final Fantasy XIV — profile and achievement systems that feel like collector's items

**Typography study:**
- Canela typeface specimen — understand why high-contrast serifs feel editorial
- iA Writer typography principles — why readable body text matters
- Letterboxd's CSS — the font choices they make and why

---

*This document describes a design direction, not a single sprint. Phase 1 makes the app defensible. Phases 2–4 make it distinctive. Phases 5–6 make it beloved.*

*Every decision in this document is reversible except the type system. Get the typography right first. Everything else follows.*

*Version 1.0 · April 2026*
