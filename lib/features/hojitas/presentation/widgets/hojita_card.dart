import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';
import 'package:cantor_app/features/hojitas/domain/hojita.dart';

class HojitaCard extends StatelessWidget {
  final Hojita hojita;
  final VoidCallback onTap;
  final int animationIndex;

  const HojitaCard({
    super.key,
    required this.hojita,
    required this.onTap,
    this.animationIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cantosCount = hojita.cantos.length;
    final dateStr = DateFormat('d MMM yyyy', 'es').format(hojita.fecha);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 350 + (animationIndex * 40)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 16 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkBgSecondary
                  : AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(16),
              boxShadow: isDark
                  ? null
                  : AppColors.warmElevation(
                      blur: 14, offset: 5, opacity: 0.07),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Gold tint header ---
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [
                              AppColors.goldLuminous.withValues(alpha: 0.12),
                              AppColors.darkBgSecondary,
                            ]
                          : [
                              AppColors.goldDeep.withValues(alpha: 0.08),
                              AppColors.surfaceElevated,
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Icon container
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.goldLuminous.withValues(alpha: 0.15)
                              : AppColors.goldDeep.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.library_music_rounded,
                          size: 18,
                          color: isDark
                              ? AppColors.goldLuminous
                              : AppColors.goldDeep,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Title
                      Expanded(
                        child: Text(
                          hojita.titulo,
                          style: AppTypography.serif(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: isDark
                            ? AppColors.darkTextSecondary.withValues(alpha: 0.4)
                            : AppColors.textSecondary.withValues(alpha: 0.3),
                        size: 22,
                      ),
                    ],
                  ),
                ),
                // --- Body ---
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
                  child: Row(
                    children: [
                      // Date
                      _InfoChip(
                        icon: Icons.calendar_today_rounded,
                        label: dateStr,
                        isDark: isDark,
                      ),
                      const SizedBox(width: 12),
                      // Canto count
                      _InfoChip(
                        icon: Icons.music_note_rounded,
                        label: '$cantosCount cantos',
                        isDark: isDark,
                      ),
                      const SizedBox(width: 12),
                      // Tipo misa
                      _InfoChip(
                        icon: Icons.church_rounded,
                        label: hojita.tipoMisa,
                        isDark: isDark,
                      ),
                      const Spacer(),
                      // Export indicator
                      if (hojita.exportadaEn != null)
                        Icon(
                          Icons.picture_as_pdf_rounded,
                          size: 16,
                          color: isDark
                              ? AppColors.goldLuminous.withValues(alpha: 0.5)
                              : AppColors.goldDeep.withValues(alpha: 0.4),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 13,
          color: isDark
              ? AppColors.darkTextSecondary
              : AppColors.textSecondary,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTypography.sans(
            fontSize: 12,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}