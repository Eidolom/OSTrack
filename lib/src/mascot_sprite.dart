import 'package:flutter/material.dart';

class MascotSpriteView extends StatefulWidget {
  const MascotSpriteView({
    super.key,
    required this.mascotId,
    required this.color,
    required this.size,
    this.frameCount = 4,
    this.frameDurationMs = 260,
    this.isEquipped = false,
  });

  final String mascotId;
  final Color color;
  final double size;
  final int frameCount;
  final int frameDurationMs;
  final bool isEquipped;

  @override
  State<MascotSpriteView> createState() => _MascotSpriteViewState();
}

class _MascotSpriteViewState extends State<MascotSpriteView> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.frameDurationMs * widget.frameCount),
    )..repeat();
  }

  @override
  void didUpdateWidget(covariant MascotSpriteView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.frameCount != widget.frameCount || oldWidget.frameDurationMs != widget.frameDurationMs) {
      _controller
        ..duration = Duration(milliseconds: widget.frameDurationMs * widget.frameCount)
        ..repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final frameIndex = (widget.frameCount * _controller.value).floor() % widget.frameCount;

        return CustomPaint(
          size: Size.square(widget.size),
          painter: _MascotSpritePainter(
            mascotId: widget.mascotId,
            color: widget.color,
            frameIndex: frameIndex,
            isEquipped: widget.isEquipped,
          ),
        );
      },
    );
  }
}

class _MascotSpritePainter extends CustomPainter {
  const _MascotSpritePainter({
    required this.mascotId,
    required this.color,
    required this.frameIndex,
    required this.isEquipped,
  });

