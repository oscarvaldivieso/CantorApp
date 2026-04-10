import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ─── Light Mode ───
  static const cream = Color(0xFFFAF7F2);
  static const warmWhite = Color(0xFFFFFDF9);
  static const goldDeep = Color(0xFFC8A951);
  static const goldLight = Color(0xFFDBC278);
  static const burgundy = Color(0xFF7A2D3C);
  static const textPrimary = Color(0xFF2C2418);
  static const textSecondary = Color(0xFF8A7E6B);
  static const surfaceElevated = Color(0xFFFFFFFF);

  // ─── Dark Mode ───
  static const darkBg = Color(0xFF1A1714);
  static const darkBgSecondary = Color(0xFF242019);
  static const goldLuminous = Color(0xFFD4AF37);
  static const roseAntique = Color(0xFFC77D8A);
  static const darkTextPrimary = Color(0xFFF5F0E8);
  static const darkTextSecondary = Color(0xFF9A8F7E);

  // ─── Liturgical Contextual Colors ───
  static const liturgyGreen = Color(0xFF4A7C59);
  static const liturgyPurple = Color(0xFF6B3FA0);
  static const liturgyRed = Color(0xFFB83232);
  static const liturgyBlue = Color(0xFF3A5A8C);
  static const liturgyGoldBright = Color(0xFFD4AF37);
  static const liturgyWhiteFestive = Color(0xFFFFF8E7);

  // ─── Semantic ───
  static const warning = Color(0xFFE6A817);
  static const error = Color(0xFFB83232);
  static const success = Color(0xFF4A7C59);

  // ─── Warm Shadow Color (not black) ───
  static const warmShadow = Color(0x1AB08D57);
  static const warmShadowDark = Color(0x33B08D57);

  // ─── Legacy aliases for migration ───
  static const gold = goldDeep;
  static const white = Color(0xFFFFFFFF);
  static const navyDeep = Color(0xFF1A2744);
  static const navyMid = Color(0xFF243360);
  static const creamDark = Color(0xFFF2EBE0);
  static const parchment = Color(0xFFEDE3D0);
  static const textDark = textPrimary;
  static const textMuted = textSecondary;

  // ─── Gradients ───
  static const goldGradient = LinearGradient(
    colors: [goldDeep, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const goldGradientShimmer = LinearGradient(
    colors: [goldDeep, goldLight, goldDeep],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const darkSurfaceGradient = LinearGradient(
    colors: [darkBg, darkBgSecondary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const creamGradient = LinearGradient(
    colors: [cream, warmWhite],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ─── Gold Glow (candle-light effect for dark mode) ───
  static List<BoxShadow> goldGlow({double opacity = 0.2, double blur = 16}) {
    return [
      BoxShadow(
        color: goldLuminous.withValues(alpha: opacity),
        blurRadius: blur,
        spreadRadius: 0,
      ),
    ];
  }

  // ─── Warm Elevation Shadow ───
  static List<BoxShadow> warmElevation({
    double blur = 20,
    double offset = 8,
    double opacity = 0.1,
  }) {
    return [
      BoxShadow(
        color: warmShadow.withValues(alpha: opacity),
        blurRadius: blur,
        offset: Offset(0, offset),
        spreadRadius: 0,
      ),
    ];
  }
}
