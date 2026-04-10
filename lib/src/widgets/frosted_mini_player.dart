import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_providers.dart';
import '../ostrack_theme.dart';
import '../playback/palette_service.dart';

class FrostedMiniPlayer extends ConsumerWidget {
  const FrostedMiniPlayer({
    super.key,
    required this.trackTitle,
    required this.sourceTitle,
    required this.onExpand,
  });

  final String trackTitle;
  final String sourceTitle;
  final VoidCallback onExpand;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accentColor = ref.watch(trackPaletteProvider).maybeWhen(
          data: (palette) => palette.vibrant,
          orElse: () => OstrackColors.gold,
        );
    final player = ref.watch(originalAudioServiceProvider).player;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onExpand,
          child: Ink(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border(
                top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
                bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StreamBuilder<Duration>(
                  stream: player.positionStream,
                  builder: (context, snapshot) {
                    final progress = snapshot.data ?? Duration.zero;
                    final total = player.duration ?? Duration.zero;
                    final progressRatio = total.inMilliseconds == 0
                        ? 0.0
                        : (progress.inMilliseconds / total.inMilliseconds)
                            .clamp(0.0, 1.0);

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          children: [
                            Container(
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              height: 3,
                              width: constraints.maxWidth * progressRatio,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                gradient: LinearGradient(
                                  colors: [
                                    accentColor.withValues(alpha: 0.9),
                                    accentColor,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: accentColor.withValues(alpha: 0.45),
                                    blurRadius: 6,
                                    spreadRadius: 0.5,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF2B2232), Color(0xFF17161B)],
                        ),
                      ),
                      child: const Icon(Icons.album, color: OstrackColors.gold, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trackTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            sourceTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.55),
                                ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onExpand,
                      icon: const Icon(Icons.pause_rounded),
                      color: Colors.white,
                      tooltip: 'Open player',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
