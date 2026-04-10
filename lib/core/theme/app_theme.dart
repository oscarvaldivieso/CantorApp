import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.cream,
        textTheme: AppTypography.textTheme,
        colorScheme: const ColorScheme.light(
          primary: AppColors.navyDeep,
          secondary: AppColors.gold,
          surface: AppColors.cream,
          onPrimary: AppColors.white,
          onSecondary: AppColors.navyDeep,
          onSurface: AppColors.textDark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.navyDeep,
          foregroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.white,
          elevation: 8,
          shape: CircleBorder(),
        ),
        cardTheme: CardThemeData(
          color: AppColors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: AppColors.gold.withValues(alpha: 0.15),
              width: 1,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.parchment),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.parchment),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.gold, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.cream,
          selectedColor: AppColors.navyDeep,
          labelStyle: AppTypography.textTheme.bodyMedium!,
          side: const BorderSide(color: AppColors.parchment),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.parchment,
          thickness: 1,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.navyDeep,
          unselectedItemColor: AppColors.textMuted,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
        ),
      );
}
