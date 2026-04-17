import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:cantor_app/core/theme/app_colors.dart';

/// Stained-glass (vitral) header that adapts to the current liturgical season.
/// Draws a diamond tessellation with lead lines, a radial glow, and a
/// season-specific decorative motif using [CustomPainter].
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

    return RepaintBoundary(
      child: CustomPaint(
        painter: _VitralPainter(
          scheme: _VitralScheme.fromTiempo(tiempo, isDark),
          isDark: isDark,
          bgColor: bgColor,
        ),
        child: child,
      ),
    );
  }
}

// ─── Season Motifs ───

enum _SeasonMotif { star, starBurst, cross, sunBurst, flame, roseWindow }

// ─── Color Scheme per Season ───

class _VitralScheme {
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color leadLine;
  final _SeasonMotif motif;

  const _VitralScheme({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.leadLine,
    required this.motif,
  });

  factory _VitralScheme.fromTiempo(String tiempo, bool isDark) {
    switch (tiempo) {
      case 'adviento':
        return _VitralScheme(
          primary: AppColors.liturgyPurple,
          secondary: const Color(0xFF3D2A6E),
          accent: AppColors.goldDeep,
          leadLine: isDark
              ? AppColors.goldDeep.withValues(alpha: 0.18)
              : AppColors.liturgyPurple.withValues(alpha: 0.14),
          motif: _SeasonMotif.star,
        );
      case 'navidad':
        return _VitralScheme(
          primary: AppColors.liturgyGoldBright,
          secondary: const Color(0xFFB8941C),
          accent: const Color(0xFFFFF8E7),
          leadLine: isDark
              ? const Color(0xFFFFFFFF).withValues(alpha: 0.15)
              : AppColors.liturgyGoldBright.withValues(alpha: 0.16),
          motif: _SeasonMotif.starBurst,
        );
      case 'cuaresma':
        return _VitralScheme(
          primary: const Color(0xFF5A3090),
          secondary: const Color(0xFF3A1A5E),
          accent: AppColors.goldDeep,
          leadLine: isDark
              ? AppColors.goldDeep.withValues(alpha: 0.14)
              : const Color(0xFF5A3090).withValues(alpha: 0.12),
          motif: _SeasonMotif.cross,
        );
      case 'semanaSanta':
        return _VitralScheme(
          primary: AppColors.liturgyRed,
          secondary: const Color(0xFF7A1A1A),
          accent: AppColors.goldDeep,
          leadLine: isDark
              ? AppColors.goldDeep.withValues(alpha: 0.14)
              : AppColors.liturgyRed.withValues(alpha: 0.12),
          motif: _SeasonMotif.cross,
        );
      case 'pascua':
        return _VitralScheme(
          primary: AppColors.liturgyGoldBright,
          secondary: const Color(0xFFE8C84A),
          accent: const Color(0xFFFFF8E7),
          leadLine: isDark
              ? const Color(0xFFFFFFFF).withValues(alpha: 0.15)
              : AppColors.liturgyGoldBright.withValues(alpha: 0.16),
          motif: _SeasonMotif.sunBurst,
        );
      case 'pentecostes':
        return _VitralScheme(
          primary: AppColors.liturgyRed,
          secondary: const Color(0xFFD45A00),
          accent: AppColors.goldDeep,
          leadLine: isDark
              ? AppColors.goldDeep.withValues(alpha: 0.16)
              : AppColors.liturgyRed.withValues(alpha: 0.12),
          motif: _SeasonMotif.flame,
        );
      default: // ordinario
        return _VitralScheme(
          primary: AppColors.liturgyGreen,
          secondary: const Color(0xFF2E5A3A),
          accent: AppColors.goldDeep,
          leadLine: isDark
              ? AppColors.goldDeep.withValues(alpha: 0.14)
              : AppColors.liturgyGreen.withValues(alpha: 0.12),
          motif: _SeasonMotif.roseWindow,
        );
    }
  }
}

