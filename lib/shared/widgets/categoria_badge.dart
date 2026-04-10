import 'package:flutter/material.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';
import 'package:cantor_app/features/cantos/domain/enums.dart';

class CategoriaBadge extends StatelessWidget {
  final String categoriaName;
  const CategoriaBadge({super.key, required this.categoriaName});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Categoria? cat;
    try {
      cat = Categoria.values.firstWhere((e) => e.name == categoriaName);
    } catch (_) {}

    final label = cat?.label ?? categoriaName;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkTextSecondary.withValues(alpha: 0.1)
            : AppColors.cream,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTypography.sans(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
