import 'package:flutter/material.dart';

import 'ostrack_theme.dart';

class OstrackBackdrop extends StatelessWidget {
  const OstrackBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              OstrackColors.background,
              OstrackColors.backgroundAlt.withOpacity(0.95),
              OstrackColors.background,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -80,
              right: -40,
              child: _GlowOrb(
                color: OstrackColors.gold.withOpacity(0.22),
                size: 240,
              ),
            ),
            Positioned(
              top: 220,
              left: -60,
              child: _GlowOrb(
                color: OstrackColors.teal.withOpacity(0.16),
                size: 220,
              ),
            ),
            Positioned(
              bottom: 120,
              right: -30,
              child: _GlowOrb(
                color: OstrackColors.coral.withOpacity(0.12),
                size: 180,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withOpacity(0.0)],
        ),
      ),
    );
  }
}

class OstrackCard extends StatelessWidget {
  const OstrackCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.gradient,
    this.radius = 24,
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
        color: gradient == null ? OstrackColors.surface.withOpacity(0.94) : null,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.22),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
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
        color: accent.withOpacity(isActive ? 0.3 : 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: accent.withOpacity(isActive ? 0.85 : 0.45)),
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
