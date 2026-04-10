import 'package:flutter/material.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/utils/chord_transposer.dart';
import 'package:google_fonts/google_fonts.dart';

class AcordesWidget extends StatelessWidget {
  final String chordProText;
  final String? originalTonality;
  final String? targetTonality;

  const AcordesWidget({
    super.key,
    required this.chordProText,
    this.originalTonality,
    this.targetTonality,
  });

  @override
  Widget build(BuildContext context) {
    String text = chordProText;
    if (originalTonality != null &&
        targetTonality != null &&
        originalTonality != targetTonality) {
      text = ChordTransposer.transposeChordPro(
        text,
        originalTonality!,
        targetTonality!,
      );
    }

    final lines = text.split('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) => _buildLine(line)).toList(),
    );
  }

  Widget _buildLine(String line) {
    if (line.trim().isEmpty) return const SizedBox(height: 12);

    final regex = RegExp(r'\[([A-G][#b]?[a-z0-9]*)\]');
    final spans = <InlineSpan>[];
    int lastEnd = 0;

    for (final match in regex.allMatches(line)) {
      if (match.start > lastEnd) {
        final textBefore = line.substring(lastEnd, match.start);
        spans.add(TextSpan(
          text: textBefore,
          style: GoogleFonts.crimsonPro(
            fontSize: 17,
            height: 1.8,
            color: AppColors.textDark,
          ),
        ));
      }
      // Add chord as superscript-style
      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.aboveBaseline,
        baseline: TextBaseline.alphabetic,
        child: Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Text(
            match.group(1)!,
            style: GoogleFonts.crimsonPro(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.gold,
            ),
          ),
        ),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < line.length) {
      spans.add(TextSpan(
        text: line.substring(lastEnd),
        style: GoogleFonts.crimsonPro(
          fontSize: 17,
          height: 1.8,
          color: AppColors.textDark,
        ),
      ));
    }

    if (spans.isEmpty) {
      return Text(
        line,
        style: GoogleFonts.crimsonPro(
          fontSize: 17,
          height: 1.8,
          color: AppColors.textDark,
        ),
      );
    }

    return RichText(text: TextSpan(children: spans));
  }
}
