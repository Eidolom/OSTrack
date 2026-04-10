import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_providers.dart';
import '../mascot_monetization.dart';
import '../mascot_sprite.dart';
import '../ostrack_theme.dart';

class UserAvatarWithMascot extends ConsumerWidget {
  const UserAvatarWithMascot({
    super.key,
    this.avatarRadius = 24.0,
    this.profileImageUrl,
  });

  final double avatarRadius;
  final String? profileImageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogAsync = ref.watch(mascotCatalogViewProvider);

    return catalogAsync.maybeWhen(
      data: (catalogView) {
        final equippedId = catalogView.equippedMascotId;
        MascotEntry? equippedMascot;
        for (final mascot in catalogView.mascots) {
          if (mascot.id == equippedId) {
            equippedMascot = mascot;
            break;
          }
        }

        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: equippedMascot != null
                      ? OstrackColors.gold.withValues(alpha: 0.5)
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.grey.shade800,
                backgroundImage: profileImageUrl != null && profileImageUrl!.isNotEmpty
                    ? NetworkImage(profileImageUrl!)
                    : null,
                child: profileImageUrl == null || profileImageUrl!.isEmpty
                    ? Icon(
                        Icons.person,
                        color: Colors.white70,
                        size: avatarRadius,
                      )
                    : null,
              ),
            ),
            if (equippedMascot != null)
              Positioned(
                bottom: -6,
                right: -10,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.6),
                        blurRadius: 8,
                        spreadRadius: -2,
                      ),
                    ],
                  ),
                  child: MascotSpriteView(
                    mascotId: equippedMascot.id,
                    color: equippedMascot.assetColor,
                    size: avatarRadius * 1.35,
                    frameCount: equippedMascot.frameCount,
                    frameDurationMs: equippedMascot.frameDurationMs,
                    isEquipped: true,
                  ),
                ),
              ),
          ],
        );
      },
      orElse: () => CircleAvatar(
        radius: avatarRadius,
        backgroundColor: Colors.grey.shade800,
        child: Icon(
          Icons.person,
          color: Colors.white70,
          size: avatarRadius,
        ),
      ),
    );
  }
}
