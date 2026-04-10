import 'package:flutter/material.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/features/cantos/domain/enums.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriaBadge extends StatelessWidget {
  final String categoriaName;
  const CategoriaBadge({super.key, required this.categoriaName});

  @override
  Widget build(BuildContext context) {
    Categoria? cat;
    try {
      cat = Categoria.values.firstWhere((e) => e.name == categoriaName);
    } catch (_) {}

    final label = cat?.label ?? categoriaName;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.crimsonPro(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: AppColors.navyDeep,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
