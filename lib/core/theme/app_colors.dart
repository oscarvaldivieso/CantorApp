import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const navyDeep = Color(0xFF1A2744);
  static const navyMid = Color(0xFF243360);
  static const gold = Color(0xFFC9973A);
  static const goldLight = Color(0xFFE8B84B);
  static const cream = Color(0xFFFAF6EF);
  static const creamDark = Color(0xFFF2EBE0);
  static const parchment = Color(0xFFEDE3D0);
  static const liturgyRed = Color(0xFF8B2020);
  static const liturgyGreen = Color(0xFF1A5C3A);
  static const liturgyPurple = Color(0xFF4A1A6B);
  static const textDark = Color(0xFF1A1A2E);
  static const textMuted = Color(0xFF6B6B7A);
  static const white = Color(0xFFFFFFFF);
  static const whatsappGreen = Color(0xFF25D366);

  static const navyGradient = LinearGradient(
    colors: [navyDeep, navyMid],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const goldGradient = LinearGradient(
    colors: [gold, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
