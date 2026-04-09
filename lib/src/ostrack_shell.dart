import 'package:flutter/material.dart';

import 'ostrack_catalog.dart';
import 'ostrack_theme.dart';

class OstrackShell extends StatefulWidget {
  const OstrackShell({super.key, required this.catalog});

  final OstrackCatalog catalog;

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
              PlayerDashboard(catalog: widget.catalog),
              ProfileDashboard(catalog: widget.catalog),
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

class OstrackBackdrop extends StatelessWidget {
  const OstrackBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              OstrackColors.background,
              OstrackColors.backgroundAlt.withOpacity(0.95),
              OstrackColors.background,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -80,
              right: -40,
              child: _GlowOrb(
                color: OstrackColors.gold.withOpacity(0.22),
                size: 240,
              ),
            ),
            Positioned(
              top: 220,
              left: -60,
              child: _GlowOrb(
                color: OstrackColors.teal.withOpacity(0.16),
                size: 220,
              ),
            ),
            Positioned(
              bottom: 120,
              right: -30,
              child: _GlowOrb(
                color: OstrackColors.coral.withOpacity(0.12),
                size: 180,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withOpacity(0.0)],
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

class OstrackCard extends StatelessWidget {
  const OstrackCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.gradient,
    this.radius = 24,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Gradient? gradient;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null ? OstrackColors.surface.withOpacity(0.94) : null,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.22),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}

class OstrackPill extends StatelessWidget {
  const OstrackPill({
    super.key,
    required this.label,
    this.icon,
    this.color,
  });

  final String label;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final accent = color ?? OstrackColors.teal;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: accent.withOpacity(0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: accent),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: OstrackColors.textHigh,
                ),
          ),
        ],
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
          OstrackCard(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF183145), Color(0xFF102432), Color(0xFF0D1823)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OstrackPill(label: 'On This Day', icon: Icons.auto_awesome, color: OstrackColors.gold),
                const SizedBox(height: 16),
                Text('Bloodborne released 10 years ago.', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(
                  'Its most-loved track is still the one people tag when they want a fight to feel mythic.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const _MiniMetric(label: 'Top track', value: 'The First Hunter'),
                    const SizedBox(width: 12),
                    const _MiniMetric(label: 'Activity', value: '214 posts'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Today on OSTrack',
            subtitle: 'Recent shelf activity, reviews, and timeline tags from people you follow.',
          ),
          for (final item in feed) ...[
            _FeedCard(
              icon: item.icon,
              title: item.title,
              subtitle: item.subtitle,
              accent: item.accent,
            ),
            if (item != feed.last) const SizedBox(height: 12),
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

class _MiniMetric extends StatelessWidget {
  const _MiniMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 6),
            Text(value, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
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

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
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
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: categories
                .map(
                  (item) => _CategoryTile(label: item.label, accent: item.accent),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Trending this week',
            subtitle: 'High activity, high intent, and the soundtrack pages people are opening most.',
          ),
          for (final item in trends) ...[
            _TrendRow(label: item.label, meta: item.meta, accent: item.accent),
            if (item != trends.last) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.label, required this.accent});

  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 164,
      child: OstrackCard(
        padding: const EdgeInsets.all(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accent.withOpacity(0.28), OstrackColors.surface.withOpacity(0.9)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.grid_view_rounded, color: accent),
            ),
            const SizedBox(height: 18),
            Text(label, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}

class _TrendRow extends StatelessWidget {
  const _TrendRow({required this.label, required this.meta, required this.accent});

  final String label;
  final String meta;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.14),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.whatshot, color: accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(meta, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: OstrackColors.textMuted),
        ],
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
                  _LibraryTab(
                    title: 'Shelves',
                    child: Column(
                      children: [
                        for (final item in shelves) ...[
                          _ShelfCard(title: item.title, meta: item.meta, accent: item.accent),
                          if (item != shelves.last) const SizedBox(height: 12),
                        ],
                      ],
                    ),
                  ),
                  _LibraryTab(
                    title: 'Ratings',
                    child: Column(
                      children: [
                        for (final item in ratings) ...[
                          _ShelfCard(title: item.title, meta: item.meta, accent: item.accent),
                          if (item != ratings.last) const SizedBox(height: 12),
                        ],
                      ],
                    ),
                  ),
                  _LibraryTab(
                    title: 'History',
                    child: Column(
                      children: [
                        for (final item in history) ...[
                          _ShelfCard(title: item.title, meta: item.meta, accent: item.accent),
                          if (item != history.last) const SizedBox(height: 12),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LibraryTab extends StatelessWidget {
  const _LibraryTab({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _ShelfCard extends StatelessWidget {
  const _ShelfCard({required this.title, required this.meta, required this.accent});

  final String title;
  final String meta;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.collections_bookmark_outlined, color: accent),
          ),
          const SizedBox(width: 14),
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
        ],
      ),
    );
  }
}

class PlayerDashboard extends StatelessWidget {
  const PlayerDashboard({super.key, required this.catalog});

  final OstrackCatalog catalog;

  @override
  Widget build(BuildContext context) {
    final activeTrack = catalog.activeTrack;
    final relatedTracks = catalog.relatedTracks;

    return OstrackPageFrame(
      eyebrow: 'Player',
      title: 'Track context at full size',
      subtitle: 'A dedicated screen for what you are hearing, where it belongs, and how you want to route it.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OstrackCard(
            padding: const EdgeInsets.all(20),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E3445), Color(0xFF0F1D29), Color(0xFF0A131C)],
            ),
            child: AspectRatio(
              aspectRatio: 0.92,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OstrackPill(
                        label: 'From: ${activeTrack.source}',
                        icon: Icons.movie_creation_outlined,
                        color: OstrackColors.gold,
                      ),
                      OstrackPill(
                        label: activeTrack.sceneTag,
                        icon: Icons.verified_outlined,
                        color: OstrackColors.teal,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(activeTrack.title, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text('Composer: ${activeTrack.composer}', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Text(activeTrack.description, style: Theme.of(context).textTheme.bodyMedium),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Open in Spotify'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
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
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Platform selector',
            subtitle: 'Route the track to the user\'s connected service when playback is external.',
          ),
          const Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              OstrackPill(label: 'Spotify', icon: Icons.circle, color: OstrackColors.teal),
              OstrackPill(label: 'Apple Music', icon: Icons.music_note, color: OstrackColors.gold),
              OstrackPill(label: 'YouTube Music', icon: Icons.play_circle_outline, color: OstrackColors.coral),
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
                color: accent.withOpacity(0.14),
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
  const ProfileDashboard({super.key, required this.catalog});

  final OstrackCatalog catalog;

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
          OstrackCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: OstrackColors.teal,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(profile.username),
                          SizedBox(height: 4),
                          Text(profile.bio),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: _ProfileStat(
                        label: 'Ratings',
                        value: profile.ratings.toString(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ProfileStat(
                        label: 'Top composer',
                        value: profile.topComposer,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Public shelves',
            subtitle: 'Your curated shelves are the social currency of the platform.',
          ),
          const _ShelfShowcase(title: 'Tracks that make me feel like I can survive anything', meta: '12 followers'),
          const SizedBox(height: 12),
          const _ShelfShowcase(title: 'Rainy day scores', meta: '48 followers'),
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

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 6),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _ShelfShowcase extends StatelessWidget {
  const _ShelfShowcase({required this.title, required this.meta});

  final String title;
  final String meta;

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: OstrackColors.gold.withOpacity(0.14),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(Icons.book_outlined, color: OstrackColors.gold),
          ),
          const SizedBox(width: 14),
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
        ],
      ),
    );
  }
}
