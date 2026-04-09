import 'package:flutter/material.dart';

import '../ostrack_catalog.dart';
import '../ostrack_shell.dart';
import '../ostrack_theme.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key, required this.catalog});

  final OstrackCatalog catalog;

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int _step = 0;
  final Set<String> _selectedWorlds = {
    'Video Games',
    'Anime',
    'Movies & TV',
    'K-Drama',
    'Composers',
  };
  String _selectedPlatform = 'Spotify';
  final Set<String> _followedUsers = {'yukirose', 'ostnerdd', 'melodyarchive'};

  void _nextStep() {
    if (_step < 4) {
      setState(() {
        _step += 1;
      });
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => OstrackShell(catalog: widget.catalog),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _SignUpStep(onContinue: _nextStep),
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
  const _SignUpStep({required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return _OnboardingStepFrame(
      eyebrow: 'Step 1',
      title: 'Create your account',
      subtitle: 'Choose a sign-in path. We keep the onboarding short and move straight into the worlds you care about.',
      body: Column(
        children: [
          const _AuthOption(label: 'Continue with Google', icon: Icons.g_mobiledata),
          const SizedBox(height: 12),
          const _AuthOption(label: 'Continue with Apple', icon: Icons.apple),
          const SizedBox(height: 12),
          const _AuthOption(label: 'Use email instead', icon: Icons.mail_outline),
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
    required this.onContinue,
  });

  final OstrackCatalog catalog;
  final Set<String> followedUsers;
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
  const _AuthOption({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Row(
        children: [
          Icon(icon, color: OstrackColors.gold),
          const SizedBox(width: 14),
          Text(label, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _SuggestionTile extends StatelessWidget {
  const _SuggestionTile({
    required this.name,
    required this.bio,
    required this.followed,
  });

  final String name;
  final String bio;
  final bool followed;

  @override
  Widget build(BuildContext context) {
    return OstrackCard(
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
