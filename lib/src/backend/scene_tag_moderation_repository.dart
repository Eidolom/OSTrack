import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SceneTagModerationRepository {
  Future<int> reportTag({
    required String tagId,
    required String reason,
    String? sourceTitle,
  });

  Future<List<ModerationQueueEntry>> fetchModerationQueue();

  Future<void> setTagHiddenState({
    required String tagId,
    required bool isHidden,
  });

  bool shouldAutoHide(int reportCount) => reportCount > 2;
}

class ModerationQueueEntry {
  const ModerationQueueEntry({
    required this.tagId,
    required this.reportCount,
    required this.isHidden,
    this.sourceTitle,
    this.lastReportedAt,
  });

  final String tagId;
  final int reportCount;
  final bool isHidden;
  final String? sourceTitle;
  final DateTime? lastReportedAt;
}

class SupabaseSceneTagModerationRepository implements SceneTagModerationRepository {
  SupabaseSceneTagModerationRepository({required SupabaseClient? client}) : _client = client;

  final SupabaseClient? _client;
  final Map<String, int> _fallbackReportCounts = <String, int>{};
  final Set<String> _fallbackHiddenTags = <String>{};
  final Map<String, String?> _fallbackSourceTitles = <String, String?>{};
  final Map<String, DateTime> _fallbackLastReportedAt = <String, DateTime>{};

  @override
  Future<int> reportTag({
    required String tagId,
    required String reason,
    String? sourceTitle,
  }) async {
    if (sourceTitle != null && sourceTitle.isNotEmpty) {
      _fallbackSourceTitles[tagId] = sourceTitle;
    }

    final client = _client;
    if (client == null) {
      return _incrementFallback(tagId);
    }

    try {
      final now = DateTime.now();
      await client.from('scene_tag_reports').insert({
        'tag_id': tagId,
        'reason': reason,
        'source_title': sourceTitle,
        'created_at': now.toIso8601String(),
      });

      final countResponse = await client
          .from('scene_tag_reports')
          .select('id')
          .eq('tag_id', tagId);

      final reportCount = (countResponse as List<dynamic>).length;

      if (shouldAutoHide(reportCount)) {
        try {
          await client
              .from('scene_timeline_votes')
              .update({'is_hidden': true})
              .eq('id', tagId);
        } catch (_) {
          // Ignore schema variance until migration lands.
        }
      }

      return reportCount;
    } catch (_) {
      return _incrementFallback(tagId);
    }
  }

  int _incrementFallback(String tagId) {
    final next = (_fallbackReportCounts[tagId] ?? 0) + 1;
    _fallbackReportCounts[tagId] = next;
    _fallbackLastReportedAt[tagId] = DateTime.now();
    if (shouldAutoHide(next)) {
      _fallbackHiddenTags.add(tagId);
    }
    return next;
  }

  @override
  Future<List<ModerationQueueEntry>> fetchModerationQueue() async {
    final client = _client;
    if (client == null) {
      return _buildFallbackQueue();
    }

    try {
      final reportsResponse = await client
          .from('scene_tag_reports')
          .select('tag_id, source_title, created_at')
          .order('created_at', ascending: false)
          .limit(200);

      final reportRows = reportsResponse as List<dynamic>;
      final countsByTag = <String, int>{};
      final sourceByTag = <String, String?>{};
      final latestByTag = <String, DateTime?>{};

      for (final row in reportRows) {
        final map = row as Map<String, dynamic>;
        final tagId = map['tag_id']?.toString();
        if (tagId == null || tagId.isEmpty) {
          continue;
        }
        countsByTag[tagId] = (countsByTag[tagId] ?? 0) + 1;
        sourceByTag[tagId] ??= map['source_title']?.toString();

        final createdRaw = map['created_at']?.toString();
        if (createdRaw != null) {
          latestByTag[tagId] ??= DateTime.tryParse(createdRaw);
        }
      }

      final hiddenTags = <String>{};
      try {
        final hiddenResponse = await client
            .from('scene_timeline_votes')
            .select('id, is_hidden')
            .eq('is_hidden', true)
            .limit(200);

        for (final row in (hiddenResponse as List<dynamic>)) {
          final map = row as Map<String, dynamic>;
          final id = map['id']?.toString();
          if (id != null && id.isNotEmpty) {
            hiddenTags.add(id);
          }
        }
      } catch (_) {
        // Continue with report-count-only visibility fallback.
      }

      final entries = countsByTag.entries
          .map(
            (entry) => ModerationQueueEntry(
              tagId: entry.key,
              reportCount: entry.value,
              isHidden: hiddenTags.contains(entry.key) || shouldAutoHide(entry.value),
              sourceTitle: sourceByTag[entry.key],
              lastReportedAt: latestByTag[entry.key],
            ),
          )
          .toList()
        ..sort(
          (a, b) => (b.lastReportedAt ?? DateTime.fromMillisecondsSinceEpoch(0))
              .compareTo(a.lastReportedAt ?? DateTime.fromMillisecondsSinceEpoch(0)),
        );

      return entries;
    } catch (_) {
      return _buildFallbackQueue();
    }
  }

  List<ModerationQueueEntry> _buildFallbackQueue() {
    final entries = _fallbackReportCounts.entries
        .map(
          (entry) => ModerationQueueEntry(
            tagId: entry.key,
            reportCount: entry.value,
            isHidden: _fallbackHiddenTags.contains(entry.key),
            sourceTitle: _fallbackSourceTitles[entry.key],
            lastReportedAt: _fallbackLastReportedAt[entry.key],
          ),
        )
        .toList()
      ..sort(
        (a, b) => (b.lastReportedAt ?? DateTime.fromMillisecondsSinceEpoch(0))
            .compareTo(a.lastReportedAt ?? DateTime.fromMillisecondsSinceEpoch(0)),
      );
    return entries;
  }

  @override
  Future<void> setTagHiddenState({
    required String tagId,
    required bool isHidden,
  }) async {
    final client = _client;

    if (isHidden) {
      _fallbackHiddenTags.add(tagId);
    } else {
      _fallbackHiddenTags.remove(tagId);
    }

    if (client == null) {
      return;
    }

    try {
      await client
          .from('scene_timeline_votes')
          .update({'is_hidden': isHidden})
          .eq('id', tagId);
    } catch (_) {
      // Ignore schema variance; local moderation fallback remains in place.
    }
  }

  @override
  bool shouldAutoHide(int reportCount) => reportCount > 2;
}
