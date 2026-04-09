import 'package:flutter/material.dart';

import '../app_preferences.dart';
import '../auth/auth_service.dart';
import '../ostrack_catalog.dart';
import '../ostrack_shell.dart';
import '../ostrack_theme.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({
    super.key,
    required this.catalog,
    required this.initialPreferences,
    required this.authService,
    required this.onComplete,
  });

  final OstrackCatalog catalog;
  final AppPreferences initialPreferences;
  final AuthService authService;
  final ValueChanged<AppPreferences> onComplete;

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int _step = 0;
  late final Set<String> _selectedWorlds;
  late String _selectedPlatform;
  late final Set<String> _followedUsers;
  AuthProvider _selectedAuthProvider = AuthProvider.google;
  bool _isAuthenticating = false;
  String? _signedInIdentity;

  @override
  void initState() {
    super.initState();
    _selectedWorlds = widget.initialPreferences.selectedWorlds.toSet();
    _selectedPlatform = widget.initialPreferences.selectedPlatform;
    _followedUsers = widget.initialPreferences.followedUsers.toSet();
  }

  void _nextStep() {
    if (_step < 4) {
      setState(() {
        _step += 1;
      });
      return;
    }

    widget.onComplete(
      widget.initialPreferences.copyWith(
        onboardingCompleted: true,
        selectedPlatform: _selectedPlatform,
        selectedWorlds: _selectedWorlds.toList(),
        followedUsers: _followedUsers.toList(),
      ),
    );
  }

  Future<void> _handleSignInContinue() async {
    setState(() {
      _isAuthenticating = true;
    });

    final messenger = ScaffoldMessenger.of(context);

    try {
      final session = await widget.authService.signIn(_selectedAuthProvider);
      if (!mounted) {
        return;
      }

      setState(() {
        _signedInIdentity = session.email ?? session.displayName;
      });
    } on AuthFailure catch (failure) {
      if (!mounted) {
        return;
      }

      messenger.showSnackBar(
        SnackBar(content: Text(failure.message)),
      );
      return;
    } finally {
      if (mounted) {
        setState(() {
          _isAuthenticating = false;
        });
      }
    }

    if (!mounted) {
      return;
    }

    _nextStep();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _SignUpStep(
        selectedProvider: _selectedAuthProvider,
        isLoading: _isAuthenticating,
        signedInIdentity: _signedInIdentity,
        onSelectProvider: (provider) {
          setState(() {
            _selectedAuthProvider = provider;
          });
        },
        onContinue: _handleSignInContinue,
      ),
      _WorldSelectionStep(
        catalog: widget.catalog,
        selectedWorlds: _selectedWorlds,
        onToggleWorld: (label) {
          setState(() {
            if (_selectedWorlds.contains(label)) {
              _selectedWorlds.remove(label);
            } else {
              _selectedWorlds.add(label);
            }
          });
        },
        onContinue: _nextStep,
      ),
      _PlatformStep(
        selectedPlatform: _selectedPlatform,
        onSelectPlatform: (platform) {
          setState(() {
            _selectedPlatform = platform;
          });
        },
        onContinue: _nextStep,
      ),
      _FollowStep(
        catalog: widget.catalog,
        followedUsers: _followedUsers,
        onToggleFollow: (name) {
          setState(() {
            if (_followedUsers.contains(name)) {
              _followedUsers.remove(name);
            } else {
              _followedUsers.add(name);
            }
          });
        },
        onContinue: _nextStep,
      ),
      _HomePreviewStep(
        catalog: widget.catalog,
        selectedPlatform: _selectedPlatform,
        onEnterApp: _nextStep,
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          const OstrackBackdrop(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('OSTrack'),
                      TextButton(
                        onPressed: _nextStep,
                        child: const Text('Skip'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: (_step + 1) / pages.length,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: KeyedSubtree(
                        key: ValueKey<int>(_step),
                        child: pages[_step],
                      ),
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

class _SignUpStep extends StatelessWidget {
  const _SignUpStep({
    required this.selectedProvider,
    required this.isLoading,
    required this.signedInIdentity,
    required this.onSelectProvider,
    required this.onContinue,
  });

  final AuthProvider selectedProvider;
  final bool isLoading;
  final String? signedInIdentity;
  final ValueChanged<AuthProvider> onSelectProvider;
  final Future<void> Function() onContinue;

  @override
  Widget build(BuildContext context) {
    return _OnboardingStepFrame(
      eyebrow: 'Step 1',
      title: 'Create your account',
      subtitle: 'Choose a sign-in path. We keep the onboarding short and move straight into the worlds you care about.',
      body: Column(
        children: [
          _AuthOption(
            label: 'Continue with Google (Auth0)',
            icon: Icons.g_mobiledata,
            selected: selectedProvider == AuthProvider.google,
            onTap: () => onSelectProvider(AuthProvider.google),
          ),
          const SizedBox(height: 12),
          _AuthOption(
            label: 'Continue with Apple (Auth0)',
            icon: Icons.apple,
            selected: selectedProvider == AuthProvider.apple,
            onTap: () => onSelectProvider(AuthProvider.apple),
          ),
          if (signedInIdentity != null) ...[
            const SizedBox(height: 14),
            Text(
              'Signed in as $signedInIdentity',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: OstrackColors.teal,
                  ),
            ),
          ],
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: isLoading ? null : onContinue,
            icon: isLoading
                ? const SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.login),
            label: Text(isLoading ? 'Signing in...' : 'Continue'),
          ),
          const SizedBox(height: 10),
          Text(
            'Single auth path: Auth0 Universal Login',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _WorldSelectionStep extends StatelessWidget {
  const _WorldSelectionStep({
    required this.catalog,
    required this.selectedWorlds,
    required this.onToggleWorld,
    required this.onContinue,
  });

  final OstrackCatalog catalog;
  final Set<String> selectedWorlds;
  final ValueChanged<String> onToggleWorld;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final categories = catalog.categories;

    return _OnboardingStepFrame(
      eyebrow: 'Step 2',
      title: 'Pick your worlds',
      subtitle: 'Select at least 5 soundtracks you love. These selections seed your initial feed and discovery surface.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: categories
                .map(
                  (category) => FilterChip(
                    label: Text(category.label),
                    selected: selectedWorlds.contains(category.label),
                    selectedColor: category.accent.withOpacity(0.22),
                    onSelected: (_) => onToggleWorld(category.label),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Text('${selectedWorlds.length} worlds selected'),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: selectedWorlds.length >= 5 ? onContinue : null,
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}

class _PlatformStep extends StatelessWidget {
  const _PlatformStep({
    required this.selectedPlatform,
    required this.onSelectPlatform,
    required this.onContinue,
  });

  final String selectedPlatform;
  final ValueChanged<String> onSelectPlatform;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    const platforms = ['Spotify', 'Apple Music', 'YouTube Music'];

    return _OnboardingStepFrame(
      eyebrow: 'Step 3',
      title: 'Link your platform',
      subtitle: 'Pick one streaming service for playback handoff. You can change this later in Settings.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: platforms
                .map(
                  (platform) => ChoiceChip(
                    label: Text(platform),
                    selected: selectedPlatform == platform,
                    onSelected: (_) => onSelectPlatform(platform),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: onContinue,
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}

class _FollowStep extends StatelessWidget {
  const _FollowStep({
    required this.catalog,
    required this.followedUsers,
    required this.onToggleFollow,
    required this.onContinue,
  });

  final OstrackCatalog catalog;
  final Set<String> followedUsers;
  final ValueChanged<String> onToggleFollow;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final suggestions = catalog.recommendations;

    return _OnboardingStepFrame(
      eyebrow: 'Step 4',
      title: 'Follow a few people',
      subtitle: 'Pre-seeded suggestions give your feed an immediate pulse instead of an empty timeline.',
      body: Column(
        children: [
          for (final suggestion in suggestions) ...[
            _SuggestionTile(
              name: suggestion.title,
              bio: suggestion.subtitle,
              followed: followedUsers.contains(suggestion.title),
              onTap: () => onToggleFollow(suggestion.title),
            ),
            if (suggestion != suggestions.last) const SizedBox(height: 12),
          ],
          const SizedBox(height: 24),
          FilledButton(
            onPressed: onContinue,
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}

class _HomePreviewStep extends StatelessWidget {
  const _HomePreviewStep({
    required this.catalog,
    required this.selectedPlatform,
    required this.onEnterApp,
  });

  final OstrackCatalog catalog;
  final String selectedPlatform;
  final VoidCallback onEnterApp;

  @override
  Widget build(BuildContext context) {
    final feed = catalog.homeFeed;

    return _OnboardingStepFrame(
      eyebrow: 'Step 5',
      title: 'Your home feed is ready',
      subtitle: 'This is the first view after onboarding: seeded, social, and tied to the platform you linked.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OstrackCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Linked platform', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                Text(selectedPlatform, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (final item in feed) ...[
            _FeedStoryCard(
              icon: item.icon,
              title: item.title,
              subtitle: item.subtitle,
              accent: item.accent,
            ),
            if (item != feed.last) const SizedBox(height: 12),
          ],
          const SizedBox(height: 24),
          FilledButton(
            onPressed: onEnterApp,
            child: const Text('Enter OSTrack'),
          ),
        ],
      ),
    );
  }
}

class _OnboardingStepFrame extends StatelessWidget {
  const _OnboardingStepFrame({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.body,
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(eyebrow.toUpperCase(), style: Theme.of(context).textTheme.labelLarge?.copyWith(color: OstrackColors.teal)),
          const SizedBox(height: 8),
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 10),
          Text(subtitle, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 24),
          body,
        ],
      ),
    );
  }
}

class _AuthOption extends StatelessWidget {
  const _AuthOption({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: OstrackCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        gradient: selected
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  OstrackColors.teal.withOpacity(0.24),
                  OstrackColors.surface.withOpacity(0.95),
                ],
              )
            : null,
        child: Row(
          children: [
            Icon(icon, color: selected ? OstrackColors.teal : OstrackColors.gold),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label, style: Theme.of(context).textTheme.titleMedium),
            ),
            Icon(
              selected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: selected ? OstrackColors.teal : OstrackColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestionTile extends StatelessWidget {
  const _SuggestionTile({
    required this.name,
    required this.bio,
    required this.followed,
    required this.onTap,
  });

  final String name;
  final String bio;
  final bool followed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: OstrackCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 22,
              backgroundColor: OstrackColors.teal,
              child: Icon(Icons.person, color: Colors.black),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(bio, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            Icon(
              followed ? Icons.check_circle : Icons.add_circle_outline,
              color: followed ? OstrackColors.teal : OstrackColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedStoryCard extends StatelessWidget {
  const _FeedStoryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
