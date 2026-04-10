import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:isar/isar.dart';

import 'app_preferences.dart';
import 'auth/auth_service.dart';
import 'backend/backend_config.dart';
import 'backend/media_repository.dart';
import 'backend/shelf_repository.dart';
import 'backend/cache_models.dart';
import 'ostrack_catalog.dart';
import 'playback/original_audio_service.dart';
import 'playback/playback_handoff_service.dart';

final catalogProvider = Provider<OstrackCatalog>((ref) => const OstrackCatalog());

final appPreferencesStoreProvider = Provider<AppPreferencesStore>((ref) => AppPreferencesStore());

final authServiceProvider = Provider<AuthService>((ref) => const AuthService());

final appPreferencesControllerProvider = AsyncNotifierProvider<AppPreferencesController, AppPreferences>(
  AppPreferencesController.new,
);

final authControllerProvider = AsyncNotifierProvider<AuthController, AuthSession?>(
  AuthController.new,
);

final mediaRepositoryProvider = Provider<MediaRepository>((ref) {
  return SupabaseMediaRepository(
    client: BackendConfig.hasSupabase ? Supabase.instance.client : null,
    seedCatalog: ref.watch(catalogProvider),
  );
});

final categoriesProvider = FutureProvider<List<CategoryEntry>>((ref) async {
  return ref.watch(mediaRepositoryProvider).fetchCategories();
});

final trendsProvider = FutureProvider<List<TrendEntry>>((ref) async {
  return ref.watch(mediaRepositoryProvider).fetchTrends();
});

final activeTrackProvider = FutureProvider<ActiveTrackEntry>((ref) async {
  return ref.watch(mediaRepositoryProvider).fetchActiveTrack();
});

final exploreSearchQueryProvider = StateProvider<String>((ref) => '');

final exploreSearchResultsProvider = FutureProvider<List<MediaSearchResult>>((ref) async {
  final query = ref.watch(exploreSearchQueryProvider);
  if (query.trim().isEmpty) {
    return const [];
  }
  return ref.watch(mediaRepositoryProvider).searchTracks(query);
});

final playbackHandoffServiceProvider = Provider<PlaybackHandoffService>((ref) {
  return PlaybackHandoffService();
});

final originalAudioServiceProvider = Provider<OriginalAudioService>((ref) {
  final service = OriginalAudioService();
  ref.onDispose(() {
    service.dispose();
  });
  return service;
});

final originalPlayerStateProvider = StreamProvider<PlayerState>((ref) {
  return ref.watch(originalAudioServiceProvider).playerStateStream;
});

// ============================================================================
// SHELF & MUTATION PROVIDERS
// ============================================================================

final isarProvider = Provider<Isar?>((ref) {
  // This should be initialized in main() and set via provider override
  return null;
});

final shelfRepositoryProvider = Provider<ShelfRepository>((ref) {
  final isar = ref.watch(isarProvider);
  if (isar == null) {
    throw Exception('Isar not initialized');
  }

  if (BackendConfig.hasSupabase) {
    return SupabaseShelfRepository(
      isar: isar,
      client: Supabase.instance.client,
    );
  } else {
    return LocalShelfRepository(isar: isar);
  }
});

final shelvesProvider = FutureProvider<List<IsarShelf>>((ref) async {
  return ref.watch(shelfRepositoryProvider).getShelves();
});

final selectedShelfIdProvider = StateProvider<String?>((ref) => null);

final shelfTracksProvider = FutureProvider<List<IsarShelfTrack>>((ref) async {
  final shelfId = ref.watch(selectedShelfIdProvider);
  if (shelfId == null) {
    return const [];
  }
  return ref.watch(shelfRepositoryProvider).getShelfTracks(shelfId);
});

final pendingMutationsProvider = FutureProvider<List<IsarPendingMutation>>((ref) async {
  return ref.watch(shelfRepositoryProvider).getPendingMutations();
});

final shelfControllerProvider = Provider<ShelfController>((ref) {
  return ShelfController(ref);
});

class ShelfController {
  ShelfController(this.ref);

  final Ref ref;

  /// Add a track to a shelf with optimistic UI update
  Future<String> addToShelf({
    required String shelfId,
    required String trackId,
    required String trackTitle,
    required String composerName,
    required String sourceName,
  }) async {
    final mutationId = await ref.read(shelfRepositoryProvider).addToShelf(
          shelfId: shelfId,
          trackId: trackId,
          trackTitle: trackTitle,
          composerName: composerName,
          sourceName: sourceName,
        );

    // Invalidate shelf tracks to refresh UI
    ref.invalidate(shelfTracksProvider);
    ref.invalidate(pendingMutationsProvider);

    return mutationId;
  }

  /// Remove a track from a shelf
  Future<String> removeFromShelf({
    required String shelfId,
    required String trackId,
  }) async {
    final mutationId = await ref.read(shelfRepositoryProvider).removeFromShelf(
          shelfId: shelfId,
          trackId: trackId,
        );

    // Invalidate shelf tracks to refresh UI
    ref.invalidate(shelfTracksProvider);
    ref.invalidate(pendingMutationsProvider);

    return mutationId;
  }

  /// Rate a track
  Future<String> rateTrack({
    required String trackId,
    required double rating,
  }) async {
    final mutationId = await ref.read(shelfRepositoryProvider).rateTrack(
          trackId: trackId,
          rating: rating,
        );

    // Invalidate pending mutations
    ref.invalidate(pendingMutationsProvider);

    return mutationId;
  }

  /// Retry a failed mutation
  Future<void> retryMutation(String mutationId) async {
    await ref.read(shelfRepositoryProvider).retryMutation(mutationId);
    ref.invalidate(pendingMutationsProvider);
  }

  /// Cancel a pending mutation
  Future<void> cancelMutation(String mutationId) async {
    await ref.read(shelfRepositoryProvider).cancelMutation(mutationId);
    ref.invalidate(pendingMutationsProvider);
  }
}

class AppPreferencesController extends AsyncNotifier<AppPreferences> {
  @override
  Future<AppPreferences> build() async {
    return ref.read(appPreferencesStoreProvider).load();
  }

  Future<void> savePreferences(AppPreferences updated) async {
    state = AsyncValue.data(updated);
    await ref.read(appPreferencesStoreProvider).save(updated);
  }

  Future<void> updateWith(AppPreferences Function(AppPreferences current) transform) async {
    final current = state.valueOrNull ?? await future;
    await savePreferences(transform(current));
  }

  Future<void> setOnboardingCompleted(bool completed) async {
    await updateWith((current) => current.copyWith(onboardingCompleted: completed));
  }
}

class AuthController extends AsyncNotifier<AuthSession?> {
  @override
  Future<AuthSession?> build() async {
    return null;
  }

  Future<AuthSession> signIn(AuthProvider provider) async {
    state = const AsyncLoading<AuthSession?>();
    final session = await ref.read(authServiceProvider).signIn(provider);
    state = AsyncValue.data(session);
    return session;
  }

  void signOut() {
    state = const AsyncValue.data(null);
  }
}
