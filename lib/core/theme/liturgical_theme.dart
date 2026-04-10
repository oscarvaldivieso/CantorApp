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
