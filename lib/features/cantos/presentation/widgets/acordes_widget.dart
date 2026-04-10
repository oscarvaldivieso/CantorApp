import 'package:flutter/material.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';
import 'package:cantor_app/core/utils/chord_transposer.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) => _buildLine(line, isDark)).toList(),
    );
  }

  Widget _buildLine(String line, bool isDark) {
    if (line.trim().isEmpty) return const SizedBox(height: 12);

    final regex = RegExp(r'\[([A-G][#b]?[a-z0-9]*)\]');
    final spans = <InlineSpan>[];
    int lastEnd = 0;

    final chordColor =
        isDark ? AppColors.goldLuminous : AppColors.goldDeep;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

    for (final match in regex.allMatches(line)) {
      if (match.start > lastEnd) {
        final textBefore = line.substring(lastEnd, match.start);
        spans.add(TextSpan(
          text: textBefore,
          style: AppTypography.sans(
            fontSize: 17,
            height: 1.8,
            color: textColor,
          ),
        ));
      }
      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.aboveBaseline,
        baseline: TextBaseline.alphabetic,
        child: Container(
          padding: const EdgeInsets.only(right: 2),
          child: Text(
            match.group(1)!,
            style: AppTypography.mono(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: chordColor,
            ),
          ),
        ),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < line.length) {
      spans.add(TextSpan(
        text: line.substring(lastEnd),
        style: AppTypography.sans(
          fontSize: 17,
          height: 1.8,
          color: textColor,
        ),
      ));
    }

    if (spans.isEmpty) {
      return Text(
        line,
        style: AppTypography.sans(
          fontSize: 17,
          height: 1.8,
          color: textColor,
        ),
      );
    }

    return RichText(text: TextSpan(children: spans));
  }
}
