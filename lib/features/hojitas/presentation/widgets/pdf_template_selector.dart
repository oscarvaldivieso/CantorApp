import 'package:flutter/material.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PdfTemplateSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const PdfTemplateSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const _templates = [
    {'key': 'clasico', 'label': 'Clásico', 'color': AppColors.navyDeep, 'emoji': '📘'},
    {'key': 'pergamino', 'label': 'Pergamino', 'color': AppColors.creamDark, 'emoji': '📜'},
    {'key': 'cuaresma', 'label': 'Cuaresma', 'color': AppColors.liturgyRed, 'emoji': '✝️'},
    {'key': 'ordinario', 'label': 'Ordinario', 'color': AppColors.liturgyGreen, 'emoji': '🌿'},
  ];

  @override
  Widget build(BuildContext context) {
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
        final emoji = t['emoji'] as String;
        final isActive = selected == key;

        return GestureDetector(
          onTap: () => onChanged(key),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: color.withValues(alpha: isActive ? 0.15 : 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isActive ? color : AppColors.parchment,
                width: isActive ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(emoji, style: const TextStyle(fontSize: 28)),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: GoogleFonts.crimsonPro(
                    fontSize: 11,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                    color: isActive ? color : AppColors.textMuted,
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
