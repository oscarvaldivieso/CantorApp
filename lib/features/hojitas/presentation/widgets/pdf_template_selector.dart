import 'package:flutter/material.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';

class PdfTemplateSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const PdfTemplateSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const _templates = [
    {
      'key': 'clasico',
      'label': 'Clásico',
      'color': AppColors.goldDeep,
      'icon': Icons.menu_book_outlined,
    },
    {
      'key': 'pergamino',
      'label': 'Pergamino',
      'color': AppColors.creamDark,
      'icon': Icons.article_outlined,
    },
    {
      'key': 'cuaresma',
      'label': 'Cuaresma',
      'color': AppColors.liturgyPurple,
      'icon': Icons.church_outlined,
    },
    {
      'key': 'ordinario',
      'label': 'Ordinario',
      'color': AppColors.liturgyGreen,
      'icon': Icons.eco_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _templates.length,
      itemBuilder: (context, index) {
        final t = _templates[index];
        final key = t['key'] as String;
        final label = t['label'] as String;
        final color = t['color'] as Color;
        final icon = t['icon'] as IconData;
        final isActive = selected == key;

        return GestureDetector(
          onTap: () => onChanged(key),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isActive
                  ? color.withValues(alpha: isDark ? 0.2 : 0.12)
                  : (isDark
                      ? AppColors.darkBgSecondary
                      : AppColors.surfaceElevated),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isActive
                    ? color
                    : (isDark
                        ? AppColors.darkTextSecondary
                            .withValues(alpha: 0.15)
                        : AppColors.textSecondary
                            .withValues(alpha: 0.12)),
                width: isActive ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 28,
                  color: isActive
                      ? color
                      : (isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.textSecondary),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: AppTypography.sans(
                    fontSize: 11,
                    fontWeight: isActive
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: isActive
                        ? color
                        : (isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
