import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../backend/backend_config.dart';
import '../ostrack_catalog.dart';
import '../ostrack_theme.dart';

class MediaSearchResult {
  const MediaSearchResult({
    required this.title,
    required this.source,
    required this.alias,
  });

  final String title;
  final String source;
  final String alias;
}

abstract class MediaRepository {
  Future<List<CategoryEntry>> fetchCategories();
  Future<List<TrendEntry>> fetchTrends();
  Future<ActiveTrackEntry> fetchActiveTrack();
  Future<List<MediaSearchResult>> searchTracks(String query);
}

class SupabaseMediaRepository implements MediaRepository {
  SupabaseMediaRepository({
    required SupabaseClient? client,
    required OstrackCatalog seedCatalog,
  })  : _client = client,
        _seed = seedCatalog;

  final SupabaseClient? _client;
  final OstrackCatalog _seed;

  @override
  Future<List<CategoryEntry>> fetchCategories() async {
    if (_client == null) {
      return _seed.categories;
    }

    try {
      final rows = await _client
          .from('media_sources')
          .select('media_type')
          .limit(100);

      final counts = <String, int>{};
      for (final row in (rows as List<dynamic>)) {
        final rawType = (row as Map<String, dynamic>)['media_type']?.toString() ?? 'Unknown';
        final label = _mapMediaType(rawType);
        counts[label] = (counts[label] ?? 0) + 1;
      }

      if (counts.isEmpty) {
        return _seed.categories;
      }

      final ordered = counts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      return ordered
          .map(
            (entry) => CategoryEntry(
              label: entry.key,
              accent: _accentForCategory(entry.key),
            ),
          )
          .toList(growable: false);
    } catch (_) {
      return _seed.categories;
    }
  }

  @override
  Future<List<TrendEntry>> fetchTrends() async {
    if (_client == null) {
      return _seed.trends;
    }

    try {
      final rows = await _client
          .from('media_sources')
          .select('title, track_count, activity_score')
          .order('activity_score', ascending: false)
          .limit(12);

      final mapped = (rows as List<dynamic>).map((raw) {
        final row = raw as Map<String, dynamic>;
        final title = row['title']?.toString() ?? 'Unknown OST';
        final trackCount = (row['track_count'] as num?)?.toInt() ?? 0;
        final activityScore = (row['activity_score'] as num?)?.toInt() ?? 0;

        return TrendEntry(
          label: title,
          meta: '$trackCount tracks · $activityScore activities',
          accent: _accentForTrend(title),
        );
      }).toList(growable: false);

      return mapped.isEmpty ? _seed.trends : mapped;
    } catch (_) {
      return _seed.trends;
    }
  }

  @override
  Future<ActiveTrackEntry> fetchActiveTrack() async {
    if (_client == null) {
      return _seed.activeTrack;
    }

    try {
      final rows = await _client
          .from('tracks')
          .select('title, description, scene_tag, source_title, composer_name')
          .limit(1);

      if ((rows as List<dynamic>).isEmpty) {
        return _seed.activeTrack;
      }

      final row = rows.first;
      return ActiveTrackEntry(
        title: row['title']?.toString() ?? _seed.activeTrack.title,
        composer: row['composer_name']?.toString() ?? _seed.activeTrack.composer,
        source: row['source_title']?.toString() ?? _seed.activeTrack.source,
        description: row['description']?.toString() ?? _seed.activeTrack.description,
        sceneTag: row['scene_tag']?.toString() ?? _seed.activeTrack.sceneTag,
      );
    } catch (_) {
      return _seed.activeTrack;
    }
  }

  @override
  Future<List<MediaSearchResult>> searchTracks(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      return const [];
    }

    if (!BackendConfig.hasTypesense) {
      return _fallbackSearch(trimmed);
    }

    try {
      final client = HttpClient();
      final uri = Uri.parse(
        '${BackendConfig.typesenseProtocol}://${BackendConfig.typesenseHost}:${BackendConfig.typesensePort}/collections/tracks/documents/search'
        '?q=${Uri.encodeQueryComponent(trimmed)}'
        '&query_by=title,aliases,source_title,composer_name'
        '&per_page=8',
      );
      final request = await client.getUrl(uri);
      request.headers.set('X-TYPESENSE-API-KEY', BackendConfig.typesenseApiKey);
      final response = await request.close();
      final payload = await response.transform(utf8.decoder).join();
      client.close(force: true);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return _fallbackSearch(trimmed);
      }

      final decoded = jsonDecode(payload) as Map<String, dynamic>;
      final hits = decoded['hits'] as List<dynamic>? ?? const [];
      if (hits.isEmpty) {
        return _fallbackSearch(trimmed);
      }

      return hits.map((raw) {
        final document = (raw as Map<String, dynamic>)['document'] as Map<String, dynamic>? ?? const {};
        return MediaSearchResult(
          title: document['title']?.toString() ?? 'Unknown track',
          source: document['source_title']?.toString() ?? 'Unknown source',
          alias: _firstAlias(document['aliases']),
        );
      }).toList(growable: false);
    } catch (_) {
      return _fallbackSearch(trimmed);
    }
  }

  List<MediaSearchResult> _fallbackSearch(String query) {
    final normalized = query.toLowerCase();
    final corpus = <MediaSearchResult>[
      const MediaSearchResult(title: 'City of Tears', source: 'Hollow Knight', alias: 'Hallownest rain theme'),
      const MediaSearchResult(title: 'One-Winged Angel', source: 'Final Fantasy VII', alias: '片翼の天使'),
      const MediaSearchResult(title: '戦いの時', source: 'Chrono Trigger', alias: 'Time of Battle'),
      const MediaSearchResult(title: 'The First Hunter', source: 'Bloodborne', alias: 'Gehrman battle'),
      const MediaSearchResult(title: 'Megalovania', source: 'Undertale', alias: 'メガロヴァニア'),
    ];

    return corpus
        .where(
          (entry) => entry.title.toLowerCase().contains(normalized) ||
              entry.alias.toLowerCase().contains(normalized) ||
              entry.source.toLowerCase().contains(normalized),
        )
        .take(8)
        .toList(growable: false);
  }

  String _mapMediaType(String rawType) {
    final normalized = rawType.toLowerCase();
    if (normalized.contains('game')) {
      return 'Video Games';
    }
    if (normalized.contains('anime')) {
      return 'Anime';
    }
    if (normalized.contains('movie') || normalized.contains('film') || normalized.contains('tv')) {
      return 'Movies & TV';
    }
    if (normalized.contains('drama')) {
      return 'K-Drama';
    }
    return 'Originals';
  }

  String _firstAlias(Object? aliasesField) {
    if (aliasesField is List && aliasesField.isNotEmpty) {
      return aliasesField.first.toString();
    }
    return 'No alias metadata';
  }

  Color _accentForCategory(String label) {
    return switch (label) {
      'Video Games' => OstrackColors.gold,
      'Anime' => OstrackColors.teal,
      'Movies & TV' => OstrackColors.coral,
      'K-Drama' => const Color(0xFF9B8CFF),
      'Composers' => const Color(0xFF7CC8FF),
      _ => const Color(0xFFFFA94D),
    };
  }

  Color _accentForTrend(String title) {
    final hash = title.codeUnits.fold<int>(0, (value, code) => value + code);
    const pool = [
      OstrackColors.gold,
      OstrackColors.teal,
      OstrackColors.coral,
      Color(0xFF9B8CFF),
      Color(0xFF7CC8FF),
    ];
    return pool[hash % pool.length];
  }
}
