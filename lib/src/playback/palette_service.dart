import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';

import '../app_providers.dart';
import '../ostrack_theme.dart';

/// Extracted color palette from album artwork.
class TrackPalette {
  final Color dominant;
  final Color vibrant;
  final Color muted;

  TrackPalette({
    required this.dominant,
    required this.vibrant,
    required this.muted,
  });

  /// Fallback colors if extraction fails or no artwork available.
  factory TrackPalette.fallback() => TrackPalette(
        dominant: Colors.grey.shade900,
        vibrant: OstrackColors.gold, // OSTrack Gold
        muted: Colors.grey.shade700,
      );
}

/// Asynchronously extracts dominant colors from the active track's album artwork.
/// 
/// Uses FutureProvider to fetch colors without blocking the UI thread.
/// Gracefully falls back to default palette if artwork is unavailable or extraction fails.
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
      vibrant: palette.vibrantColor?.color ??
          palette.dominantColor?.color ??
          OstrackColors.gold,
      muted: palette.mutedColor?.color ?? Colors.grey.shade700,
    );
  } catch (e) {
    // Silently fall back to default palette on extraction failure
    return TrackPalette.fallback();
  }
});
