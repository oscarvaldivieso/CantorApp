import 'package:flutter/material.dart';
import 'app_colors.dart';

enum TiempoLiturgicoTheme {
  adviento(AppColors.liturgyPurple, 'Adviento', '🕯️'),
  navidad(AppColors.liturgyGoldBright, 'Navidad', '⭐'),
  cuaresma(AppColors.liturgyPurple, 'Cuaresma', '✝️'),
  semanaSanta(AppColors.liturgyRed, 'Semana Santa', '🕊️'),
  pascua(AppColors.liturgyGoldBright, 'Pascua', '🐑'),
  pentecostes(AppColors.liturgyRed, 'Pentecostés', '🔥'),
  ordinario(AppColors.liturgyGreen, 'Tiempo Ordinario', '🌿'),
  todos(AppColors.goldDeep, 'Todos', '📖');

  const TiempoLiturgicoTheme(this.color, this.label, this.emoji);
  final Color color;
  final String label;
  final String emoji;

  /// Returns a subtle gradient for headers based on the liturgical time.
  LinearGradient get gradient => LinearGradient(
        colors: [
          color.withValues(alpha: 0.15),
          color.withValues(alpha: 0.05),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}

/// Premium visual palette per liturgical season for the vitral header system.
class LiturgicalVisualPalette {
  final List<Color> gradientColors;
  final List<Color> glowColors;
  final Color accentGlow;
  final String title;
  final String devotionalPhrase;
  final String assetPath;

  const LiturgicalVisualPalette({
    required this.gradientColors,
    required this.glowColors,
    required this.accentGlow,
    required this.title,
    required this.devotionalPhrase,
    required this.assetPath,
  });

  static LiturgicalVisualPalette forTiempo(String tiempo, bool isDark) {
    switch (tiempo) {
      case 'adviento':
        return LiturgicalVisualPalette(
          gradientColors: isDark
              ? [const Color(0xFF1A0E2E), const Color(0xFF2D1B4E), const Color(0xFF1A1230)]
              : [const Color(0xFFF0E6FA), const Color(0xFFE8D5F5), const Color(0xFFF5EEF9)],
          glowColors: isDark
              ? [const Color(0xFFD4AF37).withValues(alpha: 0.15), const Color(0xFF6B3FA0).withValues(alpha: 0.08)]
              : [const Color(0xFFD4AF37).withValues(alpha: 0.12), const Color(0xFF6B3FA0).withValues(alpha: 0.06)],
          accentGlow: isDark ? const Color(0xFFD4AF37) : const Color(0xFF6B3FA0),
          title: 'Adviento',
          devotionalPhrase: 'Ven, Señor, no tardes',
          assetPath: 'lib/assets/adviento.png',
        );
      case 'navidad':
        return LiturgicalVisualPalette(
          gradientColors: isDark
              ? [const Color(0xFF2A1F0A), const Color(0xFF3D2E12), const Color(0xFF1F1A0D)]
              : [const Color(0xFFFFF8E7), const Color(0xFFFFF0CC), const Color(0xFFFFFBF2)],
          glowColors: isDark
              ? [const Color(0xFFD4AF37).withValues(alpha: 0.20), const Color(0xFFFFF8E7).withValues(alpha: 0.08)]
              : [const Color(0xFFD4AF37).withValues(alpha: 0.18), const Color(0xFFC8A951).withValues(alpha: 0.08)],
          accentGlow: const Color(0xFFD4AF37),
          title: 'Navidad',
          devotionalPhrase: 'Gloria a Dios en el cielo',
          assetPath: 'lib/assets/navidad.png',
        );
      case 'cuaresma':
        return LiturgicalVisualPalette(
          gradientColors: isDark
              ? [const Color(0xFF1A0E28), const Color(0xFF241538), const Color(0xFF16101E)]
              : [const Color(0xFFF2EAF7), const Color(0xFFE8DDF0), const Color(0xFFF5F0F8)],
          glowColors: isDark
              ? [const Color(0xFF8B6BAE).withValues(alpha: 0.10), const Color(0xFF5A3090).withValues(alpha: 0.06)]
              : [const Color(0xFF8B6BAE).withValues(alpha: 0.10), const Color(0xFF5A3090).withValues(alpha: 0.05)],
          accentGlow: isDark ? const Color(0xFF8B6BAE) : const Color(0xFF5A3090),
          title: 'Cuaresma',
          devotionalPhrase: 'Crea en mí un corazón puro',
          assetPath: 'lib/assets/cuaresma.png',
        );
      case 'semanaSanta':
        return LiturgicalVisualPalette(
          gradientColors: isDark
              ? [const Color(0xFF1E0A0A), const Color(0xFF2E1414), const Color(0xFF1A0E0E)]
              : [const Color(0xFFF8ECEC), const Color(0xFFF2E0E0), const Color(0xFFF9F0F0)],
          glowColors: isDark
              ? [const Color(0xFFB83232).withValues(alpha: 0.12), const Color(0xFF7A1A1A).withValues(alpha: 0.06)]
              : [const Color(0xFFB83232).withValues(alpha: 0.08), const Color(0xFF7A1A1A).withValues(alpha: 0.04)],
          accentGlow: isDark ? const Color(0xFFD45A5A) : const Color(0xFFB83232),
          title: 'Semana Santa',
          devotionalPhrase: 'He aquí el cordero de Dios',
          assetPath: 'lib/assets/cuaresma.png',
        );
      case 'pascua':
        return LiturgicalVisualPalette(
          gradientColors: isDark
              ? [const Color(0xFF1F1A0A), const Color(0xFF2E2610), const Color(0xFF1A170D)]
              : [const Color(0xFFFFFDF5), const Color(0xFFFFF8E0), const Color(0xFFFFFEFA)],
          glowColors: isDark
              ? [const Color(0xFFD4AF37).withValues(alpha: 0.22), const Color(0xFFFFF8E7).withValues(alpha: 0.10)]
              : [const Color(0xFFD4AF37).withValues(alpha: 0.20), const Color(0xFFFFF8E7).withValues(alpha: 0.10)],
          accentGlow: const Color(0xFFD4AF37),
          title: 'Pascua',
          devotionalPhrase: '¡Resucitó! ¡Aleluya!',
          assetPath: 'lib/assets/pascua.png',
        );
      case 'pentecostes':
        return LiturgicalVisualPalette(
          gradientColors: isDark
              ? [const Color(0xFF1E0A00), const Color(0xFF2E1500), const Color(0xFF1A0E05)]
              : [const Color(0xFFFFF0E8), const Color(0xFFFFE8D8), const Color(0xFFFFF5EF)],
          glowColors: isDark
              ? [const Color(0xFFFF6B2B).withValues(alpha: 0.14), const Color(0xFFD45A00).withValues(alpha: 0.08)]
              : [const Color(0xFFFF6B2B).withValues(alpha: 0.10), const Color(0xFFD45A00).withValues(alpha: 0.05)],
          accentGlow: isDark ? const Color(0xFFFF6B2B) : const Color(0xFFD45A00),
          title: 'Pentecostés',
          devotionalPhrase: 'Ven, Espíritu Santo',
          assetPath: 'lib/assets/pascua.png',
        );
      default: // ordinario
        return LiturgicalVisualPalette(
          gradientColors: isDark
              ? [const Color(0xFF0E1A12), const Color(0xFF152A1C), const Color(0xFF101810)]
              : [const Color(0xFFEFF6F1), const Color(0xFFE4F0E8), const Color(0xFFF3F8F4)],
          glowColors: isDark
              ? [const Color(0xFF4A7C59).withValues(alpha: 0.12), const Color(0xFF2E5A3A).withValues(alpha: 0.06)]
              : [const Color(0xFF4A7C59).withValues(alpha: 0.08), const Color(0xFF2E5A3A).withValues(alpha: 0.04)],
          accentGlow: isDark ? const Color(0xFF6BA67A) : const Color(0xFF4A7C59),
          title: 'Tiempo Ordinario',
          devotionalPhrase: 'Señor, enséñame tus caminos',
          assetPath: 'lib/assets/ordinario.png',
        );
    }
  }

  /// Maps a tiempo key to its asset path (for use outside the palette).
  static String assetForTiempo(String tiempo) {
    switch (tiempo) {
      case 'adviento': return 'lib/assets/adviento.png';
      case 'navidad': return 'lib/assets/navidad.png';
      case 'cuaresma': return 'lib/assets/cuaresma.png';
      case 'semanaSanta': return 'lib/assets/cuaresma.png';
      case 'pascua': return 'lib/assets/pascua.png';
      case 'pentecostes': return 'lib/assets/pascua.png';
      default: return 'lib/assets/ordinario.png';
    }
  }
}

class LiturgicalTheme {
  LiturgicalTheme._();

  static TiempoLiturgicoTheme? _find(String tiempo) {
    return TiempoLiturgicoTheme.values.cast<TiempoLiturgicoTheme?>().firstWhere(
      (e) => e!.name == tiempo,
      orElse: () => null,
    );
  }

  static Color colorForTiempo(String tiempo) {
    return _find(tiempo)?.color ?? AppColors.goldDeep;
  }

  static String labelForTiempo(String tiempo) {
    return _find(tiempo)?.label ?? tiempo;
  }

  static String emojiForTiempo(String tiempo) {
    return _find(tiempo)?.emoji ?? '📖';
  }

  static LinearGradient gradientForTiempo(String tiempo) {
    return _find(tiempo)?.gradient ??
        TiempoLiturgicoTheme.ordinario.gradient;
  }

  /// Whether Gloria should be disabled for this liturgical time.
  static bool isGloriaDisabled(String tiempo) {
    return tiempo == 'cuaresma' || tiempo == 'semanaSanta';
  }

  /// Whether Aleluya changes to "Aclamación antes del Evangelio."
  static bool isAlelujaChanged(String tiempo) {
    return tiempo == 'cuaresma' || tiempo == 'semanaSanta';
  }
}
