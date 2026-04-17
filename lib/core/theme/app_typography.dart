import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  // ─── Serif (Headlines, Titles) ───
  static TextStyle serif({
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
    double? height,
    double? letterSpacing,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.cormorantGaramond(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.textPrimary,
      height: height,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
    );
  }

  // ─── Sans (Body, UI) ───
  static TextStyle sans({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    double? height,
    double? letterSpacing,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.textPrimary,
      height: height,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
    );
  }

  // ─── Mono (Chords) ───
  static TextStyle mono({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w700,
    Color? color,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.goldDeep,
    );
  }

  // ─── Pre-built Styles ───
  static TextStyle get display => serif(
        fontSize: 34,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get h1 => serif(
        fontSize: 26,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get h2 => sans(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
      );

  static TextStyle get sectionLabel => sans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
        color: AppColors.textSecondary,
      );

  static TextStyle get body => sans(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.7,
      );

  static TextStyle get bodySmall => sans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get caption => sans(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get chord => mono(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.goldDeep,
      );

  // ─── Theme TextTheme ───
  static TextTheme get textTheme => TextTheme(
        displayLarge: serif(fontSize: 34, fontWeight: FontWeight.w700),
        displayMedium: serif(fontSize: 28, fontWeight: FontWeight.w600),
        headlineLarge: serif(fontSize: 26, fontWeight: FontWeight.w600),
        headlineMedium: serif(fontSize: 22, fontWeight: FontWeight.w600),
        titleLarge: serif(fontSize: 18, fontWeight: FontWeight.w600),
        titleMedium: sans(fontSize: 16, fontWeight: FontWeight.w600),
        titleSmall: sans(fontSize: 14, fontWeight: FontWeight.w600),
        bodyLarge: sans(fontSize: 18, height: 1.7),
        bodyMedium: sans(fontSize: 16, height: 1.6),
        bodySmall: sans(fontSize: 14, color: AppColors.textSecondary),
        labelLarge: sans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        labelMedium: sans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.0,
        ),
        labelSmall: sans(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5,
          color: AppColors.textSecondary,
        ),
      );

  static TextTheme get darkTextTheme => TextTheme(
        displayLarge: serif(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: AppColors.darkTextPrimary,
        ),
        displayMedium: serif(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
        headlineLarge: serif(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
        headlineMedium: serif(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
        titleLarge: serif(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
        titleMedium: sans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
        titleSmall: sans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
        bodyLarge: sans(
          fontSize: 18,
          height: 1.7,
          color: AppColors.darkTextPrimary,
        ),
        bodyMedium: sans(
          fontSize: 16,
          height: 1.6,
          color: AppColors.darkTextPrimary,
        ),
        bodySmall: sans(
          fontSize: 14,
          color: AppColors.darkTextSecondary,
        ),
        labelLarge: sans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: AppColors.darkTextPrimary,
        ),
        labelMedium: sans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.0,
          color: AppColors.darkTextSecondary,
        ),
        labelSmall: sans(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5,
          color: AppColors.darkTextSecondary,
        ),
      );
}
