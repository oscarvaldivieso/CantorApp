import 'package:flutter/material.dart';
import 'app_colors.dart';

enum TiempoLiturgicoTheme {
  adviento(AppColors.liturgyPurple, 'Adviento', '🕯️'),
  navidad(AppColors.gold, 'Navidad', '⭐'),
  cuaresma(AppColors.liturgyRed, 'Cuaresma', '✝️'),
  semanaSanta(AppColors.liturgyRed, 'Semana Santa', '🕊️'),
  pascua(AppColors.gold, 'Pascua', '🐑'),
  pentecostes(AppColors.liturgyRed, 'Pentecostés', '🔥'),
  ordinario(AppColors.liturgyGreen, 'Tiempo Ordinario', '🌿'),
  todos(AppColors.navyDeep, 'Todos', '📖');

  const TiempoLiturgicoTheme(this.color, this.label, this.emoji);
  final Color color;
  final String label;
  final String emoji;
}

class LiturgicalTheme {
  LiturgicalTheme._();

  static Color colorForTiempo(String tiempo) {
    final t = TiempoLiturgicoTheme.values.cast<TiempoLiturgicoTheme?>().firstWhere(
      (e) => e!.name == tiempo,
      orElse: () => null,
    );
    return t?.color ?? AppColors.navyDeep;
  }

  static String labelForTiempo(String tiempo) {
    final t = TiempoLiturgicoTheme.values.cast<TiempoLiturgicoTheme?>().firstWhere(
      (e) => e!.name == tiempo,
      orElse: () => null,
    );
    return t?.label ?? tiempo;
  }

  static String emojiForTiempo(String tiempo) {
    final t = TiempoLiturgicoTheme.values.cast<TiempoLiturgicoTheme?>().firstWhere(
      (e) => e!.name == tiempo,
      orElse: () => null,
    );
    return t?.emoji ?? '📖';
  }
}
