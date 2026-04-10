import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_providers.dart';
import '../backend/scene_tag_moderation_repository.dart';
import '../ostrack_theme.dart';
import '../ostrack_widgets.dart';

class SceneTagModerationScreen extends ConsumerStatefulWidget {
  const SceneTagModerationScreen({super.key});

  @override
  ConsumerState<SceneTagModerationScreen> createState() => _SceneTagModerationScreenState();
}

class _SceneTagModerationScreenState extends ConsumerState<SceneTagModerationScreen> {
  late Future<List<ModerationQueueEntry>> _queueFuture;

  @override
  void initState() {
    super.initState();
    _queueFuture = _loadQueue();
  }

  Future<List<ModerationQueueEntry>> _loadQueue() {
    return ref.read(sceneTagModerationRepositoryProvider).fetchModerationQueue();
  }

  Future<void> _refreshQueue() async {
    final next = _loadQueue();
    setState(() {
      _queueFuture = next;
    });
    await next;
  }

  Future<void> _setHiddenState(ModerationQueueEntry entry, bool isHidden) async {
    await ref.read(sceneTagModerationRepositoryProvider).setTagHiddenState(
          tagId: entry.tagId,
          isHidden: isHidden,
        );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isHidden
              ? 'Tag hidden and queued for review.'
              : 'Tag restored for community visibility.',
        ),
      ),
    );

    await _refreshQueue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const OstrackBackdrop(),
          SafeArea(
            child: Column(
              children: [
                ListTile(
                  leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  title: Text(
                    'Scene Tag Moderation',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: const Text('Review flagged tags and restore or hide entries.'),
                  trailing: IconButton(
                    onPressed: _refreshQueue,
                    icon: const Icon(Icons.refresh),
                    tooltip: 'Refresh moderation queue',
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<ModerationQueueEntry>>(
                    future: _queueFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: OstrackCard(
                            child: Text('Could not load moderation queue: ${snapshot.error}'),
                          ),
                        );
                      }

                      final queue = snapshot.data ?? const <ModerationQueueEntry>[];
                      if (queue.isEmpty) {
                        return const Center(
                          child: OstrackCard(
                            child: Text('No flagged scene tags in the moderation queue.'),
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                        itemCount: queue.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final entry = queue[index];
                          final isOverThreshold = ref
                              .read(sceneTagModerationRepositoryProvider)
                              .shouldAutoHide(entry.reportCount);

                          return OstrackCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        entry.sourceTitle?.isNotEmpty == true
                                            ? entry.sourceTitle!
                                            : 'Unknown source',
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: entry.isHidden
                                            ? OstrackColors.coral.withValues(alpha: 0.2)
                                            : OstrackColors.teal.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(999),
                                      ),
                                      child: Text(
                                        entry.isHidden ? 'Hidden' : 'Visible',
                                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                              color: entry.isHidden ? OstrackColors.coral : OstrackColors.teal,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tag ID: ${entry.tagId}',
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Reports: ${entry.reportCount}${isOverThreshold ? ' (auto-hide threshold reached)' : ''}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                if (entry.lastReportedAt != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    'Last report: ${entry.lastReportedAt}',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    OutlinedButton.icon(
                                      onPressed: entry.isHidden
                                          ? () => _setHiddenState(entry, false)
                                          : null,
                                      icon: const Icon(Icons.visibility_outlined),
                                      label: const Text('Restore'),
                                    ),
                                    const SizedBox(width: 10),
                                    FilledButton.icon(
                                      onPressed: entry.isHidden
                                          ? null
                                          : () => _setHiddenState(entry, true),
                                      icon: const Icon(Icons.visibility_off_outlined),
                                      label: const Text('Hide'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
