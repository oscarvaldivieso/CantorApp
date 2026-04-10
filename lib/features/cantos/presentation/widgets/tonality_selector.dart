import 'package:flutter/material.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';
import 'package:cantor_app/core/utils/chord_transposer.dart';

class TonalitySelector extends StatelessWidget {
  final String? currentTonality;
  final ValueChanged<String> onChanged;

  const TonalitySelector({
    super.key,
    required this.currentTonality,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor =
        isDark ? AppColors.goldLuminous : AppColors.goldDeep;

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: ChordTransposer.notas.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (context, index) {
          final nota = ChordTransposer.notas[index];
          final isActive = nota == currentTonality;
          return GestureDetector(
            onTap: () => onChanged(nota),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isActive
                    ? activeColor
                    : (isDark
                        ? AppColors.darkBgSecondary
                        : AppColors.surfaceElevated),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isActive
                      ? activeColor
                      : (isDark
                          ? AppColors.darkTextSecondary
                              .withValues(alpha: 0.2)
                          : AppColors.textSecondary
                              .withValues(alpha: 0.15)),
                  width: isActive ? 2 : 1,
                ),
                boxShadow: isActive && !isDark
                    ? [
                        BoxShadow(
                          color: activeColor.withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(
                nota,
                style: AppTypography.mono(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isActive
                      ? (isDark ? AppColors.darkBg : AppColors.white)
                      : (isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.textSecondary),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
