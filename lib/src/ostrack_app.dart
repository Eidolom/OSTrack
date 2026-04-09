import 'package:flutter/material.dart';

import 'app_preferences.dart';
import 'auth/auth_service.dart';
import 'ostrack_catalog.dart';
import 'onboarding/onboarding_flow.dart';
import 'ostrack_shell.dart';
import 'ostrack_theme.dart';
import 'ostrack_widgets.dart';

class OstrackApp extends StatefulWidget {
  const OstrackApp({
    super.key,
    this.catalog = const OstrackCatalog(),
    this.authService = const AuthService(),
  });

  final OstrackCatalog catalog;
  final AuthService authService;

  @override
  State<OstrackApp> createState() => _OstrackAppState();
}

class _OstrackAppState extends State<OstrackApp> {
  final AppPreferencesStore _preferencesStore = AppPreferencesStore();
  AppPreferences? _preferences;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final loaded = await _preferencesStore.load();
    if (!mounted) {
      return;
    }

    setState(() {
      _preferences = loaded;
    });
  }

  Future<void> _handlePreferencesUpdated(AppPreferences updated) async {
    await _preferencesStore.save(updated);
    if (!mounted) {
      return;
    }

    setState(() {
      _preferences = updated;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPreferences = _preferences;
    final home = switch (currentPreferences) {
      null => const _AppBootstrapLoading(),
      final prefs when prefs.onboardingCompleted => OstrackShell(
          catalog: widget.catalog,
          preferences: prefs,
          onPreferencesChanged: _handlePreferencesUpdated,
        ),
      final prefs => OnboardingFlow(
          catalog: widget.catalog,
          initialPreferences: prefs,
          authService: widget.authService,
          onComplete: _handlePreferencesUpdated,
        ),
    };

    return MaterialApp(
      title: 'OSTrack',
      debugShowCheckedModeBanner: false,
      theme: buildOstrackTheme(),
      home: home,
    );
  }
}

class _AppBootstrapLoading extends StatelessWidget {
  const _AppBootstrapLoading();

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
