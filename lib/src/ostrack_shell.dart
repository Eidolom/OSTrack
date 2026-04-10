import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import 'app_providers.dart';
import 'app_preferences.dart';
import 'backend/backend_config.dart';
import 'ostrack_catalog.dart';
import 'mascot_monetization.dart';
import 'mascot_sprite.dart';
import 'playback/original_audio_service.dart';
import 'playback/playback_handoff_service.dart';
import 'settings/settings_screen.dart';
import 'ostrack_theme.dart';
import 'ostrack_widgets.dart';

class OstrackShell extends ConsumerStatefulWidget {
  const OstrackShell({
    super.key,
    required this.catalog,
    required this.preferences,
    required this.onPreferencesChanged,
    required this.onSignOut,
  });

  final OstrackCatalog catalog;
  final AppPreferences preferences;
  final PreferencesUpdater onPreferencesChanged;
  final VoidCallback onSignOut;

  @override
  ConsumerState<OstrackShell> createState() => _OstrackShellState();
}

class _OstrackShellState extends ConsumerState<OstrackShell> {
  int _currentIndex = 0;
  bool _isPlayerExpanded = false;

  void _openMediaSource(String title) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MediaSourcePage(
          title: title,
          selectedPlatform: widget.preferences.selectedPlatform,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeTrack = ref.watch(activeTrackProvider).valueOrNull ?? widget.catalog.activeTrack;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          const OstrackBackdrop(),
          IndexedStack(
            index: _currentIndex,
            children: [
              TickerMode(enabled: _currentIndex == 0, child: HomeDashboard(catalog: widget.catalog)),
              TickerMode(
                enabled: _currentIndex == 1,
                child: ExploreDashboard(onOpenMediaSource: _openMediaSource),
              ),
              TickerMode(enabled: _currentIndex == 2, child: LibraryDashboard(catalog: widget.catalog)),
              TickerMode(
                enabled: _currentIndex == 3,
                child: ProfileDashboard(
                  catalog: widget.catalog,
                  preferences: widget.preferences,
                  onPreferencesChanged: widget.onPreferencesChanged,
                  onSignOut: widget.onSignOut,
                  mascotCatalog: const OstrackMascotCatalog(),
                ),
              ),
            ],
          ),
          if (_isPlayerExpanded)
            Positioned.fill(
              child: ColoredBox(
                color: OstrackColors.background,
                child: Stack(
                  children: [
                    PlayerDashboard(
                      catalog: widget.catalog,
                      selectedPlatform: widget.preferences.selectedPlatform,
                      initialTrack: activeTrack,
                    ),
                    Positioned(
                      top: 18,
                      right: 18,
                      child: IconButton.filledTonal(
                        onPressed: () {
                          setState(() {
                            _isPlayerExpanded = false;
                          });
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_isPlayerExpanded)
            _MiniPlayerBar(
              trackTitle: activeTrack.title,
              sourceTitle: activeTrack.source,
              onExpand: () {
                setState(() {
                  _isPlayerExpanded = true;
                });
              },
            ),
          if (!_isPlayerExpanded)
            NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.explore_outlined),
                  selectedIcon: Icon(Icons.explore),
                  label: 'Explore',
                ),
                NavigationDestination(
                  icon: Icon(Icons.library_music_outlined),
                  selectedIcon: Icon(Icons.library_music),
                  label: 'Library',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _MiniPlayerBar extends StatelessWidget {
  const _MiniPlayerBar({
    required this.trackTitle,
    required this.sourceTitle,
    required this.onExpand,
  });

  final String trackTitle;
  final String sourceTitle;
  final VoidCallback onExpand;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onExpand,
          child: Ink(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: BoxDecoration(
              color: OstrackColors.surfaceAlt,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF2B2232), Color(0xFF17161B)],
                    ),
                  ),
                  child: const Icon(Icons.album, color: OstrackColors.gold, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(trackTitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 2),
                      Text(sourceTitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onExpand,
                  icon: const Icon(Icons.graphic_eq),
                  color: OstrackColors.teal,
                  tooltip: 'Expand player',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OstrackPageFrame extends StatelessWidget {
  const OstrackPageFrame({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eyebrow.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: OstrackColors.teal,
                    letterSpacing: 1.8,
                  ),
            ),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 10),
            Text(subtitle, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),
            child,
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class HomeDashboard extends ConsumerWidget {
  const HomeDashboard({super.key, required this.catalog});

  final OstrackCatalog catalog;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feed = catalog.homeFeed;
    final recommendations = catalog.recommendations;

    return OstrackPageFrame(
      eyebrow: 'Home',
      title: 'Your soundtrack pulse',
      subtitle: 'A social feed for shelves, scene tags, and the tracks people can not stop talking about.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _OnThisDayFeatureCard(),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Today on OSTrack',
            subtitle: 'What people in your circle are rating, tagging, and shelving right now.',
          ),
          for (var i = 0; i < feed.length; i++) ...[
            _StaggeredReveal(
              index: i,
              child: _FeedCard(
                icon: feed[i].icon,
                title: feed[i].title,
                subtitle: feed[i].subtitle,
                accent: feed[i].accent,
              ),
            ),
            if (i < feed.length - 1) const SizedBox(height: 16),
          ],
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Recommended for you',
            subtitle: 'Seeded from your selected worlds during onboarding.',
          ),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: recommendations
                .map(
                  (item) => _RecommendationCard(
                    title: item.title,
                    subtitle: item.subtitle,
                    accent: item.accent,
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
          _OriginalsPlaybackCard(
            isConfigured: BackendConfig.hasOriginalsR2,
            service: ref.watch(originalAudioServiceProvider),
            playerState: ref.watch(originalPlayerStateProvider).valueOrNull,
          ),
        ],
      ),
    );
  }
}

class _StaggeredReveal extends StatefulWidget {
  const _StaggeredReveal({required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  State<_StaggeredReveal> createState() => _StaggeredRevealState();
}

class _StaggeredRevealState extends State<_StaggeredReveal> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(Duration(milliseconds: 90 * widget.index), () {
      if (!mounted) {
        return;
      }
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOut,
      offset: _visible ? Offset.zero : const Offset(0, 0.08),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        opacity: _visible ? 1 : 0,
        child: widget.child,
      ),
    );
  }
}

class _OnThisDayFeatureCard extends StatelessWidget {
  const _OnThisDayFeatureCard();

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF232125), Color(0xFF19181D), Color(0xFF141418)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ON THIS DAY',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: OstrackColors.gold),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 164,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2B2232), Color(0xFF19161F)],
              ),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2015',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: OstrackColors.gold,
                        fontSize: 40,
                      ),
                ),
                const Spacer(),
                Text(
                  'Bloodborne Original Soundtrack',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Top track this week: The First Hunter',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedCard extends StatelessWidget {
  const _FeedCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  String get _username {
    final match = RegExp(r'^(@\w+)').firstMatch(title);
    return match?.group(1) ?? '@listener';
  }

  String get _activityLabel {
    if (title.contains('reviewed')) {
      return 'RATING';
    }
    if (title.contains('tagged')) {
      return 'SCENE TAG';
    }
    return 'SHELF ACTIVITY';
  }

  String get _activityText {
    final prefix = '$_username ';
    if (title.startsWith(prefix)) {
      return title.substring(prefix.length);
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _FeedAvatar(username: _username, accent: accent),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_username, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(subtitle, style: Theme.of(context).textTheme.labelMedium),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  _activityLabel,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: accent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            _activityText,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(height: 1.2),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(icon, size: 18, color: accent),
              const SizedBox(width: 8),
              Text(
                'Open activity',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: OstrackColors.textHigh),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, color: OstrackColors.textMuted),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeedAvatar extends StatelessWidget {
  const _FeedAvatar({required this.username, required this.accent});

  final String username;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final initials = username.replaceAll('@', '').substring(0, username.length > 2 ? 2 : 1).toUpperCase();

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: accent.withValues(alpha: 0.8), width: 1.2),
        color: accent.withValues(alpha: 0.18),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: OstrackColors.textHigh,
            ),
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 158,
      child: OstrackCard(
        padding: const EdgeInsets.all(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accent.withValues(alpha: 0.22), OstrackColors.surface.withValues(alpha: 0.95)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.album_outlined, color: accent),
            ),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _OriginalsPlaybackCard extends StatelessWidget {
  const _OriginalsPlaybackCard({
    required this.isConfigured,
    required this.service,
    required this.playerState,
  });

  final bool isConfigured;
  final OriginalAudioService service;
  final PlayerState? playerState;

  static const _tracks = <_OriginalTrackPreview>[
    _OriginalTrackPreview(
      title: 'Neon Drift (OSTrack Original)',
      fileName: 'neon_drift.mp3',
      blurb: 'A low-glow synth loop designed for late-night shelf sessions.',
    ),
    _OriginalTrackPreview(
      title: 'Silent Arc (OSTrack Original)',
      fileName: 'silent_arc.mp3',
      blurb: 'Minimal piano texture for scene-tag writing and focus.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isPlaying = playerState?.playing ?? false;

    return OstrackCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'OSTrack Originals',
            subtitle: 'Stream direct from Cloudflare R2 with in-app playback.',
          ),
          if (!isConfigured)
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text('Set ORIGINALS_R2_BASE_URL via --dart-define to enable streaming.'),
            ),
          for (var i = 0; i < _tracks.length; i++) ...[
            _OriginalTrackTile(
              track: _tracks[i],
              isConfigured: isConfigured,
              isPlaying: isPlaying,
              onPlay: () async {
                final base = BackendConfig.originalsR2BaseUrl;
                final url = '$base/${_tracks[i].fileName}';
                await service.playUrl(url);
              },
              onStop: service.stop,
            ),
            if (i < _tracks.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _OriginalTrackTile extends StatelessWidget {
  const _OriginalTrackTile({
    required this.track,
    required this.isConfigured,
    required this.isPlaying,
    required this.onPlay,
    required this.onStop,
  });

  final _OriginalTrackPreview track;
  final bool isConfigured;
  final bool isPlaying;
  final Future<void> Function() onPlay;
  final Future<void> Function() onStop;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: OstrackColors.surfaceAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(track.title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(track.blurb, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 10),
          Row(
            children: [
              FilledButton.icon(
                onPressed: !isConfigured
                    ? null
                    : () async {
                        await onPlay();
                      },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Play Original'),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: !isPlaying
                    ? null
                    : () async {
                        await onStop();
                      },
                icon: const Icon(Icons.stop),
                label: const Text('Stop'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OriginalTrackPreview {
  const _OriginalTrackPreview({
    required this.title,
    required this.fileName,
    required this.blurb,
  });

  final String title;
  final String fileName;
  final String blurb;
}

class ExploreDashboard extends ConsumerWidget {
  const ExploreDashboard({
    super.key,
    required this.onOpenMediaSource,
  });

  final ValueChanged<String> onOpenMediaSource;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final trendsAsync = ref.watch(trendsProvider);
    final query = ref.watch(exploreSearchQueryProvider);
    final searchResultsAsync = ref.watch(exploreSearchResultsProvider);

    return OstrackPageFrame(
      eyebrow: 'Explore',
      title: 'Browse worlds, not just songs',
      subtitle: 'Search now routes through Typesense aliases with curated visual discovery below.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (value) => ref.read(exploreSearchQueryProvider.notifier).state = value,
            decoration: InputDecoration(
              hintText: 'Search tracks, aliases, sources, composers',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: query.trim().isEmpty
                  ? null
                  : IconButton(
                      tooltip: 'Clear search',
                      onPressed: () => ref.read(exploreSearchQueryProvider.notifier).state = '',
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          if (query.trim().isNotEmpty) ...[
            const SizedBox(height: 16),
            const SectionHeader(
              title: 'Search results',
              subtitle: 'Alias-aware matches from the backend search index.',
            ),
            searchResultsAsync.when(
              data: (results) {
                if (results.isEmpty) {
                  return const OstrackCard(
                    child: Text('No matches found. Try a different title, alias, or source.'),
                  );
                }
                return Column(
                  children: [
                    for (var i = 0; i < results.length; i++) ...[
                      ListTile(
                        tileColor: OstrackColors.surfaceAlt,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        title: Text(results[i].title),
                        subtitle: Text('${results[i].source} · Alias: ${results[i].alias}'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => onOpenMediaSource(results[i].source),
                      ),
                      if (i < results.length - 1) const SizedBox(height: 8),
                    ],
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => const OstrackCard(
                child: Text('Search is temporarily unavailable. Falling back to local matches.'),
              ),
            ),
            const SizedBox(height: 24),
          ],
          LayoutBuilder(
            builder: (context, constraints) {
              final tileWidth = (constraints.maxWidth - 12) / 2;

              return categoriesAsync.when(
                data: (categories) => Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: categories
                      .map(
                        (item) => _CategoryTile(
                          label: item.label,
                          accent: item.accent,
                          width: tileWidth,
                          onTap: () => onOpenMediaSource(_featuredTitleForCategory(item.label)),
                        ),
                      )
                      .toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => const OstrackCard(
                  child: Text('Categories are loading from backup data right now.'),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Trending this week',
            subtitle: 'High activity, high intent, and the soundtrack pages people are opening most.',
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: trendsAsync.when(
              data: (trends) => Row(
                children: [
                  for (final item in trends) ...[
                    _TrendingOstTile(
                      label: item.label,
                      meta: item.meta,
                      accent: item.accent,
                      onTap: () => onOpenMediaSource(item.label),
                    ),
                    if (item != trends.last) const SizedBox(width: 12),
                  ],
                ],
              ),
              loading: () => const SizedBox(height: 90, child: Center(child: CircularProgressIndicator())),
              error: (error, stackTrace) => const OstrackCard(
                child: Text('Trending data is unavailable right now.'),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Hidden gems',
            subtitle: 'Editorial picks with unusual moods and high replay value.',
          ),
          const _HiddenGemRow(),
        ],
      ),
    );
  }

  String _featuredTitleForCategory(String category) {
    return switch (category) {
      'Video Games' => 'Elden Ring',
      'Anime' => 'Cowboy Bebop',
      'Movies & TV' => 'Dune',
      'K-Drama' => 'Goblin',
      'Composers' => 'Yoko Shimomura Collection',
      'Originals' => 'OSTrack Sessions Vol. 1',
      _ => 'Elden Ring',
    };
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.label,
    required this.accent,
    required this.width,
    required this.onTap,
  });

  final String label;
  final Color accent;
  final double width;
  final VoidCallback onTap;

  String get _trackCountLabel {
    return switch (label) {
      'Video Games' => '18.4k tracks',
      'Anime' => '9.3k tracks',
      'Movies & TV' => '6.7k tracks',
      'K-Drama' => '3.2k tracks',
      'Composers' => '4.1k profiles',
      'Originals' => '120 drops',
      _ => 'Catalog',
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: OstrackCard(
          padding: EdgeInsets.zero,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [accent.withValues(alpha: 0.36), OstrackColors.surfaceAlt],
          ),
          child: Container(
            height: 176,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  OstrackColors.background.withValues(alpha: 0.55),
                  OstrackColors.background.withValues(alpha: 0.86),
                ],
              ),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: accent.withValues(alpha: 0.35),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 4, bottom: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: accent.withValues(alpha: 0.22),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 4, top: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: accent.withValues(alpha: 0.14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _trackCountLabel,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TrendingOstTile extends StatelessWidget {
  const _TrendingOstTile({required this.label, required this.meta, required this.accent, required this.onTap});

  final String label;
  final String meta;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 164,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: OstrackCard(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 122,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [accent.withValues(alpha: 0.46), accent.withValues(alpha: 0.16)],
                  ),
                ),
                child: Center(
                  child: Icon(Icons.album, size: 40, color: accent.withValues(alpha: 0.9)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(meta, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HiddenGemRow extends StatelessWidget {
  const _HiddenGemRow();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          _HiddenGemCard(
            title: '13 Sentinels: Aegis Rim',
            blurb: 'The score nobody talks about but every late-night shelf should have.',
            accent: OstrackColors.gold,
          ),
          SizedBox(width: 12),
          _HiddenGemCard(
            title: 'Houseki no Kuni',
            blurb: 'Fragile, crystalline motifs that quietly dominate emotional scenes.',
            accent: OstrackColors.teal,
          ),
        ],
      ),
    );
  }
}

class _HiddenGemCard extends StatelessWidget {
  const _HiddenGemCard({
    required this.title,
    required this.blurb,
    required this.accent,
  });

  final String title;
  final String blurb;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 252,
      child: OstrackCard(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accent.withValues(alpha: 0.2), OstrackColors.surface],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24)),
            const SizedBox(height: 10),
            Text(blurb, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.35)),
          ],
        ),
      ),
    );
  }
}

class MediaSourcePage extends ConsumerStatefulWidget {
  const MediaSourcePage({
    super.key,
    required this.title,
    required this.selectedPlatform,
  });

  final String title;
  final String selectedPlatform;

  @override
  ConsumerState<MediaSourcePage> createState() => _MediaSourcePageState();
}

class _MediaSourcePageState extends ConsumerState<MediaSourcePage> {
  static const _tracks = <_MediaTrackEntry>[
    _MediaTrackEntry(number: 1, title: 'The Lands Between', duration: '3:54', sceneHint: 'Main menu overture', verified: true),
    _MediaTrackEntry(number: 2, title: 'Limgrave', duration: '4:12', sceneHint: 'First open-world ascent', verified: true),
    _MediaTrackEntry(number: 3, title: 'Roundtable Hold', duration: '2:48', sceneHint: 'Hub sanctuary theme', verified: false),
    _MediaTrackEntry(number: 4, title: 'Malenia, Blade of Miquella', duration: '5:07', sceneHint: 'Late-game boss resolve', verified: true),
  ];

  static const _forumPosts = <_ForumEntry>[
    _ForumEntry(author: '@ostnerdd', meta: '2h ago', body: 'Roundtable Hold is underrated as a transition cue. It carries so much dread under the calm layer.'),
    _ForumEntry(author: '@yukirose', meta: 'Yesterday', body: 'Malenia phase 2 choir hit still gives me chills. Easy top-5 FromSoftware track.'),
  ];

  final Set<int> _expandedTrackNumbers = <int>{};

  Future<void> _launchTrack(String title) async {
    final request = TrackHandoffIndex.forTitle(title);
    final launched = await ref.read(playbackHandoffServiceProvider).launch(
          selectedPlatform: widget.selectedPlatform,
          request: request,
        );

    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open ${widget.selectedPlatform} for "$title".')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const OstrackBackdrop(),
          SafeArea(
            bottom: false,
            child: DefaultTabController(
              length: 3,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back),
                      tooltip: 'Back',
                    ),
                    const SizedBox(height: 8),
                    _MediaHero(title: widget.title),
                    const SizedBox(height: 16),
                    const _RatingDistribution(),
                    const SizedBox(height: 16),
                    TabBar(
                      indicatorColor: OstrackColors.teal,
                      labelColor: OstrackColors.textHigh,
                      unselectedLabelColor: OstrackColors.textMuted,
                      tabs: const [
                        Tab(text: 'Tracklist'),
                        Tab(text: 'Scene Tags'),
                        Tab(text: 'Forum'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 520,
                      child: TabBarView(
                        children: [
                          _buildTracklist(),
                          _buildSceneTimeline(),
                          _buildForum(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTracklist() {
    return ListView.separated(
      itemCount: _tracks.length,
      separatorBuilder: (_, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final track = _tracks[index];
        final isExpanded = _expandedTrackNumbers.contains(track.number);

        return OstrackCard(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    if (isExpanded) {
                      _expandedTrackNumbers.remove(track.number);
                    } else {
                      _expandedTrackNumbers.add(track.number);
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 36,
                        child: Text(track.number.toString().padLeft(2, '0'), style: Theme.of(context).textTheme.labelMedium),
                      ),
                      Expanded(
                        child: Text(track.title, style: Theme.of(context).textTheme.titleMedium),
                      ),
                      Text(track.duration, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(width: 8),
                      Icon(isExpanded ? Icons.expand_less : Icons.expand_more, color: OstrackColors.textMuted),
                    ],
                  ),
                ),
              ),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 220),
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        track.sceneHint,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(track.verified ? Icons.verified : Icons.autorenew, color: track.verified ? OstrackColors.teal : OstrackColors.coral, size: 18),
                          const SizedBox(width: 6),
                          Text(track.verified ? 'Verified timestamp' : 'Needs timestamp bounty', style: Theme.of(context).textTheme.labelMedium),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () {
                              _launchTrack(track.title);
                            },
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Play'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSceneTimeline() {
    return ListView(
      children: const [
        _SceneTimelineCard(
          title: 'Malenia reveal',
          description: '"The choir bloom hits exactly as the cutscene breaks into phase two."',
          status: 'Verified',
          statusColor: OstrackColors.teal,
        ),
        SizedBox(height: 10),
        _SceneTimelineCard(
          title: 'Roundtable Hold return',
          description: '"Quiet motif after your first major shardbearer. Still waiting for precise timestamp."',
          status: 'Bounty open',
          statusColor: OstrackColors.coral,
        ),
      ],
    );
  }

  Widget _buildForum() {
    return ListView.separated(
      itemCount: _forumPosts.length,
      separatorBuilder: (_, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final post = _forumPosts[index];
        return OstrackCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${post.author} · ${post.meta}', style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 8),
              Text(post.body, style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.35)),
            ],
          ),
        );
      },
    );
  }
}

class _MediaHero extends StatelessWidget {
  const _MediaHero({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2E2A35), Color(0xFF141418)],
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          OstrackColors.background.withValues(alpha: 0.68),
                          OstrackColors.background,
                        ],
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Icon(Icons.album, size: 98, color: OstrackColors.gold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('GAME · 2022 · 285 TRACKS', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 10),
                Text(title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 34)),
                const SizedBox(height: 4),
                Text('Original Soundtrack', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                Text('Yuka Kitamura · Tsukasa Saito', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: OstrackColors.teal)),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Text('★ 4.9', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: OstrackColors.gold)),
                    const SizedBox(width: 10),
                    Text('9.2k ratings', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.star_outline),
                        label: const Text('Rate this OST'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text('Add to Shelf'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingDistribution extends StatelessWidget {
  const _RatingDistribution();

  static const _bands = <_RatingBandEntry>[
    _RatingBandEntry(label: '5★', value: 0.62),
    _RatingBandEntry(label: '4★', value: 0.24),
    _RatingBandEntry(label: '3★', value: 0.09),
    _RatingBandEntry(label: '2★', value: 0.04),
    _RatingBandEntry(label: '1★', value: 0.01),
  ];

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Community distribution', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          for (final band in _bands) ...[
            Row(
              children: [
                SizedBox(width: 28, child: Text(band.label, style: Theme.of(context).textTheme.labelMedium)),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: band.value,
                      minHeight: 8,
                      color: OstrackColors.gold,
                      backgroundColor: OstrackColors.surfaceAlt,
                    ),
                  ),
                ),
              ],
            ),
            if (band != _bands.last) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _SceneTimelineCard extends StatelessWidget {
  const _SceneTimelineCard({
    required this.title,
    required this.description,
    required this.status,
    required this.statusColor,
  });

  final String title;
  final String description;
  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium)),
              Text(status, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: statusColor)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontStyle: FontStyle.italic, height: 1.35),
          ),
        ],
      ),
    );
  }
}

class _MediaTrackEntry {
  const _MediaTrackEntry({
    required this.number,
    required this.title,
    required this.duration,
    required this.sceneHint,
    required this.verified,
  });

  final int number;
  final String title;
  final String duration;
  final String sceneHint;
  final bool verified;
}

class _ForumEntry {
  const _ForumEntry({required this.author, required this.meta, required this.body});

  final String author;
  final String meta;
  final String body;
}

class _RatingBandEntry {
  const _RatingBandEntry({required this.label, required this.value});

  final String label;
  final double value;
}

class LibraryDashboard extends StatelessWidget {
  const LibraryDashboard({super.key, required this.catalog});

  final OstrackCatalog catalog;

  @override
  Widget build(BuildContext context) {
    final tabHeight = MediaQuery.of(context).size.height * 0.64;
    final shelves = catalog.shelves;
    final ratings = catalog.ratings;
    final history = catalog.history;

    return OstrackPageFrame(
      eyebrow: 'Library',
      title: 'Your collector space',
      subtitle: 'Shelves, ratings, and history live here as the control center for your taste identity.',
      child: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              indicatorColor: OstrackColors.teal,
              labelColor: OstrackColors.textHigh,
              unselectedLabelColor: OstrackColors.textMuted,
              tabs: const [
                Tab(text: 'Shelves'),
                Tab(text: 'Ratings'),
                Tab(text: 'History'),
              ],
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: tabHeight,
              child: TabBarView(
                children: [
                  _ShelvesTab(shelves: shelves),
                  _RatingsTab(ratings: ratings),
                  _HistoryTab(history: history),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShelvesTab extends StatelessWidget {
  const _ShelvesTab({required this.shelves});

  final List<LibraryEntry> shelves;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shelves', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final tileWidth = (constraints.maxWidth - 12) / 2;

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: tileWidth,
                    child: const _CreateShelfTile(),
                  ),
                  ...shelves.map(
                    (item) => SizedBox(
                      width: tileWidth,
                      child: _ShelfGridTile(
                        title: item.title,
                        meta: item.meta,
                        accent: item.accent,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CreateShelfTile extends StatelessWidget {
  const _CreateShelfTile();

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      child: SizedBox(
        height: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: OstrackColors.teal.withValues(alpha: 0.14),
                border: Border.all(color: OstrackColors.teal.withValues(alpha: 0.45)),
              ),
              child: const Icon(Icons.add, color: OstrackColors.teal),
            ),
            const SizedBox(height: 16),
            Text('Start a shelf', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              'Name your next collection',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _ShelfGridTile extends StatelessWidget {
  const _ShelfGridTile({
    required this.title,
    required this.meta,
    required this.accent,
  });

  final String title;
  final String meta;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: _MosaicCell(color: accent.withValues(alpha: 0.34))),
                      const SizedBox(height: 4),
                      Expanded(child: _MosaicCell(color: accent.withValues(alpha: 0.2))),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: _MosaicCell(color: accent.withValues(alpha: 0.15))),
                      const SizedBox(height: 4),
                      Expanded(child: _MosaicCell(color: accent.withValues(alpha: 0.28))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(meta, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _MosaicCell extends StatelessWidget {
  const _MosaicCell({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class _RatingsTab extends StatelessWidget {
  const _RatingsTab({required this.ratings});

  final List<LibraryEntry> ratings;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ratings', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          const _RatingsSummaryCard(),
          const SizedBox(height: 12),
          for (final item in ratings) ...[
            _RatingRow(title: item.title, meta: item.meta, accent: item.accent),
            if (item != ratings.last) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _RatingsSummaryCard extends StatelessWidget {
  const _RatingsSummaryCard();

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('You\'ve rated 1,284 tracks', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text('Average score: 3.8★', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          Text('3.8★', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: OstrackColors.gold)),
        ],
      ),
    );
  }
}

class _RatingRow extends StatelessWidget {
  const _RatingRow({
    required this.title,
    required this.meta,
    required this.accent,
  });

  final String title;
  final String meta;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.album_outlined, color: accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(meta, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          Text('★★★★☆', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: OstrackColors.gold)),
        ],
      ),
    );
  }
}

class _HistoryTab extends StatelessWidget {
  const _HistoryTab({required this.history});

  final List<LibraryEntry> history;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('History', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text('Listening diary', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          for (var i = 0; i < history.length; i++) ...[
            _HistoryTimelineRow(
              title: history[i].title,
              meta: history[i].meta,
              accent: history[i].accent,
              isLast: i == history.length - 1,
            ),
            if (i < history.length - 1) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _HistoryTimelineRow extends StatelessWidget {
  const _HistoryTimelineRow({
    required this.title,
    required this.meta,
    required this.accent,
    required this.isLast,
  });

  final String title;
  final String meta;
  final Color accent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          child: Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 64,
                  color: Colors.white.withValues(alpha: 0.12),
                ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OstrackCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(meta, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PlayerDashboard extends ConsumerStatefulWidget {
  const PlayerDashboard({
    super.key,
    required this.catalog,
    required this.selectedPlatform,
    required this.initialTrack,
  });

  final OstrackCatalog catalog;
  final String selectedPlatform;
  final ActiveTrackEntry initialTrack;

  @override
  ConsumerState<PlayerDashboard> createState() => _PlayerDashboardState();
}

class _PlayerDashboardState extends ConsumerState<PlayerDashboard> {
  late ActiveTrackEntry _activeTrack;
  late Color _ambientAccent;
  double _rating = 4;

  @override
  void initState() {
    super.initState();
    _activeTrack = widget.initialTrack;
    _ambientAccent = OstrackColors.teal;
  }

  void _switchTrack(RelatedTrackEntry related) {
    setState(() {
      _ambientAccent = related.accent;
      _activeTrack = ActiveTrackEntry(
        title: related.title,
        composer: 'Christopher Larkin',
        source: related.subtitle,
        description: 'Community notes describe this as a key emotional anchor in the route sequence.',
        sceneTag: 'Verified scene tag',
      );
    });
  }

  Future<void> _launchCurrentTrack() async {
    final request = TrackHandoffIndex.forTitle(_activeTrack.title);
    final launched = await ref.read(playbackHandoffServiceProvider).launch(
          selectedPlatform: widget.selectedPlatform,
          request: request,
        );

    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open ${widget.selectedPlatform} for "${_activeTrack.title}".')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final relatedTracks = widget.catalog.relatedTracks;

    return OstrackPageFrame(
      eyebrow: 'Player',
      title: 'Inside the track',
      subtitle: 'Artwork first, then context. This is where listening becomes memory.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _ambientAccent.withValues(alpha: 0.2),
                  OstrackColors.surface,
                  OstrackColors.surface,
                ],
              ),
            ),
            child: OstrackCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [_ambientAccent.withValues(alpha: 0.35), const Color(0xFF17161B)],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: OstrackPill(
                                label: 'From: ${_activeTrack.source}',
                                icon: Icons.movie_creation_outlined,
                                color: OstrackColors.gold,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: OstrackPill(
                                label: _activeTrack.sceneTag,
                                icon: Icons.verified_outlined,
                                color: OstrackColors.teal,
                              ),
                            ),
                          ),
                          Center(
                            child: Icon(
                              Icons.album,
                              color: OstrackColors.gold.withValues(alpha: 0.8),
                              size: 96,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(_activeTrack.title, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 6),
                  Text(_activeTrack.composer, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    decoration: BoxDecoration(
                      color: OstrackColors.surfaceAlt,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                    ),
                    child: Text(
                      '"${_activeTrack.description}"',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: OstrackColors.textHigh,
                            height: 1.4,
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _launchCurrentTrack,
                      icon: const Icon(Icons.play_arrow),
                      label: Text('Open in ${widget.selectedPlatform}'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('Add to Shelf'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _InteractiveStarRating(
                    rating: _rating,
                    onChanged: (value) {
                      setState(() {
                        _rating = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Platform selector',
            subtitle: 'Route the track to the user\'s connected service when playback is external.',
          ),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              OstrackPill(
                label: 'Spotify',
                icon: Icons.circle,
                color: OstrackColors.teal,
                isActive: widget.selectedPlatform == 'Spotify',
              ),
              OstrackPill(
                label: 'Apple Music',
                icon: Icons.music_note,
                color: OstrackColors.gold,
                isActive: widget.selectedPlatform == 'Apple Music',
              ),
              OstrackPill(
                label: 'YouTube Music',
                icon: Icons.play_circle_outline,
                color: OstrackColors.coral,
                isActive: widget.selectedPlatform == 'YouTube Music',
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Related tracks',
            subtitle: 'Same composer, same mood, same world.',
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final item in relatedTracks) ...[
                  _RelatedTrackCard(
                    title: item.title,
                    subtitle: item.subtitle,
                    accent: item.accent,
                    isActive: _activeTrack.title == item.title,
                    onTap: () => _switchTrack(item),
                  ),
                  if (item != relatedTracks.last) const SizedBox(width: 12),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RelatedTrackCard extends StatelessWidget {
  const _RelatedTrackCard({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.isActive,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Color accent;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: OstrackCard(
          padding: const EdgeInsets.all(14),
          gradient: isActive
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [accent.withValues(alpha: 0.22), OstrackColors.surface],
                )
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.graphic_eq, color: accent),
              ),
              const SizedBox(height: 14),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class _InteractiveStarRating extends StatefulWidget {
  const _InteractiveStarRating({required this.rating, required this.onChanged});

  final double rating;
  final ValueChanged<double> onChanged;

  @override
  State<_InteractiveStarRating> createState() => _InteractiveStarRatingState();
}

class _InteractiveStarRatingState extends State<_InteractiveStarRating> {
  late double _displayRating;
  bool _burstVisible = false;

  @override
  void initState() {
    super.initState();
    _displayRating = widget.rating;
  }

  Future<void> _animateTo(double target) async {
    final start = _displayRating;
    if (start == target) {
      return;
    }
    final step = target > start ? 0.5 : -0.5;
    var current = start;

    while ((step > 0 && current < target) || (step < 0 && current > target)) {
      current = (current + step).clamp(0, 5);
      setState(() {
        _displayRating = current;
      });
      HapticFeedback.mediumImpact();
      await Future<void>.delayed(const Duration(milliseconds: 30));
    }

    setState(() {
      _burstVisible = true;
    });
    await Future<void>.delayed(const Duration(milliseconds: 260));
    if (!mounted) {
      return;
    }
    setState(() {
      _burstVisible = false;
    });
    widget.onChanged(target);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        color: OstrackColors.surfaceAlt,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_burstVisible)
            AnimatedScale(
              scale: _burstVisible ? 1 : 0.6,
              duration: const Duration(milliseconds: 180),
              child: Icon(Icons.auto_awesome, size: 42, color: OstrackColors.gold.withValues(alpha: 0.28)),
            ),
          Row(
            children: [
              for (var i = 0; i < 5; i++) ...[
                _HalfStarTapZone(
                  index: i,
                  currentRating: _displayRating,
                  onSelect: (value) => _animateTo(value),
                ),
                if (i < 4) const SizedBox(width: 4),
              ],
              const Spacer(),
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 220),
                tween: Tween<double>(begin: 0, end: _displayRating),
                builder: (context, value, child) {
                  return Text(value.toStringAsFixed(1), style: Theme.of(context).textTheme.titleMedium?.copyWith(color: OstrackColors.gold));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HalfStarTapZone extends StatelessWidget {
  const _HalfStarTapZone({
    required this.index,
    required this.currentRating,
    required this.onSelect,
  });

  final int index;
  final double currentRating;
  final ValueChanged<double> onSelect;

  @override
  Widget build(BuildContext context) {
    final whole = index + 1;
    final leftValue = index + 0.5;
    final isFull = currentRating >= whole;
    final isHalf = !isFull && currentRating >= leftValue;

    return SizedBox(
      width: 30,
      height: 28,
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.center,
            child: Icon(Icons.star_border, size: 24, color: OstrackColors.gold),
          ),
          if (isFull)
            const Align(
              alignment: Alignment.center,
              child: Icon(Icons.star, size: 24, color: OstrackColors.gold),
            ),
          if (isHalf)
            const Align(
              alignment: Alignment.centerLeft,
              child: ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.5,
                  child: Icon(Icons.star, size: 24, color: OstrackColors.gold),
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onSelect(leftValue),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onSelect(whole.toDouble()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileDashboard extends StatelessWidget {
  const ProfileDashboard({
    super.key,
    required this.catalog,
    required this.preferences,
    required this.onPreferencesChanged,
    required this.onSignOut,
    required this.mascotCatalog,
  });

  final OstrackCatalog catalog;
  final AppPreferences preferences;
  final PreferencesUpdater onPreferencesChanged;
  final VoidCallback onSignOut;
  final OstrackMascotCatalog mascotCatalog;

  @override
  Widget build(BuildContext context) {
    final profile = catalog.profile;
    final mascotView = mascotCatalog.viewFor(preferences);
    final equippedMascot = mascotView.equippedEntry?.mascot;

    return OstrackPageFrame(
      eyebrow: 'Profile',
      title: 'Taste as identity',
      subtitle: 'A public-facing collector profile with shelves, stats, and recent activity.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SettingsScreen(
                      preferences: preferences,
                      onPreferencesChanged: onPreferencesChanged,
                      mascotCatalog: mascotCatalog,
                      onSignOut: onSignOut,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.settings_outlined),
              label: const Text('Open Settings'),
            ),
          ),
          const SizedBox(height: 16),
          _CollectorHeroCard(profile: profile, equippedMascot: equippedMascot),
          const SizedBox(height: 16),
          _CollectorStatsSheet(profile: profile),
          const SizedBox(height: 16),
          MascotCabinetSection(
            catalog: mascotCatalog.viewFor(preferences),
            onEquipMascot: (mascotId) async {
              await onPreferencesChanged(
                preferences.copyWith(equippedMascotId: mascotId),
              );
            },
            onOpenStore: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MascotStorePage(
                    catalog: mascotCatalog.viewFor(preferences),
                    preferences: preferences,
                    onPreferencesChanged: onPreferencesChanged,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Public shelves',
            subtitle: 'Your curated shelves are the social currency of the platform.',
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const [
                _ShelfShowcaseTile(
                  title: 'Tracks that make me feel like I can survive anything',
                  meta: '12 followers',
                  accent: OstrackColors.teal,
                ),
                SizedBox(width: 12),
                _ShelfShowcaseTile(
                  title: 'Rainy day scores',
                  meta: '48 followers',
                  accent: OstrackColors.gold,
                ),
                SizedBox(width: 12),
                _ShelfShowcaseTile(
                  title: 'Boss fight catharsis',
                  meta: '81 followers',
                  accent: OstrackColors.coral,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Recent activity',
            subtitle: 'A light-weight log of what you have been adding and rating.',
          ),
          _FeedCard(
            icon: Icons.star_outline,
            title: 'Rated The Last of Us Main Theme five stars',
            subtitle: '1 hour ago',
            accent: OstrackColors.gold,
          ),
          const SizedBox(height: 12),
          _FeedCard(
            icon: Icons.collections_bookmark_outlined,
            title: 'Created a shelf called Crying in the car playlist',
            subtitle: 'Today',
            accent: OstrackColors.teal,
          ),
        ],
      ),
    );
  }
}

class _CollectorHeroCard extends StatelessWidget {
  const _CollectorHeroCard({required this.profile, required this.equippedMascot});

  final ProfileEntry profile;
  final MascotEntry? equippedMascot;

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: OstrackColors.gold, width: 2),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      OstrackColors.gold.withValues(alpha: 0.28),
                      OstrackColors.teal.withValues(alpha: 0.24),
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: MascotSpriteView(
                  mascotId: equippedMascot?.id ?? 'founding-archivist',
                  color: equippedMascot?.assetColor ?? OstrackColors.gold,
                  size: 48,
                  frameCount: equippedMascot?.frameCount ?? 3,
                  frameDurationMs: equippedMascot?.frameDurationMs ?? 240,
                  isEquipped: true,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profile.username, style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _ProfileBadge(label: 'Lorekeeper', color: OstrackColors.gold),
                        _ProfileBadge(label: 'Founding Archivist', color: OstrackColors.teal),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '"${profile.bio}"',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 14),
          Text(
            '${profile.ratings} ratings · 14 shelves · 389 followers',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}

class _ProfileBadge extends StatelessWidget {
  const _ProfileBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: color.withValues(alpha: 0.16),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
      ),
    );
  }
}

class _CollectorStatsSheet extends StatelessWidget {
  const _CollectorStatsSheet({required this.profile});

  final ProfileEntry profile;

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('COLLECTOR STATS', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 12),
          _CollectorStatRow(label: 'Total tracks rated', value: profile.ratings.toString()),
          const SizedBox(height: 8),
          const _CollectorStatRow(label: 'Scene tags submitted', value: '47'),
          const SizedBox(height: 8),
          const _CollectorStatRow(label: 'Bounties resolved', value: '12'),
          const SizedBox(height: 8),
          const _CollectorStatRow(label: 'Streak', value: '14 weeks'),
          const SizedBox(height: 8),
          _CollectorStatRow(label: 'Top composer', value: profile.topComposer),
          const SizedBox(height: 14),
          Text(
            'ARCHIVIST TIER II',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: OstrackColors.gold),
          ),
        ],
      ),
    );
  }
}

class _CollectorStatRow extends StatelessWidget {
  const _CollectorStatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

class _ShelfShowcaseTile extends StatelessWidget {
  const _ShelfShowcaseTile({required this.title, required this.meta, required this.accent});

  final String title;
  final String meta;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: OstrackCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3 / 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [accent.withValues(alpha: 0.42), accent.withValues(alpha: 0.14)],
                  ),
                ),
                child: Center(
                  child: Icon(Icons.library_music, color: accent.withValues(alpha: 0.95), size: 38),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(meta, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
