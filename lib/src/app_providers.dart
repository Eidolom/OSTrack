import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:isar/isar.dart';

import 'app_preferences.dart';
import 'auth/auth_service.dart';
import 'backend/backend_config.dart';
import 'backend/mascot_repository.dart';
import 'backend/media_repository.dart';
import 'backend/shelf_repository.dart';
import 'backend/cache_models.dart';
import 'backend/local_cache/cache_models.dart';
import 'mascot_monetization.dart';
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
    isar: ref.watch(isarProvider),
  );
});

final mascotRepositoryProvider = Provider<MascotRepository>((ref) {
  return SupabaseMascotRepository(
    client: BackendConfig.hasSupabase ? Supabase.instance.client : null,
    seedCatalog: const OstrackMascotCatalog(),
    preferencesStore: ref.watch(appPreferencesStoreProvider),
  );
});

final mascotCatalogViewProvider = FutureProvider<MascotCatalogView>((ref) async {
  final repo = ref.watch(mascotRepositoryProvider);
  final mascots = await repo.fetchMascots();
  final owned = await repo.fetchOwnedMascots();
  final equippedId = await repo.fetchEquippedMascotId();

  final ownedIds = owned.map((record) => record.mascotId).toSet().toList(growable: false);
  final resolvedEquippedId = equippedId.isEmpty
      ? (ownedIds.isNotEmpty ? ownedIds.first : AppPreferences.defaults.equippedMascotId)
      : equippedId;

  return MascotCatalogView(
    mascots: mascots,
    ownedMascotIds: ownedIds,
    equippedMascotId: resolvedEquippedId,
  );
});

final mascotControllerProvider = Provider<MascotController>((ref) {
  return MascotController(ref);
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

class MascotController {
  MascotController(this.ref);

  final Ref ref;

  Future<void> equipMascot(String mascotId) async {
    await ref.read(mascotRepositoryProvider).equipMascot(mascotId);
    await ref.read(appPreferencesControllerProvider.notifier).updateWith(
          (current) => current.copyWith(equippedMascotId: mascotId),
        );
    ref.invalidate(mascotCatalogViewProvider);
  }

  Future<void> purchaseMascot(String mascotId) async {
    await ref.read(mascotRepositoryProvider).purchaseMascot(mascotId);

    await ref.read(appPreferencesControllerProvider.notifier).updateWith((current) {
      final owned = current.ownedMascotIds.toSet()..add(mascotId);
      return current.copyWith(ownedMascotIds: owned.toList(growable: false));
    });

    ref.invalidate(mascotCatalogViewProvider);
  }
}

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

// ============================================================================
// HOME FEED CONTROLLER - CACHE-THEN-NETWORK PATTERN
// ============================================================================

class HomeFeedController extends AsyncNotifier<List<CachedFeedStory>> {
  @override
  Future<List<CachedFeedStory>> build() async {
    final repo = ref.watch(mediaRepositoryProvider);

    // 1. INSTANT LOAD: Yield local cache immediately
    final cached = await repo.getLocalFeed();
    if (cached.isNotEmpty) {
      state = AsyncValue.data(cached);
    }

    // 2. BACKGROUND FETCH: Get fresh data from Supabase
    try {
      final fresh = await repo.getNetworkFeed();
      // 3. UPDATE CACHE: Save to Isar
      await repo.saveToLocalFeed(fresh);
      // 4. UPDATE UI
      return fresh;
    } catch (e, st) {
      // If we are offline, suppress the error and just keep showing the cache
      if (cached.isNotEmpty) {
        return cached;
      }
      // Only throw if we have no cache AND no network
      Error.throwWithStackTrace(e, st);
    }
  }
}

final homeFeedProvider = AsyncNotifierProvider<HomeFeedController, List<CachedFeedStory>>(
  HomeFeedController.new,
);
