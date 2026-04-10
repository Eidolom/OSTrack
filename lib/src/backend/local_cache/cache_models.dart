import 'package:isar/isar.dart';

part 'cache_models.g.dart';

// ============================================================================
// CACHED FEED STORY
// ============================================================================

@collection
class CachedFeedStory {
  Id id = Isar.autoIncrement; // Isar internal ID

  @Index(unique: true, replace: true)
  late String remoteId; // Supabase UUID

  late String title;
  late String subtitle;
  late String iconName;
  late String accentHex;
  late DateTime createdAt;
}

// ============================================================================
// PENDING MUTATION
// ============================================================================

@collection
class PendingMutation {
  Id id = Isar.autoIncrement;

  late String mutationType; // e.g., 'ADD_TO_SHELF', 'TAG_SCENE'
  late String payloadJson;
  late int retryCount;
  late DateTime createdAt;
}
