import 'package:flutter/material.dart';

import '../app_preferences.dart';
import '../mascot_monetization.dart';
import '../ostrack_theme.dart';
import '../ostrack_widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.preferences,
    required this.onPreferencesChanged,
    required this.mascotCatalog,
  });

  final AppPreferences preferences;
  final PreferencesUpdater onPreferencesChanged;
  final OstrackMascotCatalog mascotCatalog;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _selectedPlatform;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedPlatform = widget.preferences.selectedPlatform;
  }

  Future<void> _savePlatform() async {
    setState(() {
      _isSaving = true;
    });

    await widget.onPreferencesChanged(
      widget.preferences.copyWith(selectedPlatform: _selectedPlatform),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isSaving = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Platform preference saved.')),
    );
  }

  Future<void> _restartOnboarding() async {
    setState(() {
      _isSaving = true;
    });

    await widget.onPreferencesChanged(
      widget.preferences.copyWith(onboardingCompleted: false),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isSaving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const platforms = ['Spotify', 'Apple Music', 'YouTube Music'];

    return Scaffold(
      body: Stack(
        children: [
          const OstrackBackdrop(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 6),
                      Text('Settings', style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                  const SizedBox(height: 20),
                  OstrackCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Linked platform', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Text(
                          'Update which service receives playback handoff.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: platforms
                              .map(
                                (platform) => ChoiceChip(
                                  label: Text(platform),
                                  selected: _selectedPlatform == platform,
                                  onSelected: (_) {
                                    setState(() {
                                      _selectedPlatform = platform;
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                        FilledButton.icon(
                          onPressed: _isSaving ? null : _savePlatform,
                          icon: _isSaving
                              ? const SizedBox.square(
                                  dimension: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.save_outlined),
                          label: const Text('Save platform'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  OstrackCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Collection', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Text(
                          'Manage your mascot cabinet and open the store from the account area.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20),
                        OutlinedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => MascotStorePage(
                                  catalog: widget.mascotCatalog.viewFor(widget.preferences),
                                  preferences: widget.preferences,
                                  onPreferencesChanged: widget.onPreferencesChanged,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.storefront_outlined),
                          label: const Text('Open mascot store'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  OstrackCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Onboarding', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Text(
                          'Run onboarding again to refresh your world selections and follows.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20),
                        OutlinedButton.icon(
                          onPressed: _isSaving ? null : _restartOnboarding,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Restart onboarding'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: OstrackColors.gold,
                            side: const BorderSide(color: OstrackColors.gold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
