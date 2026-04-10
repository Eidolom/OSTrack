# Dynamic Palette Integration Guide

## Overview

The **Palette Generator** integration transforms the Cinematic Player from static gold accents into a **color-adaptive experience** that matches your album artwork. The player's gradient and play button dynamically shift to complement the dominant album color — all without blocking the audio playback thread.

## Architecture: Non-Blocking Background Color Extraction

```
Album Artwork
        ↓
FutureProvider (palette extraction)
        ↓
Palette (dominant, vibrant, muted colors)
        ↓
CinematicPlayerScreen consumes vibrant color
        ↓
AnimatedContainer (smooth 500ms transition)
        ↓
Player UI morphs to match album
```

### Why FutureProvider?
- **Non-blocking**: Extraction runs off the main thread
- **Memoized**: Same track = cached palette (no re-extraction)
- **Graceful fallback**: Uses OSTrack Gold while extracting, if extraction fails

## Key Components

### 1. TrackPalette Model

```dart
class TrackPalette {
  final Color dominant;   // Most common color in artwork
  final Color vibrant;    // Most saturated color (used for UI)
  final Color muted;      // Desaturated color (future use - sidebar backgrounds)
  
  factory TrackPalette.fallback() => TrackPalette(
    dominant: Colors.grey.shade900,
    vibrant: OstrackColors.gold,    // Fallback
    muted: Colors.grey.shade700,
  );
}
```

### 2. trackPaletteProvider

```dart
final trackPaletteProvider = FutureProvider<TrackPalette>((ref) async {
  final activeTrack = ref.watch(activeTrackProvider).valueOrNull;
  
  if (activeTrack == null || activeTrack.albumArtUrl.isEmpty) {
    return TrackPalette.fallback();
  }
  
  try {
    final imageProvider = NetworkImage(activeTrack.albumArtUrl);
    final palette = await PaletteGenerator.fromImageProvider(
      imageProvider,
      maximumColorCount: 10,
    );
    
    return TrackPalette(
      dominant: palette.dominantColor?.color ?? Colors.grey.shade900,
      vibrant: palette.vibrantColor?.color ?? ...,
      muted: palette.mutedColor?.color ?? ...,
    );
  } catch (e) {
    return TrackPalette.fallback();
  }
});
```

## How It Works in CinematicPlayerScreen

### Step 1: Watch the Palette

```dart
// In build method:
final paletteAsync = ref.watch(trackPaletteProvider);

// Extract accentColor with graceful fallback to gold while loading
final accentColor = paletteAsync.maybeWhen(
  data: (palette) => palette.vibrant,
  orElse: () => OstrackColors.gold,
);
```

### Step 2: Apply to Gradient (with animation)

```dart
BackdropFilter(
  filter: ImageFilter.blur(sigmaX: 45.0, sigmaY: 45.0),
  child: AnimatedContainer(
    duration: const Duration(milliseconds: 500),  // Smooth color transition
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          accentColor.withValues(alpha: 0.2),      // Subtle tint at top
          Colors.black.withValues(alpha: 0.8),     // Deep black at bottom
        ],
      ),
    ),
  ),
)
```

### Step 3: Apply to Play Button (with glow effect)

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: accentColor,  // Matches album color
    boxShadow: [
      BoxShadow(
        color: accentColor.withValues(alpha: 0.4),  // Colored glow
        blurRadius: 12,
        spreadRadius: 2,
      )
    ],
  ),
  child: StreamBuilder<PlayerState>(
    /* ... play/pause icon ... */
  ),
)
```

## Animation Details

| Element | Duration | Curve | Effect |
|---------|----------|-------|--------|
| Gradient | 500ms | default (linear) | Smooth color wash |
| Play Button | 300ms | default | Quick accent shift |
| Album Artwork | 300ms (Hero) | default | Expands on screen open |

These durations are tuned for smooth album transitions without being distracting during playback.

## Performance Profile

| Operation | Timing | Impact |
|-----------|--------|--------|
| Color extraction | ~200-500ms (off-main thread) | Not visible to user |
| First frame (fallback) | Immediate | Shows OSTrack Gold while extracting |
| Gradient animation | 500ms | Smooth during song change |
| Play button animation | 300ms | Feels responsive |

**Result**: User -sees immediate gold button, then smooth color transition within 500ms as artwork loads and colors extract.

## Testing the Feature

### Manual Test
1. Open the Cinematic Player on a track with colorful album art (e.g., electronic music)
2. Observe: Button starts gold, transitions to accent color
3. Observe: Gradient top edge tints to match accent
4. Skip to another track with different artwork
5. Verify: Smooth 500ms transition to new accent color
6. Verify: No audio stutter during color transition

### Edge Cases
- **No artwork**: Falls back to OSTrack Gold
- **Transparent artwork**: Extraction succeeds, color may be pale (still usable)
- **Tight color palette**: Palette generator handles grayscale/limited colors gracefully
- **Slow network**: Shows fallback color while image downloads in background

## Phase 2+ Enhancements

- [ ] Use `palette.muted` for scene timeline sidebar background
- [ ] Extract text color (light/dark) to auto-adjust label legibility
- [ ] Add `palette.lightVibrant` and `palette.darkMuted` for more sophisticated gradients
- [ ] Animate gradient colors on seeking (jump to beat-matched colors at different timestamps)
- [ ] Cache palettes in Isar for faster re-loads on repeat plays

## Data Model Update

The `ActiveTrackEntry` now includes `albumArtUrl`:

```dart
class ActiveTrackEntry {
  const ActiveTrackEntry({
    required this.title,
    required this.composer,
    required this.source,
    required this.description,
    required this.sceneTag,
    this.albumArtUrl = '',  // NEW: URL for palette generation
  });
}
```

### Backend Requirements
Your media source API must return `album_art_url` (or equivalent) in the track metadata:

```json
{
  "id": "track_123",
  "title": "Final Boss Battle",
  "composer": "Composer Name",
  "source": "Spotify",
  "sceneTag": "Epic finale",
  "album_art_url": "https://cdn.example.com/artwork/123.jpg"
}
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Button always gold | Check that `activeTrack.albumArtUrl` is populated |
| Colors too bright | Adjust alpha in gradient (increase from 0.2 to 0.3-0.4) |
| Colors extract too slow | Increase palette extraction timeout or pre-cache |
| Gradient looks washed out | Increase gradient bottom alpha from 0.8 to 0.9 |
| Animation feels jerky | Verify device has smooth AnimatedContainer (60fps) |

## Dependencies

```yaml
dependencies:
  palette_generator: ^0.3.3  # Color extraction from images
  flutter_riverpod: ^2.6.1   # Async state management
  cached_network_image: ^3.3.1  # Image caching
```

---

**Next Step**: Update your backend API to include `album_art_url` in track metadata responses.
