# Cinematic Player Integration Guide

## Overview

The **Cinematic Player Screen** transitions OSTrack from a database experience to a premium emotional moment. Here's how to integrate it into your existing shell.

## Architecture: The Performance Secret

The key to maintaining **60fps during playback** is detaching the UI stream subscription from Riverpod state management:

```
Riverpod State Tree (expensive rebuilds)
    ↓
[CinematicPlayerScreen] ← Wrapped once, NEVER REBUILDS
    ↓
StreamBuilder (positionStream) ⟲ Audio Engine (native, efficient)
```

When the user scrubs or the track time updates, **only the StreamBuilder widgets rebuild**, not the entire widget tree.

## Integration Points

### 1. **From the Mini-Player Context Bar** (Recommended)

In `ostrack_shell.dart`, add a GestureDetector around your mini-player:

```dart
GestureDetector(
  onTap: () => showModalBottomSheet(
    context: context,
    isScrollControlled: true,         // Crucial: enables full-screen
    useRootNavigator: true,           // Covers bottom nav
    backgroundColor: Colors.transparent,
    builder: (context) => const CinematicPlayerScreen(),
  ),
  child: Container(
    // Your existing mini-player UI
  ),
)
```

### 2. **From Explore Track Cards**

In your media source page or track list:

```dart
// In your track card onTap
onTap: () {
  // First: load the track into your audio service
  final audioService = ref.read(originalAudioServiceProvider);
  await audioService.playUrl(trackUrl);
  
  // Then: show the cinematic player
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (context) => CinematicPlayerScreen(
      activeTrack: track,
      albumArtUrl: track.artworkUrl,  // If available
    ),
  );
}
```

### 3. **From Home Feed "Now Playing" Card**

When users tap the active track card in Home:

```dart
onTap: () {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const CinematicPlayerScreen(),
  );
}
```

## Data Model Requirements

The `CinematicPlayerScreen` expects `ActiveTrackEntry`:

```dart
class ActiveTrackEntry {
  const ActiveTrackEntry({
    required this.title,       // Track name
    required this.composer,    // Composer/artist name
    required this.source,      // Platform name (Spotify, OSTrack Original, etc.)
    required this.description, // Metadata (not used in v1, for Phase 2 polish)
    required this.sceneTag,    // Scene context (displayed in teal box)
  });
}
```

**Phase 2 Enhancement**: Extend with `albumArtUrl` when artwork caching pipeline is ready.

## Optional Parameters

```dart
CinematicPlayerScreen(
  activeTrack: track,              // null = uses activeTrackProvider
  albumArtUrl: 'https://...',      // null = uses placeholder
)
```

## Audio Playback Integration

Ensure your audio service is initialized **before** launching the player:

```dart
// Option A: Auto-play (recommended for UX)
final audioService = ref.read(originalAudioServiceProvider);
await audioService.playUrl(trackUrl);

// Then show player
showModalBottomSheet(...);

// Option B: Player controls auto-play/pause
// (The cinematic player handles play/pause via StreamBuilder)
```

## Customization Points

### Theme Colors (in lib/src/ostrack_theme.dart)

- **Glass blur sigma**: Edit `BackdropFilter(filter: ImageFilter.blur(sigmaX: 45.0, ...))` 
  - Higher = more blur, smoother aesthetic
  - Lower = sharper, more focused
  
- **Gradient darkness**: Adjust the LinearGradient alpha values:
  - Top: `Colors.black.withValues(alpha: 0.3)` (lighter, artwork peeking through)
  - Bottom: `Colors.black.withValues(alpha: 0.8)` (darker for text contrast)

- **Button colors**: Change `OstrackColors.gold` to any color defined in `ostrack_theme.dart`

### Adding Skip Functionality

The `_buildControls` method has TODO comments for skip buttons. To wire them:

```dart
IconButton(
  onPressed: () async {
    // Access queue management (Phase 1.1 feature)
    final playlist = ref.watch(currentPlaylistProvider);
    final nextTrack = playlist.nextTrack();
    
    final audioService = ref.read(originalAudioServiceProvider);
    await audioService.playUrl(nextTrack.audioUrl);
    
    // Optionally: refresh activeTrackProvider
    ref.invalidate(activeTrackProvider);
  },
)
```

## Performance Checklist

✅ **Detached StreamBuilder**: Only rebuilds progress bar and controls  
✅ **No setState loops**: Uses `async`/`await` instead  
✅ **Cached images**: `CachedNetworkImage` with `cached_network_image` package  
✅ **Glassmorphism blur**: Heavy CPU initially, then GPU-cached  
✅ **60fps target**: AudioPlayer handles timing independently  

## State Management Notes

- `activeTrackProvider`: Metadata only (doesn't update during playback)
- `originalAudioServiceProvider`: Direct access to just_audio player
- `playerStateStream`: Directly accessed by StreamBuilder, bypasses Riverpod

This separation ensures the Riverpod graph never invalidates during playback.

## Testing

1. **Open player**, tap mini-player context bar
2. **Verify smooth slide-up** (animation smooth, no jank)
3. **Play audio** (track plays smoothly, progress updates smoothly)
4. **Scrub scrubber** (no UI stuttering, seek is responsive)
5. **Toggle play/pause** (controls respond instantly)
6. **Close player** (slide-down animation smooth, mini-player state persists)

## Phase 2 Roadmap

- [ ] Palette-based dynamic gradient from album artwork
- [ ] Scene timeline scrubbing UI (tap to jump to specific timestamp)
- [ ] Queue preview / skip next visualization
- [ ] Ambient color transitions (already in mini-player, extend to full screen)
- [ ] Lyric/scene context scrolling sidebar
- [ ] Heart/bookmark quick action overlay

---

**Note**: This integration guide assumes you have:
- ✅ `flutter_riverpod` setup complete
- ✅ `just_audio` initialized in `OriginalAudioService`
- ✅ `connectivity_plus` context (offline banner) wrapping your shell
- ✅ `audio_video_progress_bar` package added to pubspec.yaml
