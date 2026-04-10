import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_preferences.dart';
import 'app_providers.dart';
import 'mascot_monetization.dart';
import 'ostrack_catalog.dart';
import 'ostrack_shell.dart';
import 'ostrack_theme.dart';
import 'ostrack_widgets.dart';
import 'widgets/frosted_mini_player.dart';

class OstrackNavigationShell extends ConsumerStatefulWidget {
  const OstrackNavigationShell({
    super.key,
    required this.catalog,
    required this.preferences,
    required this.onPreferencesChanged,
    required this.onSignOut,
  });

  final OstrackCatalog catalog;
  final AppPreferences preferences;
  final PreferencesUpdater onPreferencesChanged;
  final VoidCallback onSignOut;

  @override
  ConsumerState<OstrackNavigationShell> createState() => _OstrackNavigationShellState();
}

class _OstrackNavigationShellState extends ConsumerState<OstrackNavigationShell> {
  int _currentIndex = 0;
  bool _isPlayerExpanded = false;

  void _openMediaSource(String title) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MediaSourcePage(
          title: title,
          selectedPlatform: widget.preferences.selectedPlatform,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeTrack = ref.watch(activeTrackProvider).valueOrNull ?? widget.catalog.activeTrack;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          const OstrackBackdrop(),
          IndexedStack(
            index: _currentIndex,
            children: [
              TickerMode(
                enabled: _currentIndex == 0,
                child: HomeDashboard(
                  catalog: widget.catalog,
                  onOpenProfile: () {
                    setState(() {
                      _currentIndex = 3;
                    });
                  },
                ),
              ),
              TickerMode(
                enabled: _currentIndex == 1,
                child: ExploreDashboard(onOpenMediaSource: _openMediaSource),
              ),
              TickerMode(enabled: _currentIndex == 2, child: LibraryDashboard(catalog: widget.catalog)),
              TickerMode(
                enabled: _currentIndex == 3,
                child: ProfileDashboard(
                  catalog: widget.catalog,
                  preferences: widget.preferences,
                  onPreferencesChanged: widget.onPreferencesChanged,
                  onSignOut: widget.onSignOut,
                  mascotCatalog: const OstrackMascotCatalog(),
                ),
              ),
            ],
          ),
          if (_isPlayerExpanded)
            Positioned.fill(
              child: ColoredBox(
                color: OstrackColors.background,
                child: Stack(
                  children: [
                    PlayerDashboard(
                      catalog: widget.catalog,
                      selectedPlatform: widget.preferences.selectedPlatform,
                      initialTrack: activeTrack,
                    ),
                    Positioned(
                      top: 18,
                      right: 18,
                      child: IconButton.filledTonal(
                        onPressed: () {
                          setState(() {
                            _isPlayerExpanded = false;
                          });
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: _isPlayerExpanded
          ? null
          : ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0A0A).withValues(alpha: 0.65),
                    border: Border(
                      top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FrostedMiniPlayer(
                        trackTitle: activeTrack.title,
                        sourceTitle: activeTrack.source,
                        onExpand: () {
                          setState(() {
                            _isPlayerExpanded = true;
                          });
                        },
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(
                          navigationBarTheme: NavigationBarThemeData(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            indicatorColor: OstrackColors.gold.withValues(alpha: 0.16),
                            labelTextStyle: WidgetStateProperty.all(
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.transparent,
                                  ),
                            ),
                          ),
                        ),
                        child: NavigationBar(
                          selectedIndex: _currentIndex,
                          onDestinationSelected: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                          destinations: const [
                            NavigationDestination(
                              icon: Icon(Icons.home_outlined),
                              selectedIcon: Icon(Icons.home),
                              label: 'Home',
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.explore_outlined),
                              selectedIcon: Icon(Icons.explore),
                              label: 'Explore',
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.library_music_outlined),
                              selectedIcon: Icon(Icons.library_music),
                              label: 'Library',
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.person_outline),
                              selectedIcon: Icon(Icons.person),
                              label: 'Profile',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
