import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_preferences.dart';
import 'app_providers.dart';
import 'auth/auth_service.dart';
import 'mascot_monetization.dart';
import 'ostrack_catalog.dart';
import 'ostrack_navigation_shell.dart';
import 'onboarding/onboarding_flow.dart';
import 'screens/scene_tag_moderation_screen.dart';
import 'ostrack_widgets.dart';
import 'widgets/offline_boundary.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = _RouterNotifier(ref);

  final router = GoRouter(
    initialLocation: '/',
    refreshListenable: notifier,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const _BootstrapPage(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => _OnboardingRoutePage(catalog: ref.read(catalogProvider)),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => _HomeRoutePage(catalog: ref.read(catalogProvider)),
      ),
      GoRoute(
        path: '/store',
        builder: (context, state) => const _StoreRoutePage(),
      ),
      GoRoute(
        path: '/moderation',
        builder: (context, state) => const SceneTagModerationScreen(),
      ),
    ],
    redirect: (context, state) {
      final path = state.matchedLocation;
      final preferences = ref.read(appPreferencesControllerProvider);
      final preferenceValue = preferences.valueOrNull;

      if (preferences.isLoading || preferences.hasError) {
        return path == '/' ? null : '/';
      }

      final onboardingCompleted = preferenceValue?.onboardingCompleted ?? false;
      final moderationAccessEnabled = preferenceValue?.moderationAccessEnabled ?? false;
      if (path == '/') {
        return onboardingCompleted ? '/home' : '/onboarding';
      }
      if (path == '/moderation' && !moderationAccessEnabled) {
        return '/home';
      }
      if (!onboardingCompleted && path != '/onboarding' && path != '/') {
        return '/onboarding';
      }
      if (onboardingCompleted && path == '/onboarding') {
        return '/home';
      }
      return null;
    },
  );

  ref.onDispose(() {
    notifier.dispose();
    router.dispose();
  });
  return router;
});

class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(this._ref) {
    _ref.listen<AsyncValue<AppPreferences>>(
      appPreferencesControllerProvider,
      (previous, next) => notifyListeners(),
    );
    _ref.listen<AsyncValue<AuthSession?>>(
      authControllerProvider,
      (previous, next) => notifyListeners(),
    );
  }

  final Ref _ref;
}

class _BootstrapPage extends StatelessWidget {
  const _BootstrapPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          OstrackBackdrop(),
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

class _OnboardingRoutePage extends ConsumerWidget {
  const _OnboardingRoutePage({required this.catalog});

  final OstrackCatalog catalog;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(appPreferencesControllerProvider).valueOrNull ?? AppPreferences.defaults;
    final authController = ref.read(authControllerProvider.notifier);
    final preferencesController = ref.read(appPreferencesControllerProvider.notifier);

    return OnboardingFlow(
      catalog: catalog,
      initialPreferences: preferences,
      onSignIn: authController.signIn,
      onComplete: preferencesController.savePreferences,
    );
  }
}

class _HomeRoutePage extends ConsumerWidget {
  const _HomeRoutePage({required this.catalog});

  final OstrackCatalog catalog;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(appPreferencesControllerProvider).valueOrNull ?? AppPreferences.defaults;
    final preferencesController = ref.read(appPreferencesControllerProvider.notifier);
    final authController = ref.read(authControllerProvider.notifier);

    return OfflineBoundary(
      child: OstrackNavigationShell(
        catalog: catalog,
        preferences: preferences,
        onPreferencesChanged: preferencesController.savePreferences,
        onSignOut: () {
          authController.signOut();
          preferencesController.setOnboardingCompleted(false);
        },
      ),
    );
  }
}

class _StoreRoutePage extends ConsumerWidget {
  const _StoreRoutePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(appPreferencesControllerProvider).valueOrNull ?? AppPreferences.defaults;
    final preferencesController = ref.read(appPreferencesControllerProvider.notifier);
    final mascotCatalog = const OstrackMascotCatalog();

    return MascotStorePage(
      catalog: mascotCatalog.viewFor(preferences),
      preferences: preferences,
      onPreferencesChanged: preferencesController.savePreferences,
    );
  }
}
