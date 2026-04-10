import 'package:flutter/material.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/features/cantos/domain/canto.dart';
import 'package:cantor_app/shared/widgets/categoria_badge.dart';
import 'package:google_fonts/google_fonts.dart';

class CantoCard extends StatelessWidget {
  final Canto canto;
  final VoidCallback onTap;
  final int animationIndex;

  const CantoCard({
    super.key,
    required this.canto,
    required this.onTap,
    this.animationIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 + (animationIndex * 50)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: AppColors.gold.withValues(alpha: 0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header con degradado navy
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: const BoxDecoration(
                  gradient: AppColors.navyGradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        canto.titulo,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (canto.tonalidad != null && canto.tonalidad!.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          canto.tonalidad!,
                          style: GoogleFonts.crimsonPro(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.navyDeep,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Body
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (canto.autor != null && canto.autor!.isNotEmpty)
                            Text(
                              canto.autor!,
                              style: GoogleFonts.crimsonPro(
                                fontSize: 13,
                                color: AppColors.textMuted,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: canto.categorias
                                .take(2)
                                .map((c) => CategoriaBadge(categoriaName: c))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: AppColors.parchment,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
