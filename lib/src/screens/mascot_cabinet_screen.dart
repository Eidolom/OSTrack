import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_providers.dart';

import '../mascot_monetization.dart';
import '../mascot_sprite.dart';
import '../ostrack_theme.dart';

/// Full-screen cabinet for managing owned mascots.
/// Displays a 4-column sliver grid with three states: equipped (animated + gold border),
/// owned (static, no animation), and locked (50% black with ? icon).
class MascotCabinetScreen extends ConsumerWidget {
  const MascotCabinetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogAsync = ref.watch(mascotCatalogViewProvider);

    return catalogAsync.when(
      loading: () => const Scaffold(
        backgroundColor: OstrackColors.background,
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        backgroundColor: OstrackColors.background,
        body: Center(
          child: Text('Error loading cabinet: $e'),
        ),
      ),
      data: (catalogView) {
        final fullCatalog = catalogView.mascots;
        final ownedIds = catalogView.ownedMascotIds;
        final equippedId = catalogView.equippedMascotId;

        return Scaffold(
          backgroundColor: OstrackColors.background,
          body: CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'COLLECTION',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          letterSpacing: 2.0,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        '${ownedIds.length} OWNED',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: OstrackColors.gold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 4-Column Grid
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.85, // Taller than wide to fit names
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final mascot = fullCatalog[index];
                      final isOwned = ownedIds.contains(mascot.id);
                      final isEquipped = equippedId == mascot.id;

                      return _MascotGridItem(
                        mascot: mascot,
                        isOwned: isOwned,
                        isEquipped: isEquipped,
                        onTap: () {
                          if (isOwned && !isEquipped) {
                            // Trigger Equip Action
                            ref.read(mascotControllerProvider).equipMascot(mascot.id);
                          } else if (!isOwned) {
                            // TODO: Open Store / Purchase Modal
                            _showStoreModal(context, ref, mascot);
                          }
                        },
                      );
                    },
                    childCount: fullCatalog.length,
                  ),
                ),
              ),

              // Bottom padding
              const SliverToBoxAdapter(
                child: SizedBox(height: 40),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showStoreModal(BuildContext context, WidgetRef ref, MascotEntry mascot) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => Container(
        height: 230,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              mascot.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              'Available in the mascot store',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await ref.read(mascotControllerProvider).purchaseMascot(mascot.id);
                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${mascot.name} added to your collection.')),
                  );
                }
              },
              child: Text('Add to Collection · ${mascot.priceLabel}'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual grid item displaying a mascot with three states:
/// - Equipped: Full color + animated + gold border glow
/// - Owned: Full color + static + standard border
/// - Locked: Black silhouette 40% opacity + locked icon
class _MascotGridItem extends StatelessWidget {
  final MascotEntry mascot;
  final bool isOwned;
  final bool isEquipped;
  final VoidCallback onTap;

  const _MascotGridItem({
    required this.mascot,
    required this.isOwned,
    required this.isEquipped,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isEquipped
                      ? OstrackColors.gold
                      : Colors.white.withValues(alpha: 0.1),
                  width: isEquipped ? 2 : 1,
                ),
                boxShadow: isEquipped
                    ? [
                        BoxShadow(
                          color: OstrackColors.gold.withValues(alpha: 0.2),
                          blurRadius: 10,
                        )
                      ]
                    : null,
              ),
              child: Center(
                // THE SILHOUETTE MAGIC: Black out locked mascots, full color for owned
                child: ColorFiltered(
                  colorFilter: isOwned
                      ? const ColorFilter.mode(
                          Colors.transparent,
                          BlendMode.multiply,
                        ) // No filter for owned / equipped
                      : const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ), // Pure black silhouette for locked
                  child: Opacity(
                    opacity: isOwned ? 1.0 : 0.4,
                    child: MascotSpriteView(
                      mascotId: mascot.id,
                      color: mascot.assetColor,
                      size: 80,
                      frameCount: mascot.frameCount,
                      frameDurationMs: mascot.frameDurationMs,
                      isEquipped: isEquipped,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isOwned ? mascot.name : '?',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isOwned ? Colors.white : Colors.white38,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