// ─── Painter ───

class _VitralPainter extends CustomPainter {
  final _VitralScheme scheme;
  final bool isDark;
  final Color bgColor;

  _VitralPainter({
    required this.scheme,
    required this.isDark,
    required this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    canvas.save();
    canvas.clipRect(rect);

    _drawBase(canvas, rect);
    _drawPanes(canvas, size);
    _drawGlow(canvas, rect);
    _drawMotif(canvas, size);
    _drawBottomFade(canvas, size);
    _drawBottomArc(canvas, size);

    canvas.restore();
  }

  // 1. Rich base gradient
  void _drawBase(Canvas canvas, Rect rect) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          isDark
              ? scheme.primary.withValues(alpha: 0.22)
              : scheme.primary.withValues(alpha: 0.09),
          isDark
              ? scheme.secondary.withValues(alpha: 0.08)
              : scheme.secondary.withValues(alpha: 0.03),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect);
    canvas.drawRect(rect, paint);
  }

  // 2. Diamond tessellation with lead lines
  void _drawPanes(Canvas canvas, Size size) {
    final paneW = size.width / 8;
    final paneH = paneW * 1.35;
    final halfW = paneW * 0.5;
    final halfH = paneH * 0.5;

    final rows = (size.height / (paneH * 0.5)).ceil() + 2;
    const cols = 10;

    final lightX = size.width * 0.5;
    final lightY = size.height * 0.18;
    final maxDist = math.sqrt(0.25 + 0.64); // max possible normalized dist

    final fillPaint = Paint()..style = PaintingStyle.fill;
    final leadPaint = Paint()
      ..color = scheme.leadLine
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    for (int r = -1; r < rows; r++) {
      for (int c = -1; c < cols; c++) {
        final offsetX = r.isOdd ? halfW : 0.0;
        final cx = c * paneW + offsetX;
        final cy = r * halfH;

        // Distance from "light source" (top center), normalized
        final dx = (cx - lightX) / size.width;
        final dy = (cy - lightY) / size.height;
        final dist = math.sqrt(dx * dx + dy * dy);
        final normalDist = dist / maxDist;

        // Alternate primary/secondary for visual richness
        final usePrimary = (r + c) % 2 == 0;
        final baseColor = usePrimary ? scheme.primary : scheme.secondary;

        // Warm tint near the glow center
        final glowInfluence = math.max(0.0, 1.0 - normalDist * 2.2);
        final paneColor = Color.lerp(
          baseColor,
          scheme.accent,
          glowInfluence * 0.25,
        )!;

        // Opacity: brighter near center, dimmer toward edges
        final baseAlpha = isDark ? 0.16 : 0.09;
        final alpha =
            (baseAlpha + glowInfluence * 0.08 - normalDist * 0.05)
                .clamp(0.015, 0.24);

        final path = Path()
          ..moveTo(cx, cy - halfH)
          ..lineTo(cx + halfW, cy)
          ..lineTo(cx, cy + halfH)
          ..lineTo(cx - halfW, cy)
          ..close();

        fillPaint.color = paneColor.withValues(alpha: alpha);
        canvas.drawPath(path, fillPaint);
        canvas.drawPath(path, leadPaint);
      }
    }
  }

  // 3. Radial glow — light shining through the glass
  void _drawGlow(Canvas canvas, Rect rect) {
    final paint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.0, -0.75),
        radius: 1.1,
        colors: [
          scheme.accent.withValues(alpha: isDark ? 0.14 : 0.09),
          scheme.primary.withValues(alpha: isDark ? 0.06 : 0.04),
          Colors.transparent,
        ],
        stops: const [0.0, 0.35, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, paint);
  }

  // 4. Season-specific decorative motif (subtle, centered near top)
  void _drawMotif(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.24);
    final motifR = size.width * 0.07;
    final paint = Paint()
      ..color = scheme.accent.withValues(alpha: isDark ? 0.18 : 0.11)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    switch (scheme.motif) {
      case _SeasonMotif.cross:
        canvas.drawLine(
          Offset(center.dx, center.dy - motifR),
          Offset(center.dx, center.dy + motifR),
          paint,
        );
        canvas.drawLine(
          Offset(center.dx - motifR * 0.65, center.dy - motifR * 0.2),
          Offset(center.dx + motifR * 0.65, center.dy - motifR * 0.2),
          paint,
        );

      case _SeasonMotif.star:
        _drawStar(canvas, center, motifR, 5, paint);

      case _SeasonMotif.starBurst:
        _drawStar(canvas, center, motifR, 8, paint);

      case _SeasonMotif.sunBurst:
        for (int i = 0; i < 12; i++) {
          final angle = i * math.pi / 6;
          canvas.drawLine(
            Offset(
              center.dx + motifR * 0.38 * math.cos(angle),
              center.dy + motifR * 0.38 * math.sin(angle),
            ),
            Offset(
              center.dx + motifR * math.cos(angle),
              center.dy + motifR * math.sin(angle),
            ),
            paint,
          );
        }
        canvas.drawCircle(center, motifR * 0.28, paint);

      case _SeasonMotif.flame:
        final outer = Path()
          ..moveTo(center.dx, center.dy - motifR)
          ..quadraticBezierTo(
            center.dx + motifR * 0.55,
            center.dy - motifR * 0.2,
            center.dx,
            center.dy + motifR * 0.55,
          )
          ..quadraticBezierTo(
            center.dx - motifR * 0.55,
            center.dy - motifR * 0.2,
            center.dx,
            center.dy - motifR,
          );
        canvas.drawPath(outer, paint);
        final inner = Path()
          ..moveTo(center.dx, center.dy - motifR * 0.5)
          ..quadraticBezierTo(
            center.dx + motifR * 0.28,
            center.dy,
            center.dx,
            center.dy + motifR * 0.22,
          )
          ..quadraticBezierTo(
            center.dx - motifR * 0.28,
            center.dy,
            center.dx,
            center.dy - motifR * 0.5,
          );
        canvas.drawPath(inner, paint);

      case _SeasonMotif.roseWindow:
        canvas.drawCircle(center, motifR, paint);
        canvas.drawLine(
          Offset(center.dx - motifR * 0.7, center.dy),
          Offset(center.dx + motifR * 0.7, center.dy),
          paint,
        );
        canvas.drawLine(
          Offset(center.dx, center.dy - motifR * 0.7),
          Offset(center.dx, center.dy + motifR * 0.7),
          paint,
        );
    }
  }

  void _drawStar(
      Canvas canvas, Offset center, double radius, int points, Paint paint) {
    final path = Path();
    final inner = radius * 0.4;
    for (int i = 0; i < points * 2; i++) {
      final angle = i * math.pi / points - math.pi / 2;
      final r = i.isEven ? radius : inner;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  // 5. Bottom gradient fade into the page background
  void _drawBottomFade(Canvas canvas, Size size) {
    final fadeStart = size.height * 0.65;
    final fadeRect = Rect.fromLTWH(0, fadeStart, size.width, size.height - fadeStart);
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          bgColor.withValues(alpha: 0.0),
          bgColor,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(fadeRect);
    canvas.drawRect(fadeRect, paint);
  }

  // 6. Subtle golden arc at the bottom transition
  void _drawBottomArc(Canvas canvas, Size size) {
    final y = size.height * 0.88;
    final path = Path()
      ..moveTo(0, y)
      ..quadraticBezierTo(size.width * 0.5, y + 14, size.width, y);
    canvas.drawPath(
      path,
      Paint()
        ..color = scheme.accent.withValues(alpha: isDark ? 0.16 : 0.10)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8,
    );
  }

  @override
  bool shouldRepaint(covariant _VitralPainter oldDelegate) {
    return oldDelegate.scheme.primary != scheme.primary ||
        oldDelegate.isDark != isDark;
  }
}
