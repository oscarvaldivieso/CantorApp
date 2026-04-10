import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';

enum MomentSlotState { empty, filled, disabled }

class MassMomentSlot extends StatelessWidget {
  final String momentLabel;
  final Color accentColor;
  final MomentSlotState state;
  final String? cantoTitle;
  final String? cantoTonality;
  final String? disabledReason;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const MassMomentSlot({
    super.key,
    required this.momentLabel,
    required this.accentColor,
    this.state = MomentSlotState.empty,
    this.cantoTitle,
    this.cantoTonality,
    this.disabledReason,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: GestureDetector(
        onTap: state == MomentSlotState.disabled
            ? () {
                HapticFeedback.lightImpact();
                if (disabledReason != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(disabledReason!)),
                  );
                }
              }
            : () {
                HapticFeedback.selectionClick();
                onTap?.call();
              },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: _backgroundColor(isDark),
            borderRadius: BorderRadius.circular(14),
            border: state == MomentSlotState.empty
                ? Border.all(
                    color: isDark
                        ? AppColors.darkTextSecondary.withValues(alpha: 0.2)
                        : AppColors.textSecondary.withValues(alpha: 0.15),
                    style: BorderStyle.solid,
                  )
                : null,
            boxShadow: state == MomentSlotState.filled && !isDark
                ? AppColors.warmElevation(
                    blur: 8, offset: 2, opacity: 0.05)
                : null,
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Left accent bar
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color: state == MomentSlotState.disabled
                        ? (isDark
                            ? AppColors.darkTextSecondary.withValues(alpha: 0.2)
                            : AppColors.textSecondary.withValues(alpha: 0.2))
                        : accentColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    ),
                  ),
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    child: _buildContent(isDark),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _backgroundColor(bool isDark) {
    if (state == MomentSlotState.disabled) {
      return isDark
          ? AppColors.darkBgSecondary.withValues(alpha: 0.5)
          : AppColors.textSecondary.withValues(alpha: 0.05);
    }
    if (state == MomentSlotState.filled) {
      return isDark ? AppColors.darkBgSecondary : AppColors.surfaceElevated;
    }
    return Colors.transparent;
  }

  Widget _buildContent(bool isDark) {
    switch (state) {
      case MomentSlotState.empty:
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    momentLabel.toUpperCase(),
                    style: AppTypography.sans(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Toca para asignar canto',
                    style: AppTypography.sans(
                      fontSize: 13,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.add_rounded,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.textSecondary,
              size: 22,
            ),
          ],
        );

      case MomentSlotState.filled:
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    momentLabel.toUpperCase(),
                    style: AppTypography.sans(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    cantoTitle ?? '',
                    style: AppTypography.serif(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.textPrimary,
                    ),
                  ),
                  if (cantoTonality != null && cantoTonality!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        'Tono: $cantoTonality',
                        style: AppTypography.mono(
                          fontSize: 12,
                          color: isDark
                              ? AppColors.goldLuminous
                              : AppColors.goldDeep,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (onRemove != null)
              IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.textSecondary,
                  size: 20,
                ),
                onPressed: onRemove,
                visualDensity: VisualDensity.compact,
              ),
          ],
        );

      case MomentSlotState.disabled:
        return Opacity(
          opacity: 0.5,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      momentLabel.toUpperCase(),
                      style: AppTypography.sans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                    ),
                    if (disabledReason != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          disabledReason!,
                          style: AppTypography.sans(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.lock_outline_rounded,
                size: 18,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary,
              ),
            ],
          ),
        );
    }
  }
}
