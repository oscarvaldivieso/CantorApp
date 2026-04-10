import 'package:flutter/material.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/utils/chord_transposer.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: ChordTransposer.notas.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final nota = ChordTransposer.notas[index];
          final isActive = nota == currentTonality;
          return GestureDetector(
            onTap: () => onChanged(nota),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isActive ? AppColors.navyDeep : AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive ? AppColors.navyDeep : AppColors.parchment,
                  width: isActive ? 2 : 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                nota,
                style: GoogleFonts.crimsonPro(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isActive ? AppColors.white : AppColors.textDark,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
