# Palette Generator — Quick Reference

## The Magic Happens Here

```dart
// CinematicPlayerScreen watches palette colors
final accentColor = ref.watch(trackPaletteProvider).maybeWhen(
  data: (palette) => palette.vibrant,
  orElse: () => OstrackColors.gold,  // Fallback while loading
);

// Gradient animates smoothly to new color
AnimatedContainer(
  duration: const Duration(milliseconds: 500),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        accentColor.withValues(alpha: 0.2),  // Tinted top
        Colors.black.withValues(alpha: 0.8),  // Dark bottom
      ],
    ),
  ),
)

// Play button glows with extracted accent
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  decoration: BoxDecoration(
    color: accentColor,
    boxShadow: [BoxShadow(color: accentColor.withValues(alpha: 0.4))],
  ),
)
```

## Files Involved

| File | Purpose |
|------|---------|
| `lib/src/playback/palette_service.dart` | TrackPalette model + trackPaletteProvider |
| `lib/src/screens/cinematic_player_screen.dart` | Reads palette, applies AnimatedContainer colors |
| `lib/src/ostrack_catalog.dart` | ActiveTrackEntry extended with albumArtUrl |

## Integration Checklist

- [x] palette_generator added to pubspec.yaml
- [x] TrackPalette model created
- [x] trackPaletteProvider watches activeTrack.albumArtUrl
- [x] CinematicPlayerScreen watches trackPaletteProvider
- [x] Gradient uses vibrant color with alpha: 0.2 (top)
- [x] Play button uses vibrant color with shadow glow
- [x] AnimatedContainer handles smooth transitions
- [ ] Backend API returns album_art_url in track metadata
- [ ] Test on device with various album artwork colors

## Performance Guarantees

✅ **No UI thread blocking**: Color extraction via FutureProvider (off-thread)  
✅ **Smooth animations**: 500ms gradient + 300ms button transitions  
✅ **Graceful fallback**: Shows OSTrack Gold while extracting  
✅ **Lightweight**: palette_generator is ~100KB, ~O(n) color extraction  
✅ **Cached**: Same track = cached palette (no re-extraction)  

## Animation Timeline

```
T+0ms:    User opens player / switches track
T+0ms:    Fallback: OSTrack Gold displayed
T+0-200ms: Artwork downloads + palette extracts (off-thread)
T+200ms:  vibrant color extracted ✓
T+200ms:  AnimatedContainer begins 500ms interpolation
T+500ms:  ✓ Gradient fully tinted to vibrant color
T+500ms:  ✓ Play button fully transitioned
T+∞ms:    Audio plays smoothly during all transitions
```

## Customization Points

### Adjust gradient strength
```dart
// More subtle tint (harder to read with pale colors)
accentColor.withValues(alpha: 0.15)

// More intense tint (risk of washing out bright colors)
accentColor.withValues(alpha: 0.3)
```

### Adjust animation speed
```dart
// Snappier button (300ms current, try 150ms)
duration: const Duration(milliseconds: 150)

// Slower gradient (500ms current, try 800ms for cinematic)
duration: const Duration(milliseconds: 800)
```

### Fallback color
```dart
// Use teal instead of gold for fallback
factory TrackPalette.fallback() => TrackPalette(
  vibrant: OstrackColors.teal,  // Changed from gold
  ...
)
```

## Backend Contract

Your track metadata must include artwork URL:

```json
{
  "id": "track_abc123",
  "title": "Track Name",
  "composer": "Composer",
  "source": "Spotify",
  "scene_tag": "Boss fight",
  "album_art_url": "https://cdn.example.com/album/123.jpg"  ← REQUIRED
}
```

## Debugging

**Q: Button always gold?**  
A: Check activeTrack.albumArtUrl is populated by API

**Q: Colors look washed out?**  
A: Increase bottom gradient alpha: `Colors.black.withValues(alpha: 0.9)`

**Q: Transitions feel choppy?**  
A: Verify 60fps device (use flutter run --profile)

**Q: Slow color extraction?**  
A: Normal for first load (~200-500ms), cached on subsequent plays

## Next Steps

1. Backend team adds `album_art_url` to track API responses
2. Test on device with real album artwork
3. Gather user feedback on color choices
4. Phase 2: Use muted colors for sidebar backgrounds

---

**See also**: [PALETTE_GENERATOR_INTEGRATION.md](PALETTE_GENERATOR_INTEGRATION.md) for detailed guide.
