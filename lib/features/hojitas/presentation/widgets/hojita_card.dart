import 'package:flutter/material.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/features/hojitas/domain/hojita.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
    final dateFormat = DateFormat('d MMM yyyy', 'es');
    final firstCanto =
        hojita.cantos.isNotEmpty ? hojita.cantos.first.cantoTitulo : '';
    final tipoLabel = _tipoLabel(hojita.tipoMisa);

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
              // Header
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hojita.titulo,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            dateFormat.format(hojita.fecha),
                            style: GoogleFonts.crimsonPro(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: AppColors.white.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.gold,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tipoLabel,
                        style: GoogleFonts.crimsonPro(
                          fontSize: 11,
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
                          if (firstCanto.isNotEmpty)
                            Text(
                              firstCanto,
                              style: GoogleFonts.crimsonPro(
                                fontSize: 14,
                                color: AppColors.textDark,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          const SizedBox(height: 4),
                          Text(
                            '${hojita.cantos.length} canto${hojita.cantos.length == 1 ? '' : 's'}',
                            style: GoogleFonts.crimsonPro(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
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

  String _tipoLabel(String tipo) {
    const labels = {
      'dominical': 'Dominical',
      'matrimonio': 'Matrimonio',
      'bautismo': 'Bautismo',
      'funeral': 'Funeral',
      'primeraComunion': 'Primera Comunión',
      'otro': 'Otro',
    };
    return labels[tipo] ?? tipo;
  }
}
