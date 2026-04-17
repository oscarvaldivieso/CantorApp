import 'package:flutter/material.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/liturgical_theme.dart';

/// Premium flowing glassmorphism vitral header that adapts to the liturgical
/// season. Uses organic gradients, soft light diffusion, and abstract
/// stained-glass inspired shapes with smooth visual continuity.
/// Integrates the liturgical pattern asset as a subtle immersive background.
class VitralHeader extends StatelessWidget {
  final String tiempo;
  final Widget child;

  const VitralHeader({
    super.key,
    required this.tiempo,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkBg : AppColors.cream;
    final palette = LiturgicalVisualPalette.forTiempo(tiempo, isDark);

    return RepaintBoundary(
      child: Stack(
        children: [
          // Layer 0: Base gradient painted background
          Positioned.fill(
            child: CustomPaint(
              painter: _VitralBaseGradientPainter(
                palette: palette,
                isDark: isDark,
              ),
            ),
          ),

          // Layer 1: Pattern asset image — subtle, blended overlay
          Positioned.fill(
            child: Opacity(
              opacity: isDark ? 0.08 : 0.12,
              child: Image.asset(
                palette.assetPath,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                color: palette.accentGlow.withValues(alpha: 0.5),
                colorBlendMode: BlendMode.overlay,
              ),
            ),
          ),

          // Layer 2: Glassmorphism effects on top of the image
          Positioned.fill(
            child: CustomPaint(
              painter: _VitralOverlayPainter(
                palette: palette,
                isDark: isDark,
                bgColor: bgColor,
              ),
            ),
          ),

          // Layer 3: Content
          child,
        ],
      ),
    );
  }
}

// ─── Base Gradient Painter (below image) ───

class _VitralBaseGradientPainter extends CustomPainter {
  final LiturgicalVisualPalette palette;
  final bool isDark;

  _VitralBaseGradientPainter({
    required this.palette,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Rich multi-stop base gradient
    final colors = palette.gradientColors;
    final paint = Paint()
      ..shader = LinearGradient(
        colors: colors,
        stops: const [0.0, 0.5, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    canvas.drawRect(rect, paint);

    // Organic flowing blobs for depth
    _drawBlob(
      canvas,
      center: Offset(size.width * 0.75, size.height * 0.2),
      radiusX: size.width * 0.55,
      radiusY: size.height * 0.4,
      rotation: 0.3,
      color: palette.glowColors[0],
    );
    _drawBlob(
      canvas,
      center: Offset(size.width * 0.15, size.height * 0.15),
      radiusX: size.width * 0.4,
      radiusY: size.height * 0.35,
      rotation: -0.5,
      color: palette.glowColors.length > 1
          ? palette.glowColors[1]
          : palette.glowColors[0],
    );
    _drawBlob(
      canvas,
      center: Offset(size.width * 0.45, size.height * 0.35),
      radiusX: size.width * 0.3,
      radiusY: size.height * 0.25,
      rotation: 0.8,
      color: palette.accentGlow.withValues(alpha: isDark ? 0.06 : 0.04),
    );
  }

  void _drawBlob(
    Canvas canvas, {
    required Offset center,
    required double radiusX,
    required double radiusY,
    required double rotation,
    required Color color,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);

    final rx = radiusX;
    final ry = radiusY;
    final path = Path()
      ..moveTo(0, -ry * 0.8)
      ..cubicTo(rx * 0.6, -ry * 0.9, rx * 0.9, -ry * 0.3, rx * 0.7, ry * 0.1)
      ..cubicTo(rx * 0.5, ry * 0.5, rx * 0.3, ry * 0.8, 0, ry * 0.7)
      ..cubicTo(-rx * 0.4, ry * 0.6, -rx * 0.8, ry * 0.3, -rx * 0.7, -ry * 0.1)
      ..cubicTo(-rx * 0.6, -ry * 0.5, -rx * 0.3, -ry * 0.7, 0, -ry * 0.8)
      ..close();

    final paint = Paint()
      ..color = color
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _VitralBaseGradientPainter old) =>
      old.palette.title != palette.title || old.isDark != isDark;
}

// ─── Overlay Painter (above image) — glassmorphism, light, fade ───

class _VitralOverlayPainter extends CustomPainter {
  final LiturgicalVisualPalette palette;
  final bool isDark;
  final Color bgColor;

  _VitralOverlayPainter({
    required this.palette,
    required this.isDark,
    required this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.save();
    canvas.clipRect(rect);

    _drawLightDiffusion(canvas, rect);
    _drawGlassPane(canvas, size);
    _drawSubtleLeadLines(canvas, size);
    _drawBottomFade(canvas, size);

    canvas.restore();
  }

  // Radial light diffusion — simulating light through glass + image
  void _drawLightDiffusion(Canvas canvas, Rect rect) {
    final primaryGlow = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.2, -0.6),
        radius: 1.2,
        colors: [
          palette.accentGlow.withValues(alpha: isDark ? 0.12 : 0.08),
          palette.accentGlow.withValues(alpha: isDark ? 0.04 : 0.03),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, primaryGlow);

    final warmGlow = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.4, -0.3),
        radius: 0.9,
        colors: [
          palette.accentGlow.withValues(alpha: isDark ? 0.06 : 0.04),
          Colors.transparent,
        ],
      ).createShader(rect);
    canvas.drawRect(rect, warmGlow);
  }

  // Frosted glass pane effect
  void _drawGlassPane(Canvas canvas, Size size) {
    final glassRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.06,
        size.height * 0.08,
        size.width * 0.88,
        size.height * 0.84,
      ),
      const Radius.circular(32),
    );

    final glassPaint = Paint()
      ..color = Colors.white.withValues(alpha: isDark ? 0.02 : 0.04)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);
    canvas.drawRRect(glassRect, glassPaint);

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = (isDark ? Colors.white : palette.accentGlow)
          .withValues(alpha: isDark ? 0.04 : 0.06);
    canvas.drawRRect(glassRect, borderPaint);
  }

  // Abstract lead lines
  void _drawSubtleLeadLines(Canvas canvas, Size size) {
    final lineColor = (isDark ? Colors.white : palette.accentGlow)
        .withValues(alpha: isDark ? 0.03 : 0.04);
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (int i = 0; i < 5; i++) {
      final startX = size.width * (0.1 + i * 0.22);
      final path = Path()
        ..moveTo(startX, 0)
        ..quadraticBezierTo(
          startX + size.width * 0.08,
          size.height * 0.5,
          startX - size.width * 0.05,
          size.height,
        );
      canvas.drawPath(path, paint);
    }

    for (int i = 0; i < 3; i++) {
      final y = size.height * (0.25 + i * 0.25);
      final path = Path()
        ..moveTo(0, y)
        ..cubicTo(
          size.width * 0.3, y - 15,
          size.width * 0.7, y + 15,
          size.width, y,
        );
      canvas.drawPath(path, paint);
    }
  }

  // Smooth bottom fade into page background
  void _drawBottomFade(Canvas canvas, Size size) {
    final fadeStart = size.height * 0.50;
    final fadeRect =
        Rect.fromLTWH(0, fadeStart, size.width, size.height - fadeStart);
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          bgColor.withValues(alpha: 0.0),
          bgColor.withValues(alpha: 0.5),
          bgColor,
        ],
        stops: const [0.0, 0.45, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(fadeRect);
    canvas.drawRect(fadeRect, paint);
  }

  @override
  bool shouldRepaint(covariant _VitralOverlayPainter old) =>
      old.palette.title != palette.title || old.isDark != isDark;
}
