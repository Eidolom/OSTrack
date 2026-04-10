import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:just_audio/just_audio.dart';

import '../app_providers.dart';
import '../ostrack_catalog.dart';
import '../ostrack_theme.dart';
import '../playback/palette_service.dart';
import '../widgets/scene_tag_submission_modal.dart';

/// Full-screen cinematic player with glassmorphism aesthetic.
/// Detaches playback UI from Riverpod state to maintain 60fps during audio playback.
class CinematicPlayerScreen extends ConsumerWidget {
  const CinematicPlayerScreen({
    super.key,
    this.activeTrack,
    this.albumArtUrl,
  });

  /// Optional active track metadata. If null, screen shows empty state.
  final ActiveTrackEntry? activeTrack;

  /// Album artwork URL. Falls back to theme placeholder if not provided.
  final String? albumArtUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use provided track or watch from provider (optional for flexibility)
    final track = activeTrack ?? ref.watch(activeTrackProvider).valueOrNull;
    
    // Watch the palette provider for dynamic colors from album artwork
    final paletteAsync = ref.watch(trackPaletteProvider);
    
    // Extract the vibrant color (or default to OSTrack Gold while loading)
    final accentColor = paletteAsync.maybeWhen(
      data: (palette) => palette.vibrant,
      orElse: () => OstrackColors.gold,
    );

    if (track == null) {
      return Scaffold(
        backgroundColor: OstrackColors.background,
        body: Center(
          child: Text(
            'No track loaded',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white54,
            ),
          ),
        ),
      );
    }

    final artworkUrl = albumArtUrl ?? 
        'https://via.placeholder.com/400?text=${Uri.encodeComponent(track.title)}';

    return Scaffold(
      backgroundColor: OstrackColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. DYNAMIC BACKGROUND with blur
          CachedNetworkImage(
            imageUrl: artworkUrl,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Container(
              color: OstrackColors.teal,
              child: const Icon(Icons.music_note, size: 64, color: Colors.white30),
            ),
          ),

          // 2. GLASSMORPHISM: Blur + Animated Gradient Overlay with dynamic color
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 45.0, sigmaY: 45.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    accentColor.withValues(alpha: 0.2), // Subtle tint at top
                    Colors.black.withValues(alpha: 0.8), // Deep black at bottom
                  ],
                ),
              ),
            ),
          ),

          // 3. FOREGROUND INTERACTIVE UI
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(context),
                  const Spacer(),

                  // Main Album Art Hero
                  Center(
                    child: Hero(
                      tag: 'album_art_${track.title}',
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 30,
                              offset: const Offset(0, 15),
                            )
                          ],
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(artworkUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Track Metadata
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              track.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              track.composer,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: OstrackColors.gold.withValues(alpha: 0.8),
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      // Platform Badge
                      _buildPlatformBadge(track.source),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Contextual Scene Tag (OSTrack Differentiator)
                  _buildSceneTimelineTag(context, ref, track),

                  const SizedBox(height: 16),

                  // THE MAGIC: Stream-Driven Scrubber (detached from Riverpod)
                  _buildScrubber(ref),

                  const SizedBox(height: 24),

                  // Playback Controls (also stream-driven)
                  _buildControls(ref, accentColor),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Top bar with close button, now-playing label, and options menu
  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Colors.white, size: 32),
          onPressed: () => Navigator.of(context).pop(),
        ),
        Text(
          'NOW PLAYING',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            letterSpacing: 2.0,
            color: Colors.white54,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz, color: Colors.white),
          onPressed: () {
            // TODO: Open shelf/options menu
          },
        ),
      ],
    );
  }

  /// Small platform indicator badge
  Widget _buildPlatformBadge(String platform) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.music_note, size: 14, color: OstrackColors.teal),
          const SizedBox(width: 4),
          Text(
            platform,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  /// Scene timeline context tag (dynamic in Phase 2)
  Widget _buildSceneTimelineTag(BuildContext context, WidgetRef ref, ActiveTrackEntry track) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: OstrackColors.teal.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: OstrackColors.teal.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.movie_creation_outlined,
              color: OstrackColors.teal, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              track.sceneTag,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          TextButton.icon(
            onPressed: () async {
              final count = await ref.read(sceneTagModerationRepositoryProvider).reportTag(
                    tagId: 'player:${track.title}',
                    reason: 'user_reported_scene_tag',
                    sourceTitle: track.source,
                  );

              if (!context.mounted) {
                return;
              }

              final shouldHide = ref
                  .read(sceneTagModerationRepositoryProvider)
                  .shouldAutoHide(count);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    shouldHide
                        ? 'Tag hidden pending moderation review.'
                        : 'Report submitted. Thanks for helping moderate OSTrack.',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.flag_outlined, size: 16),
            label: const Text('Report'),
          ),
          TextButton.icon(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                useRootNavigator: true,
                builder: (context) => SceneTagSubmissionModal(track: track),
              );
            },
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Add Tag'),
          ),
        ],
      ),
    );
  }

  /// THE PERFORMANCE MAGIC: Detached audio scrubber using StreamBuilder.
  /// Updates at 60fps from the native audio engine, never rebuilds parent widgets.
  Widget _buildScrubber(WidgetRef ref) {
    final audioPlayer = ref.read(originalAudioServiceProvider).player;

    return StreamBuilder<Duration>(
      stream: audioPlayer.positionStream,
      builder: (context, posSnapshot) {
        final position = posSnapshot.data ?? Duration.zero;
        final duration = audioPlayer.duration ?? Duration.zero;
                return ProgressBar(
              progress: position,
              buffered: Duration.zero,
              total: duration,
              progressBarColor: Colors.white,
              baseBarColor: Colors.white.withValues(alpha: 0.2),
              bufferedBarColor: Colors.white.withValues(alpha: 0.3),
              thumbColor: Colors.white,
              timeLabelTextStyle: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
              onSeek: (duration) async {
                await audioPlayer.seek(duration);
              },
            );
      },
    );
  }

  /// Playback controls: play/pause button and skip buttons.
  /// Also uses StreamBuilder to stay in sync with audio engine.
  Widget _buildControls(WidgetRef ref, Color accentColor) {
    final audioPlayer = ref.read(originalAudioServiceProvider).player;

    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;

        // Show loading spinner if buffering
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous,
                  color: Colors.white, size: 36),
              onPressed: () async {
                // TODO: Implement skip previous
                // Could integrate with queue management
              },
            ),

            // Main Play/Pause Button with dynamic accent color
            GestureDetector(
              onTap: () async {
                final audioPlayer = ref.read(originalAudioServiceProvider).player;
                final playing = (await audioPlayer.playerStateStream.first).playing;
                if (playing) {
                  await audioPlayer.pause();
                } else {
                  await audioPlayer.play();
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentColor,
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withValues(alpha: 0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: StreamBuilder<PlayerState>(
                  stream: ref.read(originalAudioServiceProvider).player.playerStateStream,
                  builder: (context, snapshot) {
                    final playing = snapshot.data?.playing ?? false;
                    return Icon(
                      playing ? Icons.pause : Icons.play_arrow,
                      color: Colors.black87,
                      size: 48,
                    );
                  },
                ),
              ),
            ),

            IconButton(
              icon: const Icon(Icons.skip_next,
                  color: Colors.white, size: 36),
              onPressed: () async {
                // TODO: Implement skip next
                // Could integrate with queue management
              },
            ),
          ],
        );
      },
    );
  }
}