  final String mascotId;
  final Color color;
  final int frameIndex;
  final bool isEquipped;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final accentPaint = Paint()..color = Colors.white.withValues(alpha: 0.88);
    final outlinePaint = Paint()..color = color.withValues(alpha: 0.28);

    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(size.width * 0.2)),
      Paint()..color = color.withValues(alpha: 0.16),
    );

    final cell = size.width / 8;
    for (var i = 0; i < 8; i++) {
      _drawPixel(canvas, cell, i, 0, outlinePaint.color);
      _drawPixel(canvas, cell, i, 7, outlinePaint.color);
      _drawPixel(canvas, cell, 0, i, outlinePaint.color);
      _drawPixel(canvas, cell, 7, i, outlinePaint.color);
    }

    switch (mascotId) {
      case 'conductor-skeleton':
        _drawSkeleton(canvas, size, paint, accentPaint, frameIndex, isEquipped);
      case 'kitsune-archivist':
        _drawKitsune(canvas, size, paint, accentPaint, frameIndex, isEquipped);
      case 'cassette-ghost':
        _drawGhost(canvas, size, paint, accentPaint, frameIndex, isEquipped);
      case 'chibi-beethoven':
        _drawComposer(canvas, size, paint, accentPaint, frameIndex, isEquipped);
      case 'shrine-maiden':
        _drawMaiden(canvas, size, paint, accentPaint, frameIndex, isEquipped);
      case 'pixel-composer':
        _drawWorkshop(canvas, size, paint, accentPaint, frameIndex, isEquipped);
      case 'annoying-dog':
        _drawDog(canvas, size, paint, accentPaint, frameIndex, isEquipped);
      case 'community-echo':
        _drawEcho(canvas, size, paint, accentPaint, frameIndex, isEquipped);
      case 'founding-archivist':
        _drawArchivist(canvas, size, paint, accentPaint, frameIndex, isEquipped);
      default:
        _drawFallback(canvas, size, paint, accentPaint, frameIndex, isEquipped);
    }
  }

  void _drawPixel(Canvas canvas, double cell, int x, int y, Color fill) {
    canvas.drawRect(Rect.fromLTWH(x * cell, y * cell, cell, cell), Paint()..color = fill);
  }

  void _drawSkeleton(Canvas canvas, Size size, Paint paint, Paint accentPaint, int frameIndex, bool isEquipped) {
    final bounce = frameIndex.isEven ? 0.0 : 2.0;
    canvas.translate(0, bounce);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.25), size.width * 0.14, paint);
    canvas.drawCircle(Offset(size.width * 0.42, size.height * 0.24), size.width * 0.03, accentPaint);
    canvas.drawCircle(Offset(size.width * 0.58, size.height * 0.24), size.width * 0.03, accentPaint);
    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.36), Offset(size.width * 0.5, size.height * 0.64), Paint()..color = paint.color..strokeWidth = size.width * 0.08);
    canvas.drawLine(Offset(size.width * 0.35, size.height * 0.5), Offset(size.width * 0.22, size.height * 0.43), Paint()..color = paint.color..strokeWidth = size.width * 0.05);
    canvas.drawLine(Offset(size.width * 0.65, size.height * 0.5), Offset(size.width * 0.78, size.height * 0.43), Paint()..color = paint.color..strokeWidth = size.width * 0.05);
    canvas.drawLine(Offset(size.width * 0.44, size.height * 0.64), Offset(size.width * 0.34, size.height * 0.84), Paint()..color = paint.color..strokeWidth = size.width * 0.05);
    canvas.drawLine(Offset(size.width * 0.56, size.height * 0.64), Offset(size.width * 0.66, size.height * 0.84), Paint()..color = paint.color..strokeWidth = size.width * 0.05);
    if (isEquipped) {
      canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.22), size.width * 0.06, Paint()..color = Colors.white.withValues(alpha: 0.28));
    }
  }

  void _drawKitsune(Canvas canvas, Size size, Paint paint, Paint accentPaint, int frameIndex, bool isEquipped) {
    final tailLift = frameIndex.isEven ? -2.0 : 0.0;
    canvas.drawOval(Rect.fromLTWH(size.width * 0.22, size.height * 0.24, size.width * 0.56, size.height * 0.48), paint);
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.28, size.height * 0.28)
        ..lineTo(size.width * 0.16, size.height * 0.12)
        ..lineTo(size.width * 0.34, size.height * 0.2)
        ..close(),
      Paint()..color = paint.color.withValues(alpha: 0.72),
    );
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.72, size.height * 0.28 + tailLift)
        ..lineTo(size.width * 0.88, size.height * 0.14 + tailLift)
        ..lineTo(size.width * 0.76, size.height * 0.42 + tailLift)
        ..close(),
      Paint()..color = paint.color.withValues(alpha: 0.76),
    );
    canvas.drawRect(Rect.fromLTWH(size.width * 0.38, size.height * 0.48, size.width * 0.24, size.height * 0.2), accentPaint);
    if (isEquipped) {
      canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.62), size.width * 0.05, Paint()..color = Colors.white.withValues(alpha: 0.25));
    }
  }

  void _drawGhost(Canvas canvas, Size size, Paint paint, Paint accentPaint, int frameIndex, bool isEquipped) {
    final wobble = frameIndex.isEven ? -1.0 : 1.0;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.24, size.height * 0.2 + wobble, size.width * 0.52, size.height * 0.52), Radius.circular(size.width * 0.2)),
      paint,
    );
    canvas.drawCircle(Offset(size.width * 0.42, size.height * 0.38 + wobble), size.width * 0.04, accentPaint);
    canvas.drawCircle(Offset(size.width * 0.58, size.height * 0.38 + wobble), size.width * 0.04, accentPaint);
    for (var i = 0; i < 4; i++) {
      final x = size.width * (0.26 + i * 0.12);
      canvas.drawCircle(Offset(x, size.height * 0.74 + (i.isEven ? wobble : -wobble)), size.width * 0.06, paint);
    }
    if (isEquipped) {
      canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.16), size.width * 0.04, Paint()..color = Colors.white.withValues(alpha: 0.3));
    }
  }

  void _drawComposer(Canvas canvas, Size size, Paint paint, Paint accentPaint, int frameIndex, bool isEquipped) {
    final lift = frameIndex.isEven ? 0.0 : -1.5;
    canvas.drawOval(Rect.fromLTWH(size.width * 0.24, size.height * 0.22 + lift, size.width * 0.52, size.height * 0.56), paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.22 + lift), size.width * 0.18, Paint()..color = paint.color.withValues(alpha: 0.84));
    canvas.drawRect(Rect.fromLTWH(size.width * 0.38, size.height * 0.56, size.width * 0.24, size.height * 0.12), accentPaint);
    canvas.drawLine(Offset(size.width * 0.36, size.height * 0.62), Offset(size.width * 0.28, size.height * 0.8), Paint()..color = accentPaint.color..strokeWidth = size.width * 0.04);
    if (isEquipped) {
      canvas.drawCircle(Offset(size.width * 0.72, size.height * 0.18), size.width * 0.05, Paint()..color = Colors.white.withValues(alpha: 0.28));
    }
  }

  void _drawMaiden(Canvas canvas, Size size, Paint paint, Paint accentPaint, int frameIndex, bool isEquipped) {
    final sway = frameIndex.isEven ? -1.0 : 1.0;
    canvas.drawRect(Rect.fromLTWH(size.width * 0.34, size.height * 0.2, size.width * 0.32, size.height * 0.28), paint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.28, size.height * 0.38 + sway, size.width * 0.44, size.height * 0.36), Radius.circular(size.width * 0.08)), paint);
    canvas.drawLine(Offset(size.width * 0.24, size.height * 0.5), Offset(size.width * 0.18, size.height * 0.62), Paint()..color = paint.color..strokeWidth = size.width * 0.04);
    canvas.drawLine(Offset(size.width * 0.76, size.height * 0.5), Offset(size.width * 0.82, size.height * 0.62), Paint()..color = paint.color..strokeWidth = size.width * 0.04);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.28), size.width * 0.04, accentPaint);
    if (isEquipped) {
      canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.84), size.width * 0.04, Paint()..color = Colors.white.withValues(alpha: 0.2));
    }
  }

  void _drawWorkshop(Canvas canvas, Size size, Paint paint, Paint accentPaint, int frameIndex, bool isEquipped) {
    final lift = frameIndex.isEven ? -1.0 : 0.0;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.28, size.height * 0.24, size.width * 0.44, size.height * 0.48), Radius.circular(size.width * 0.1)), paint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.34, size.height * 0.16, size.width * 0.32, size.height * 0.12), accentPaint);
    canvas.drawLine(Offset(size.width * 0.34, size.height * 0.76 + lift), Offset(size.width * 0.18, size.height * 0.88 + lift), Paint()..color = paint.color..strokeWidth = size.width * 0.04);
    canvas.drawLine(Offset(size.width * 0.66, size.height * 0.76 + lift), Offset(size.width * 0.82, size.height * 0.88 + lift), Paint()..color = paint.color..strokeWidth = size.width * 0.04);
    if (isEquipped) {
      canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.28), size.width * 0.04, Paint()..color = Colors.white.withValues(alpha: 0.24));
    }
  }

  void _drawDog(Canvas canvas, Size size, Paint paint, Paint accentPaint, int frameIndex, bool isEquipped) {
    final jump = frameIndex.isEven ? -2.0 : 0.0;
    canvas.drawOval(Rect.fromLTWH(size.width * 0.24, size.height * 0.28 + jump, size.width * 0.52, size.height * 0.42), paint);
    canvas.drawCircle(Offset(size.width * 0.34, size.height * 0.36 + jump), size.width * 0.04, accentPaint);
    canvas.drawCircle(Offset(size.width * 0.58, size.height * 0.36 + jump), size.width * 0.04, accentPaint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.44, size.height * 0.54 + jump, size.width * 0.12, size.height * 0.12), accentPaint);
    if (isEquipped) {
      canvas.drawCircle(Offset(size.width * 0.74, size.height * 0.22), size.width * 0.05, Paint()..color = Colors.white.withValues(alpha: 0.26));
    }
  }

  void _drawEcho(Canvas canvas, Size size, Paint paint, Paint accentPaint, int frameIndex, bool isEquipped) {
    final wave = frameIndex.isEven ? 0.0 : 2.0;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.46), size.width * 0.14, paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.46), size.width * 0.07, accentPaint);
    canvas.drawLine(Offset(size.width * 0.18, size.height * 0.46 + wave), Offset(size.width * 0.34, size.height * 0.46 + wave), Paint()..color = paint.color.withValues(alpha: 0.72)..strokeWidth = size.width * 0.04);
    canvas.drawLine(Offset(size.width * 0.66, size.height * 0.46 - wave), Offset(size.width * 0.82, size.height * 0.46 - wave), Paint()..color = paint.color.withValues(alpha: 0.72)..strokeWidth = size.width * 0.04);
    if (isEquipped) {
      canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.72), size.width * 0.04, Paint()..color = Colors.white.withValues(alpha: 0.2));
    }
  }

  void _drawArchivist(Canvas canvas, Size size, Paint paint, Paint accentPaint, int frameIndex, bool isEquipped) {
    final shine = frameIndex.isEven ? 0.0 : 1.5;
    canvas.drawRect(Rect.fromLTWH(size.width * 0.28, size.height * 0.18, size.width * 0.44, size.height * 0.56), paint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.4, size.height * 0.08, size.width * 0.2, size.height * 0.16), accentPaint);
    canvas.drawCircle(Offset(size.width * 0.42, size.height * 0.44 + shine), size.width * 0.03, accentPaint);
    canvas.drawCircle(Offset(size.width * 0.58, size.height * 0.44 + shine), size.width * 0.03, accentPaint);
    canvas.drawLine(Offset(size.width * 0.38, size.height * 0.66), Offset(size.width * 0.62, size.height * 0.66), Paint()..color = accentPaint.color..strokeWidth = size.width * 0.04);
    if (isEquipped) {
      canvas.drawCircle(Offset(size.width * 0.76, size.height * 0.18), size.width * 0.05, Paint()..color = Colors.white.withValues(alpha: 0.28));
    }
  }

  void _drawFallback(Canvas canvas, Size size, Paint paint, Paint accentPaint, int frameIndex, bool isEquipped) {
    final bob = frameIndex.isEven ? -1.0 : 1.0;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5 + bob), size.width * 0.22, paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5 + bob), size.width * 0.08, accentPaint);
    if (isEquipped) {
      canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.22), size.width * 0.05, Paint()..color = Colors.white.withValues(alpha: 0.24));
    }
  }

  @override
  bool shouldRepaint(covariant _MascotSpritePainter oldDelegate) {
    return oldDelegate.mascotId != mascotId || oldDelegate.color != color || oldDelegate.frameIndex != frameIndex || oldDelegate.isEquipped != isEquipped;
  }
}
