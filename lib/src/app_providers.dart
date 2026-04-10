import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app_preferences.dart';
import 'auth/auth_service.dart';
import 'backend/backend_config.dart';
import 'backend/media_repository.dart';
import 'ostrack_catalog.dart';

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
