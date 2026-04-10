import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import 'app_providers.dart';
import 'app_router.dart';
import 'auth/auth_service.dart';
import 'ostrack_theme.dart';

class OstrackApp extends StatelessWidget {
  const OstrackApp({
    super.key,
    required this.isar,
    this.authService = const AuthService(),
  });

  final Isar isar;
  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        authServiceProvider.overrideWithValue(authService),
        isarProvider.overrideWithValue(isar),
      ],
      child: const _OstrackAppView(),
    );
  }
}

class _OstrackAppView extends ConsumerWidget {
  const _OstrackAppView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'OSTrack',
      debugShowCheckedModeBanner: false,
      theme: buildOstrackTheme(),
      routerConfig: router,
    );
  }
}
