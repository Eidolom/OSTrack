# OSTrack — Local Music
*Own your soundtrack. Play it where the context lives.*

---

## Overview

Local Music is a first-party import layer that lets users link audio files they already own to tracks in the OSTrack catalog. A user who bought the NieR:Automata soundtrack on Bandcamp, ripped a physical CD, or downloaded Steam DLC gets to play their owned copy inside the app — with full access to scene timelines, ratings, shelf attribution, and community context.

No automatic matching. No guessing. Users link files to tracks manually, which fits OSTrack's deliberate curation identity and eliminates an entire category of edge-case bugs.

---

## Why This Exists

Streaming covers the mainstream catalog well. It covers OST culture poorly.

A significant portion of the soundtracks OSTrack's core users care about live entirely outside Spotify and Apple Music:

- Doujin game music (itch.io, Booth, direct composer sales)
- Bandcamp-only releases from indie composers
- Steam soundtrack DLC
- Physical CD rips (especially Japanese releases never licensed for streaming)
- Limited Kickstarter or crowdfunded OST releases
- Fan arrangements cleared under CC license

These tracks exist in OSTrack's metadata catalog — they have track pages, scene tags, ratings, forum threads — but currently have no playback path. Local Music fills that gap without any business negotiation or licensing dependency.

---

## Core Principles

**Manual linking only.** Automatic filename matching produces wrong results silently. OSTrack's users are deliberate catalogers — they prefer to confirm than to guess. The manual flow is not a limitation, it is the feature.

**Local files take playback priority.** If a user bothered to import a file, that is their preferred version. The playback hierarchy respects that.

**Files are copied, not referenced.** OSTrack copies imported files into its own sandboxed Documents directory. This ensures persistence across iOS restarts, prevents broken references when external files move, and makes storage management predictable.

**Catalog entry is never tied to the file.** Deleting a local file removes the audio source but leaves the track page, ratings, scene tags, and shelf memberships completely intact. The file and the catalog record are independent.

---

## Playback Priority Hierarchy

When a user taps play on any track, OSTrack resolves the source in this order:

```
1. Local file present and valid       → play local (always preferred)
2. Spotify linked and track available → Spotify App Remote SDK
3. Apple Music linked and available   → Apple MusicKit
4. YouTube ID available               → YouTube deep-link fallback
5. No source available                → "No playback source" state
```

A setting in the playback preferences allows users to deprioritise local files in favour of their linked streaming service — for users who prefer streaming quality over their local rip, or who want to save device storage but still keep a file linked as a reference.

---

## Linking Flow — Single Track

Entry point: the playback row on any Track Page.

The playback row shows the available sources for a track. When no local file is linked, a **"Link local file"** action appears alongside the streaming options.

**Step by step:**

1. User taps "Link local file" on the Track Page
2. System file picker opens, filtered to audio file types (`.mp3`, `.wav`, `.flac`, `.aac`, `.m4a`, `.ogg`)
3. User selects one file
4. OSTrack validates: checks file is readable, has a non-zero duration, and is a recognised audio format
5. OSTrack copies the file into its sandboxed Documents directory under a stable internal path
6. The track record is updated with the local file reference
7. Track Page playback row updates to show a `LOCAL` badge and the file is immediately playable
8. A brief confirmation: "Local file linked. Playing from your library."

**If validation fails** (corrupted file, unsupported format, zero-length): show a clear error with the specific reason and leave the track unchanged.

---

## Linking Flow — Full OST (Bulk Import)

Entry point: "Link local files" action on a Media Source Page, accessible from the OST action row alongside "Rate this OST" and "Add to Shelf".

This flow is designed for importing a complete purchased soundtrack — a user who bought the Hollow Knight OST on Bandcamp and wants to link all 57 tracks.

**Step by step:**

1. User taps "Link local files" on the Media Source Page
2. System file picker opens in multi-select mode
3. User selects all files (can be 1 or many)
4. OSTrack copies all selected files into its sandboxed directory
5. A **Linking Screen** opens showing two columns:

