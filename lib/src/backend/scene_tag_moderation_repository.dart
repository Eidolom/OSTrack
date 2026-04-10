import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SceneTagModerationRepository {
  Future<int> reportTag({
    required String tagId,
    required String reason,
    String? sourceTitle,
  });

  bool shouldAutoHide(int reportCount) => reportCount > 2;
}

class SupabaseSceneTagModerationRepository implements SceneTagModerationRepository {
  SupabaseSceneTagModerationRepository({required SupabaseClient? client}) : _client = client;

  final SupabaseClient? _client;
  final Map<String, int> _fallbackReportCounts = <String, int>{};

  @override
  Future<int> reportTag({
    required String tagId,
    required String reason,
    String? sourceTitle,
  }) async {
    final client = _client;
    if (client == null) {
      return _incrementFallback(tagId);
    }

    try {
      await client.from('scene_tag_reports').insert({
        'tag_id': tagId,
        'reason': reason,
        'source_title': sourceTitle,
        'created_at': DateTime.now().toIso8601String(),
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
    return next;
  }

  @override
  bool shouldAutoHide(int reportCount) => reportCount > 2;
}
