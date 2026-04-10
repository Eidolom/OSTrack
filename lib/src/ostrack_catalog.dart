import 'package:flutter/material.dart';

import 'ostrack_theme.dart';

class FeedStory {
  const FeedStory({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  // Seed-only UI shape. Production feed data should use backend enum/asset keys,
  // not framework-level icon types.
}

class CategoryEntry {
  const CategoryEntry({
    required this.label,
    required this.accent,
  });

  final String label;
  final Color accent;
}

class TrendEntry {
  const TrendEntry({
    required this.label,
    required this.meta,
    required this.accent,
  });

  final String label;
  final String meta;
  final Color accent;
}

class LibraryEntry {
  const LibraryEntry({
    required this.title,
    required this.meta,
    required this.accent,
  });

  final String title;
  final String meta;
  final Color accent;
}

class RelatedTrackEntry {
  const RelatedTrackEntry({
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final String title;
  final String subtitle;
  final Color accent;
}

class RecommendationEntry {
  const RecommendationEntry({
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final String title;
  final String subtitle;
  final Color accent;
}

class ActiveTrackEntry {
  const ActiveTrackEntry({
    required this.title,
    required this.composer,
    required this.source,
    required this.description,
    required this.sceneTag,
    this.albumArtUrl = '',
  });

  final String title;
  final String composer;
  final String source;
  final String description;
  final String sceneTag;
  final String albumArtUrl;
}

class ProfileEntry {
  const ProfileEntry({
    required this.username,
    required this.bio,
    required this.ratings,
    required this.topComposer,
  });

  final String username;
  final String bio;
  final int ratings;
  final String topComposer;
}

class OstrackCatalog {
  const OstrackCatalog();

  List<FeedStory> get homeFeed => const [
        FeedStory(
          icon: Icons.playlist_add_check,
          title: '@yukirose added One-Winged Angel to Tracks That Changed Me',
          subtitle: 'Shelf activity · 4 minutes ago',
          accent: OstrackColors.teal,
        ),
        FeedStory(
          icon: Icons.rate_review_outlined,
          title: '@ostnerdd reviewed the NieR:Automata OST ★★★★★',
          subtitle: 'New review · 18 minutes ago',
          accent: OstrackColors.gold,
        ),
        FeedStory(
          icon: Icons.flag_outlined,
          title: '@melodyarchive tagged a moment in Shadow of the Colossus',
          subtitle: 'Scene timeline · 41 minutes ago',
          accent: OstrackColors.coral,
        ),
      ];

  List<CategoryEntry> get categories => const [
        CategoryEntry(label: 'Video Games', accent: OstrackColors.gold),
        CategoryEntry(label: 'Anime', accent: OstrackColors.teal),
        CategoryEntry(label: 'Movies & TV', accent: OstrackColors.coral),
        CategoryEntry(label: 'K-Drama', accent: Color(0xFF9B8CFF)),
        CategoryEntry(label: 'Composers', accent: Color(0xFF7CC8FF)),
        CategoryEntry(label: 'Originals', accent: Color(0xFFFFA94D)),
      ];

  List<TrendEntry> get trends => const [
        TrendEntry(label: 'Elden Ring', meta: '285 tracks · 9k activities', accent: OstrackColors.gold),
        TrendEntry(label: 'Cowboy Bebop', meta: '78 tracks · 6k activities', accent: OstrackColors.teal),
        TrendEntry(label: 'Dune', meta: '41 tracks · 4k activities', accent: OstrackColors.coral),
      ];

  List<RecommendationEntry> get recommendations => const [
        RecommendationEntry(
          title: 'Final Fantasy VII',
          subtitle: 'Composer heat: high',
          accent: OstrackColors.gold,
        ),
        RecommendationEntry(
          title: 'Cowboy Bebop',
          subtitle: 'Shelf match: 94%',
          accent: OstrackColors.teal,
        ),
        RecommendationEntry(
          title: 'NieR:Automata',
          subtitle: 'Scene tags pending',
          accent: OstrackColors.coral,
        ),
      ];

  List<LibraryEntry> get shelves => const [
        LibraryEntry(
          title: 'Tracks That Changed Me',
          meta: 'Public · 52 tracks · 184 followers',
          accent: OstrackColors.teal,
        ),
        LibraryEntry(
          title: 'Crying in the car playlist',
          meta: 'Private · 19 tracks · 0 followers',
          accent: OstrackColors.coral,
        ),
      ];

  List<LibraryEntry> get ratings => const [
        LibraryEntry(
          title: 'NieR:Automata OST',
          meta: 'Average: 4.9 · Rated 32 tracks',
          accent: OstrackColors.gold,
        ),
        LibraryEntry(
          title: 'Final Fantasy VII',
          meta: 'Average: 4.8 · Rated 18 tracks',
          accent: OstrackColors.teal,
        ),
      ];

  List<LibraryEntry> get history => const [
        LibraryEntry(
          title: 'Margit, the Fell Omen',
          meta: 'Played 14 minutes ago',
          accent: OstrackColors.coral,
        ),
        LibraryEntry(
          title: 'The Day I Became the Wind',
          meta: 'Played 1 hour ago',
          accent: OstrackColors.gold,
        ),
      ];

  ActiveTrackEntry get activeTrack => const ActiveTrackEntry(
        title: 'City of Tears',
        composer: 'Christopher Larkin',
        source: 'Hollow Knight',
        description: 'Plays during the rain-soaked descent into Hallownest. Community tags call it the emotional hinge of the route.',
        sceneTag: 'Verified scene tag',
      );

  List<RelatedTrackEntry> get relatedTracks => const [
        RelatedTrackEntry(title: 'Greenpath', subtitle: 'Hollow Knight', accent: OstrackColors.coral),
        RelatedTrackEntry(title: 'Mantis Lords', subtitle: 'Hollow Knight', accent: OstrackColors.gold),
        RelatedTrackEntry(title: 'Radiance', subtitle: 'Hollow Knight', accent: OstrackColors.teal),
      ];

  ProfileEntry get profile => const ProfileEntry(
        username: 'melodyarchive',
        bio: 'Collector of sad boss themes and immaculate scene tags.',
        ratings: 1284,
        topComposer: 'Yoko Shimomura',
      );
}
