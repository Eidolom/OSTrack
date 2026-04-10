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

  Future<void> logModerationAction({
    required String tagId,
    required String action,
    required String actorId,
    String? note,
  });

  Future<List<ModerationActionEntry>> fetchRecentActions({int limit = 20});

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

class ModerationActionEntry {
  const ModerationActionEntry({
    required this.tagId,
    required this.action,
    required this.actorId,
    required this.at,
    this.note,
  });

  final String tagId;
  final String action;
  final String actorId;
  final DateTime at;
  final String? note;
}

class SupabaseSceneTagModerationRepository implements SceneTagModerationRepository {
  SupabaseSceneTagModerationRepository({required SupabaseClient? client}) : _client = client;

  final SupabaseClient? _client;
  final Map<String, int> _fallbackReportCounts = <String, int>{};
  final Set<String> _fallbackHiddenTags = <String>{};
  final Map<String, String?> _fallbackSourceTitles = <String, String?>{};
  final Map<String, DateTime> _fallbackLastReportedAt = <String, DateTime>{};
  final List<ModerationActionEntry> _fallbackActionLog = <ModerationActionEntry>[];

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
  Future<void> logModerationAction({
    required String tagId,
    required String action,
    required String actorId,
    String? note,
  }) async {
    final timestamp = DateTime.now();
    _fallbackActionLog.insert(
      0,
      ModerationActionEntry(
        tagId: tagId,
        action: action,
        actorId: actorId,
        at: timestamp,
        note: note,
      ),
    );
    if (_fallbackActionLog.length > 200) {
      _fallbackActionLog.removeRange(200, _fallbackActionLog.length);
    }

    final client = _client;
    if (client == null) {
      return;
    }

    try {
      await client.from('scene_tag_moderation_actions').insert({
        'tag_id': tagId,
        'action': action,
        'actor_id': actorId,
        'note': note,
        'created_at': timestamp.toIso8601String(),
      });
    } catch (_) {
      // Keep fallback action log when backend table is unavailable.
    }
  }

  @override
  Future<List<ModerationActionEntry>> fetchRecentActions({int limit = 20}) async {
    final client = _client;
    if (client == null) {
      return _fallbackActionLog.take(limit).toList(growable: false);
    }

    try {
      final response = await client
          .from('scene_tag_moderation_actions')
          .select('tag_id, action, actor_id, note, created_at')
          .order('created_at', ascending: false)
          .limit(limit);

      final rows = response as List<dynamic>;
      return rows.map((row) {
        final map = row as Map<String, dynamic>;
        return ModerationActionEntry(
          tagId: map['tag_id']?.toString() ?? 'unknown',
          action: map['action']?.toString() ?? 'unknown',
          actorId: map['actor_id']?.toString() ?? 'unknown',
          note: map['note']?.toString(),
          at: DateTime.tryParse(map['created_at']?.toString() ?? '') ??
              DateTime.fromMillisecondsSinceEpoch(0),
        );
      }).toList(growable: false);
    } catch (_) {
      return _fallbackActionLog.take(limit).toList(growable: false);
    }
  }

  @override
  bool shouldAutoHide(int reportCount) => reportCount > 2;
}
