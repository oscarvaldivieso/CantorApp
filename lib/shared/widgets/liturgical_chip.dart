import 'package:flutter/material.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';
import 'package:cantor_app/core/theme/liturgical_theme.dart';

class LiturgicalChip extends StatelessWidget {
  final String tiempo;
  final bool small;
  const LiturgicalChip({super.key, required this.tiempo, this.small = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = LiturgicalTheme.colorForTiempo(tiempo);
    final label = LiturgicalTheme.labelForTiempo(tiempo);
    final emoji = LiturgicalTheme.emojiForTiempo(tiempo);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 8 : 12,
        vertical: small ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: isDark ? 0.35 : 0.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: TextStyle(fontSize: small ? 12 : 14)),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTypography.sans(
              fontSize: small ? 10 : 12,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.darkTextPrimary : color,
            ),
          ),
        ],
      ),
    );
  }
}
