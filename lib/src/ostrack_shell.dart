import 'package:flutter/material.dart';

import 'app_preferences.dart';
import 'ostrack_catalog.dart';
import 'settings/settings_screen.dart';
import 'ostrack_theme.dart';
import 'ostrack_widgets.dart';

class OstrackShell extends StatefulWidget {
  const OstrackShell({
    super.key,
    required this.catalog,
    required this.preferences,
    required this.onPreferencesChanged,
  });

  final OstrackCatalog catalog;
  final AppPreferences preferences;
  final PreferencesUpdater onPreferencesChanged;

  @override
  State<OstrackShell> createState() => _OstrackShellState();
}

class _OstrackShellState extends State<OstrackShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          const OstrackBackdrop(),
          IndexedStack(
            index: _currentIndex,
            children: [
              HomeDashboard(catalog: widget.catalog),
              ExploreDashboard(catalog: widget.catalog),
              LibraryDashboard(catalog: widget.catalog),
              PlayerDashboard(
                catalog: widget.catalog,
                selectedPlatform: widget.preferences.selectedPlatform,
              ),
              ProfileDashboard(
                catalog: widget.catalog,
                preferences: widget.preferences,
                onPreferencesChanged: widget.onPreferencesChanged,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
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
            icon: Icon(Icons.graphic_eq_outlined),
            selectedIcon: Icon(Icons.graphic_eq),
            label: 'Player',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
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

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key, required this.catalog});

  final OstrackCatalog catalog;

  @override
  Widget build(BuildContext context) {
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
          colors: [accent.withOpacity(0.22), OstrackColors.surface.withOpacity(0.95)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.18),
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

class ExploreDashboard extends StatelessWidget {
  const ExploreDashboard({super.key, required this.catalog});

  final OstrackCatalog catalog;

  @override
  Widget build(BuildContext context) {
    final categories = catalog.categories;
    final trends = catalog.trends;

    return OstrackPageFrame(
      eyebrow: 'Explore',
      title: 'Browse worlds, not just songs',
      subtitle: 'No global search bar on the landing screen. Entry is visual and intentional.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final tileWidth = (constraints.maxWidth - 12) / 2;

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: categories
                    .map(
                      (item) => _CategoryTile(
                        label: item.label,
                        accent: item.accent,
                        width: tileWidth,
                      ),
                    )
                    .toList(),
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
            child: Row(
              children: [
                for (final item in trends) ...[
                  _TrendingOstTile(label: item.label, meta: item.meta, accent: item.accent),
                  if (item != trends.last) const SizedBox(width: 12),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.label,
    required this.accent,
    required this.width,
  });

  final String label;
  final Color accent;
  final double width;

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
    );
  }
}

class _TrendingOstTile extends StatelessWidget {
  const _TrendingOstTile({required this.label, required this.meta, required this.accent});

  final String label;
  final String meta;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 164,
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
    );
  }
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

class PlayerDashboard extends StatelessWidget {
  const PlayerDashboard({
    super.key,
    required this.catalog,
    required this.selectedPlatform,
  });

  final OstrackCatalog catalog;
  final String selectedPlatform;

  @override
  Widget build(BuildContext context) {
    final activeTrack = catalog.activeTrack;
    final relatedTracks = catalog.relatedTracks;

    return OstrackPageFrame(
      eyebrow: 'Player',
      title: 'Inside the track',
      subtitle: 'Artwork first, then context. This is where listening becomes memory.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OstrackCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF2B2232), Color(0xFF17161B)],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: OstrackPill(
                              label: 'From: ${activeTrack.source}',
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
                              label: activeTrack.sceneTag,
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
                Text(activeTrack.title, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 6),
                Text(activeTrack.composer, style: Theme.of(context).textTheme.titleMedium),
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
                    '"${activeTrack.description}"',
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
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Open in Spotify'),
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
              ],
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
                isActive: selectedPlatform == 'Spotify',
              ),
              OstrackPill(
                label: 'Apple Music',
                icon: Icons.music_note,
                color: OstrackColors.gold,
                isActive: selectedPlatform == 'Apple Music',
              ),
              OstrackPill(
                label: 'YouTube Music',
                icon: Icons.play_circle_outline,
                color: OstrackColors.coral,
                isActive: selectedPlatform == 'YouTube Music',
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
                  _RelatedTrackCard(title: item.title, subtitle: item.subtitle, accent: item.accent),
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
  const _RelatedTrackCard({required this.title, required this.subtitle, required this.accent});

  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: OstrackCard(
        padding: const EdgeInsets.all(14),
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
    );
  }
}

class ProfileDashboard extends StatelessWidget {
  const ProfileDashboard({
    super.key,
    required this.catalog,
    required this.preferences,
    required this.onPreferencesChanged,
  });

  final OstrackCatalog catalog;
  final AppPreferences preferences;
  final PreferencesUpdater onPreferencesChanged;

  @override
  Widget build(BuildContext context) {
    final profile = catalog.profile;

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
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.settings_outlined),
              label: const Text('Open Settings'),
            ),
          ),
          const SizedBox(height: 16),
          _CollectorHeroCard(profile: profile),
          const SizedBox(height: 16),
          _CollectorStatsSheet(profile: profile),
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
  const _CollectorHeroCard({required this.profile});

  final ProfileEntry profile;

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
                child: Text(
                  profile.username.substring(0, 1).toUpperCase(),
                  style: Theme.of(context).textTheme.headlineSmall,
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
