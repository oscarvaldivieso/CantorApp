import 'package:flutter/material.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';

/// Placeholder widget for image assets that will be replaced later.
class AssetPlaceholder extends StatelessWidget {
  final String description;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final IconData icon;
  final BoxFit? fit;

  const AssetPlaceholder({
    super.key,
    required this.description,
    this.width,
    this.height,
    this.backgroundColor,
    this.icon = Icons.image_outlined,
    this.fit,
  });

  /// Cathedral hero image placeholder.
  const AssetPlaceholder.cathedral({
    super.key,
    this.width,
    this.height,
    this.fit,
  })  : description = 'Cathedral Vault',
        backgroundColor = const Color(0xFF1A1714),
        icon = Icons.church_outlined;

  /// Paper texture placeholder.
  const AssetPlaceholder.paperTexture({
    super.key,
    this.width,
    this.height,
    this.fit,
  })  : description = 'Paper Texture',
        backgroundColor = const Color(0xFFFAF7F2),
        icon = Icons.texture_outlined;

  /// Stained glass placeholder.
  const AssetPlaceholder.stainedGlass({
    super.key,
    this.width,
    this.height,
    this.fit,
  })  : description = 'Stained Glass',
        backgroundColor = const Color(0xFF3A5A8C),
        icon = Icons.auto_awesome_outlined;

  /// Empty state illustration placeholder.
  const AssetPlaceholder.emptyState({
    super.key,
    this.width,
    this.height,
    this.fit,
  })  : description = 'Empty Lectern',
        backgroundColor = null,
        icon = Icons.music_off_outlined;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = backgroundColor ??
        (isDark ? AppColors.darkBgSecondary : AppColors.cream);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bg.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: isDark
                ? AppColors.darkTextSecondary.withValues(alpha: 0.4)
                : AppColors.textSecondary.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 6),
          Text(
            'Placeholder: $description',
            style: AppTypography.sans(
              fontSize: 10,
              color: isDark
                  ? AppColors.darkTextSecondary.withValues(alpha: 0.4)
                  : AppColors.textSecondary.withValues(alpha: 0.3),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
