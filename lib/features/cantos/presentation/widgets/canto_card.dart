import 'package:flutter/material.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';
import 'package:cantor_app/features/cantos/domain/canto.dart';
import 'package:cantor_app/shared/widgets/categoria_badge.dart';

class CantoCard extends StatelessWidget {
  final Canto canto;
  final VoidCallback onTap;
  final int animationIndex;
  final bool compact;

  const CantoCard({
    super.key,
    required this.canto,
    required this.onTap,
    this.animationIndex = 0,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                      blur: 12, offset: 4, opacity: 0.06),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title (serif)
                        Hero(
                          tag: 'canto_title_${canto.id}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              canto.titulo,
                              style: AppTypography.serif(
                                fontSize: compact ? 16 : 18,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        if (!compact) ...[
                          const SizedBox(height: 4),
                          // Author
                          if (canto.autor != null &&
                              canto.autor!.isNotEmpty)
                            Text(
                              canto.autor!,
                              style: AppTypography.caption,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          const SizedBox(height: 8),
                          // Categories
                          Row(
                            children: [
                              ...canto.categorias.take(2).map(
                                    (c) => Padding(
                                      padding:
                                          const EdgeInsets.only(right: 6),
                                      child: CategoriaBadge(
                                          categoriaName: c),
                                    ),
                                  ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Tonality badge
                  if (canto.tonalidad != null &&
                      canto.tonalidad!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.goldLuminous.withValues(alpha: 0.15)
                            : AppColors.goldDeep.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        canto.tonalidad!,
                        style: AppTypography.mono(
                          fontSize: 13,
                          color:
                              isDark ? AppColors.goldLuminous : AppColors.goldDeep,
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
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
          ),
        ),
      ),
    );
  }
}

/// Compact horizontal canto card for "Recientes" sections.
class CantoCardCompact extends StatelessWidget {
  final Canto canto;
  final VoidCallback onTap;

  const CantoCardCompact({
    super.key,
    required this.canto,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkBgSecondary
              : AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isDark
              ? null
              : AppColors.warmElevation(blur: 10, offset: 3, opacity: 0.06),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              canto.titulo,
              style: AppTypography.serif(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            if (canto.tonalidad != null && canto.tonalidad!.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.goldLuminous.withValues(alpha: 0.15)
                      : AppColors.goldDeep.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  canto.tonalidad!,
                  style: AppTypography.mono(
                    fontSize: 11,
                    color: isDark
                        ? AppColors.goldLuminous
                        : AppColors.goldDeep,
                  ),
                ),
              ),
            const Spacer(),
            if (canto.autor != null && canto.autor!.isNotEmpty)
              Text(
                canto.autor!,
                style: AppTypography.sans(
                  fontSize: 11,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}
