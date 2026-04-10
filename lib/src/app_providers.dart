import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_preferences.dart';
import 'auth/auth_service.dart';
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
