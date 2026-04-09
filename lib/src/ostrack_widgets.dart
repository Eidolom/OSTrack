import 'package:flutter/material.dart';

import 'ostrack_theme.dart';

class OstrackBackdrop extends StatelessWidget {
  const OstrackBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: OstrackColors.background,
        ),
      ),
    );
  }
}

class OstrackCard extends StatelessWidget {
  const OstrackCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.gradient,
    this.radius = 20,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Gradient? gradient;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null ? OstrackColors.surface : null,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: child,
    );
  }
}

class OstrackPill extends StatelessWidget {
  const OstrackPill({
    super.key,
    required this.label,
    this.icon,
    this.color,
    this.isActive = false,
  });

  final String label;
  final IconData? icon;
  final Color? color;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final accent = color ?? OstrackColors.teal;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: isActive ? 0.3 : 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: accent.withValues(alpha: isActive ? 0.85 : 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: accent),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: OstrackColors.textHigh,
                ),
          ),
        ],
      ),
    );
  }
}
