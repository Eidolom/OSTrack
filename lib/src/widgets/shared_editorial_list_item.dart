import 'package:flutter/material.dart';

import '../ostrack_theme.dart';

class SharedEditorialListItem extends StatelessWidget {
  const SharedEditorialListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  String get _username {
    final match = RegExp(r'^(@\w+)').firstMatch(title);
    return match?.group(1) ?? '@listener';
  }

  String get _activityLabel {
    if (title.contains('reviewed')) {
      return 'RATING';
    }
    if (title.contains('tagged')) {
      return 'SCENE TAG';
    }
    return 'SHELF ACTIVITY';
  }

  String get _activityText {
    final prefix = '$_username ';
    if (title.startsWith(prefix)) {
      return title.substring(prefix.length);
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [accent.withValues(alpha: 0.35), OstrackColors.surfaceAlt],
              ),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: Colors.white.withValues(alpha: 0.9), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _activityText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$_username · $subtitle · $_activityLabel',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(Icons.more_vert, color: Colors.white.withValues(alpha: 0.3), size: 20),
        ],
      ),
    );
  }
}