```
IMPORTED FILES                    LINK TO TRACK
──────────────────────────────────────────────────
01 - City of Tears.mp3      →    [ City of Tears ▾ ]
02 - Greenpath.mp3          →    [ Greenpath ▾ ]
03 - Mantis Lords.mp3       →    [ Mantis Lords ▾ ]
04 - Radiance.mp3           →    [ Search tracks... ]
...
```

Left column: the imported filenames, non-editable  
Right column: a searchable dropdown scoped to this OST's tracklist

6. User manually assigns each file to the correct track. The dropdown shows all tracks in the OST ordered by track number. Fuzzy search is available — typing "mantis" filters to matching tracks.
7. Tracks already linked in a previous session show a `✓ LINKED` indicator and are skipped by default
8. A progress indicator shows: "14 of 57 tracks linked"
9. User taps "Confirm links" — all assignments are saved simultaneously
10. User can exit and return — partial progress is preserved

**Unlinked files** (files the user imported but didn't assign) are held in a temporary import buffer for 7 days, then discarded. The user sees a count of unlinked files in the Linking Screen header and can return to complete the job.

---

## Track Page — Local File Indicator

When a local file is linked, the playback row on the Track Page updates:

```
┌─────────────────────────────────────┐
│  ▶ Play                             │
│                                     │
│  LOCAL  ·  City of Tears.mp3        │
│  44.1kHz · FLAC · 18.4 MB          │
│                                     │
│  [Change file]  [Remove]            │
└─────────────────────────────────────┘
```

- **LOCAL** badge in teal — consistent with the verified state color, signals a trusted source
- Filename, sample rate, format, and file size shown in mono metadata style
- **Change file** — opens the single-file picker to replace the linked file
- **Remove** — deletes the copy from app storage, removes the local source reference, track page returns to streaming sources. Confirms before deleting.

---

## Media Source Page — Local Coverage Indicator

On an OST page with some or all tracks linked locally, a coverage indicator appears in the metadata row:

```
GAME · 2022 · 285 TRACKS · 57 LOCAL
```

Tapping the `57 LOCAL` label opens a filtered view of the tracklist showing only locally linked tracks, with an option to open the bulk Linking Screen to fill gaps.

---

## Storage Management

Accessible from Settings → Local Music.

```
LOCAL MUSIC  ────────────────────────────────

Storage used          2.4 GB

OSTs with local files
──────────────────────────────────────────────
Hollow Knight          57 tracks · 412 MB  [▸]
NieR:Automata          23 tracks · 189 MB  [▸]
Celeste                26 tracks · 198 MB  [▸]

Unlinked files         3 files · 24 MB    [▸]

──────────────────────────────────────────────

[Clear all local files]
```

Tapping an OST row shows the individual tracks with their file sizes and a per-track remove option.

**Clear all local files** — removes all copied audio from app storage, unlinks all local sources, leaves all catalog data (ratings, tags, shelf memberships) completely intact. Requires confirmation.

**Unlinked files** — files imported during a bulk session that were never assigned to a track. Shows a list with the option to either assign them now (opens Linking Screen) or discard them.

---

## Supported Formats

| Format | Extension | Notes |
|---|---|---|
| MP3 | `.mp3` | Universal support — the most common format for purchased OSTs |
| FLAC | `.flac` | Lossless — common for Bandcamp purchases and CD rips |
| WAV | `.wav` | Uncompressed — Steam DLC often delivers WAV |
| AAC | `.aac`, `.m4a` | iTunes purchases, some streaming downloads |
| OGG Vorbis | `.ogg` | Common in open-source game engines |

Unsupported formats produce a clear error at the validation step with a suggestion to convert the file before importing.

---

## Platform Notes

### iOS

Apple's sandboxing requires files to be copied into the app's Documents directory — a reference to a file in the Files app cannot be held long-term. The copy happens at import time. Users grant access via the `UIDocumentPickerViewController` (the standard Files sheet).

Multi-select is supported natively in the iOS Files picker. Users can navigate to a folder containing an entire soundtrack download and select all files at once.

OSTrack should request iCloud Drive access so users who download purchases to iCloud can import directly without moving files to local storage first.

### Android

Android's Storage Access Framework is more permissive. Users can grant persistent read access to a folder via `ACTION_OPEN_DOCUMENT_TREE`, which would allow OSTrack to monitor a "watch folder" for new files. This is a Phase 3 enhancement — at launch, the same copy-on-import model as iOS is used for consistency.

Multi-select via `ACTION_OPEN_DOCUMENT` with `EXTRA_ALLOW_MULTIPLE = true`.

---

## Technical Implementation

### Package

`just_audio` — already in the planned stack — handles local file playback natively:

```dart
final player = AudioPlayer();
await player.setAudioSource(
  AudioSource.uri(Uri.file(localFilePath)),
);
await player.play();
```

No additional packages required for playback.

### File Storage Path

```
[App Documents Directory]
  └── local_music/
        └── [track_id]/
              └── [stable_filename].[ext]
```

One directory per track ID. If a file is replaced, the old file is deleted and the new one takes its place. Track ID as the directory name means the reference is stable even if the user renames the original file on their device.

### Database Schema Addition

Two additions to the existing ERD:

```
local_track_files
  ├── id (uuid, pk)
  ├── track_id (uuid, fk → tracks.id)
  ├── user_id (uuid, fk → users.id)
  ├── file_path (text, not null)       -- relative to app Documents dir
  ├── original_filename (text)         -- preserved for display
  ├── format (enum: mp3, flac, wav, aac, ogg)
  ├── file_size_bytes (int)
  ├── duration_seconds (int)
  ├── sample_rate_hz (int, nullable)
  ├── created_at (timestamptz)
  └── updated_at (timestamptz)

Unique constraint: (track_id, user_id)    -- one local file per track per user

import_buffer
  ├── id (uuid, pk)
  ├── user_id (uuid, fk → users.id)
  ├── media_source_id (uuid, fk → media_sources.id, nullable)
  ├── file_path (text, not null)
  ├── original_filename (text)
  ├── file_size_bytes (int)
  ├── expires_at (timestamptz)          -- 7 days after import
  └── created_at (timestamptz)
```

### AppPreferences Addition

No change required. Local file state lives in the database (or local SQLite via `isar` — already planned), not in SharedPreferences. SharedPreferences is for lightweight UI state; file metadata is structured data.

---

## Roadmap Placement

**Phase 2** — after core catalog and playback SDK integration are stable.

The `just_audio` local file support is essentially free. The engineering work is:

| Task | Estimate |
|---|---|
| Single-file import flow + file picker integration | Small |
| File copy + validation + path management | Small |
| Track Page playback row update (LOCAL badge) | Small |
| Bulk import file picker + Linking Screen UI | Medium |
| Partial progress persistence for bulk sessions | Medium |
| Storage management screen | Small |
| iOS iCloud Drive access | Small |
| Android watch folder (Phase 3) | Medium |

---

## Open Questions

| # | Question | Recommendation |
|---|---|---|
| 1 | Should local files sync across devices via iCloud/Google Drive? | Phase 3+ — complex, but the right long-term answer for users who own an iPad and a phone |
| 2 | Should OSTrack display waveform or chapter markers from file metadata? | Read ID3/FLAC tags at import time — chapter data is rare but could enrich scene timeline timestamps |
| 3 | Max file size limit? | 500 MB per file covers any realistic lossless track. Warn above 100 MB. |
| 4 | Streaming preference override setting — per-track or global? | Global is simpler; per-track is more powerful. Start global. |
| 5 | What happens to local files if a user deletes their OSTrack account? | Files in app sandbox are deleted with the app. No server-side copies ever stored. Mention in Privacy Policy. |

---

*Document version 1.0 · April 2026*
*Local Music — for the tracks streaming forgot*
