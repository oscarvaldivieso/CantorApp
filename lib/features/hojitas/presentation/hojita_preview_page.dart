import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:printing/printing.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';
import 'package:cantor_app/features/cantos/presentation/providers/cantos_provider.dart';
import 'package:cantor_app/features/hojitas/domain/hojita.dart';
import 'package:cantor_app/features/hojitas/data/pdf_generator.dart';
import 'package:cantor_app/shared/widgets/empty_state.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class _HojitaData {
  final Hojita hojita;
  final Map<String, String> letrasMap;
  const _HojitaData({required this.hojita, required this.letrasMap});
}

final _hojitaWithLetrasProvider =
    FutureProvider.family<_HojitaData?, int>((ref, id) async {
  final isar = ref.watch(isarServiceProvider);
  final hojita = await isar.getHojitaById(id);
  if (hojita == null) return null;

  final letrasMap = <String, String>{};
  for (final item in hojita.cantos) {
    final canto = await isar.getCantoByUuid(item.cantoUuid);
    if (canto != null) {
      letrasMap[item.cantoUuid] = canto.letra;
    }
  }
  return _HojitaData(hojita: hojita, letrasMap: letrasMap);
});

class HojitaPreviewPage extends ConsumerWidget {
  final int hojitaId;
  const HojitaPreviewPage({super.key, required this.hojitaId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(_hojitaWithLetrasProvider(hojitaId));

    return dataAsync.when(
      data: (data) {
        if (data == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('No encontrada')),
            body: const EmptyState(
              icon: '📋',
              title: 'Hojita no encontrada',
              subtitle: 'La hojita que buscas no existe',
            ),
          );
        }
        return _HojitaPreviewContent(
          hojita: data.hojita,
          letrasMap: data.letrasMap,
        );
      },
      loading: () => Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.goldLuminous
                : AppColors.goldDeep,
            strokeWidth: 2,
          ),
        ),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text(e.toString())),
      ),
    );
  }
}

class _HojitaPreviewContent extends StatelessWidget {
  final Hojita hojita;
  final Map<String, String> letrasMap;
  const _HojitaPreviewContent({
    required this.hojita,
    required this.letrasMap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d \'de\' MMMM, yyyy', 'es');
    final fechaStr = dateFormat.format(hojita.fecha);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.cream,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkBg : AppColors.cream,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Vista Previa',
          style: AppTypography.serif(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Preview Card simulating PDF
            Container(
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkBgSecondary
                    : AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isDark
                    ? AppColors.goldGlow(opacity: 0.06, blur: 20)
                    : AppColors.warmElevation(
                        blur: 20, offset: 6, opacity: 0.08),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [
                                AppColors.goldLuminous
                                    .withValues(alpha: 0.08),
                                Colors.transparent,
                              ]
                            : [
                                AppColors.goldDeep
                                    .withValues(alpha: 0.06),
                                Colors.transparent,
                              ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.church_outlined,
                          size: 32,
                          color: isDark
                              ? AppColors.goldLuminous
                              : AppColors.goldDeep,
                        ),
                        if (hojita.parroquiaNombre != null &&
                            hojita.parroquiaNombre!.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            hojita.parroquiaNombre!.toUpperCase(),
                            style: AppTypography.sans(
                              fontSize: 10,
                              letterSpacing: 2,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                        const SizedBox(height: 8),
                        Text(
                          hojita.titulo,
                          style: AppTypography.serif(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          fechaStr,
                          style: AppTypography.sans(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: isDark
                                ? AppColors.goldLuminous
                                : AppColors.goldDeep,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Gold divider
                  Container(
                    height: 2,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          isDark
                              ? AppColors.goldLuminous
                              : AppColors.goldDeep,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Cantos list
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: hojita.cantos
                          .asMap()
                          .entries
                          .map((entry) {
                        final index = entry.key + 1;
                        final item = entry.value;
                        final letra = letrasMap[item.cantoUuid];
                        final coroSnippet = letra != null
                            ? _getCoroSnippet(letra)
                            : '';
                        return Padding(
                          padding:
                              const EdgeInsets.only(bottom: 14),
                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.goldLuminous
                                          .withValues(alpha: 0.12)
                                      : AppColors.goldDeep
                                          .withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '$index',
                                  style: AppTypography.sans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: isDark
                                        ? AppColors.goldLuminous
                                        : AppColors.goldDeep,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.cantoTitulo,
                                      style: AppTypography.sans(
                                        fontSize: 16,
                                        fontWeight:
                                            FontWeight.w600,
                                        color: isDark
                                            ? AppColors
                                                .darkTextPrimary
                                            : AppColors
                                                .textPrimary,
                                      ),
                                    ),
                                    Text(
                                      '${item.cantoAutor} · ${_categoriaLabel(item.cantoCategoria)}',
                                      style: AppTypography.sans(
                                        fontSize: 12,
                                        fontStyle:
                                            FontStyle.italic,
                                        color: isDark
                                            ? AppColors
                                                .darkTextSecondary
                                            : AppColors
                                                .textSecondary,
                                      ),
                                    ),
                                    if (coroSnippet
                                        .isNotEmpty) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        coroSnippet,
                                        style: AppTypography.sans(
                                          fontSize: 11,
                                          fontStyle:
                                              FontStyle.italic,
                                          color: isDark
                                              ? AppColors
                                                  .darkTextSecondary
                                                  .withValues(
                                                      alpha: 0.7)
                                              : AppColors
                                                  .textSecondary
                                                  .withValues(
                                                      alpha: 0.7),
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow
                                            .ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  // Footer
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: isDark
                              ? AppColors.darkTextSecondary
                                  .withValues(alpha: 0.15)
                              : AppColors.textSecondary
                                  .withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    child: Text(
                      'Generado con CantorApp${hojita.parroquiaNombre != null ? ' · ${hojita.parroquiaNombre}' : ''}',
                      style: AppTypography.sans(
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Export buttons
            Row(
              children: [
                Expanded(
                  child: _ExportButton(
                    label: 'PDF',
                    icon: Icons.picture_as_pdf_outlined,
                    gradient: AppColors.goldGradient,
                    textColor: AppColors.white,
                    onTap: () => _exportPdf(context, hojita),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ExportButton(
                    label: 'Compartir',
                    icon: Icons.share_outlined,
                    gradient: null,
                    textColor: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                    borderColor: isDark
                        ? AppColors.darkTextSecondary
                            .withValues(alpha: 0.2)
                        : AppColors.textSecondary
                            .withValues(alpha: 0.15),
                    onTap: () => _sharePdf(context, hojita),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Future<void> _exportPdf(BuildContext context, Hojita hojita) async {
    try {
      final pdfBytes =
          await PdfGenerator.generateHojitaPdf(hojita, letrasMap);
      await Printing.layoutPdf(
        onLayout: (format) async => pdfBytes,
        name: '${hojita.titulo}.pdf',
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al generar PDF: $e')),
        );
      }
    }
  }

  Future<void> _sharePdf(BuildContext context, Hojita hojita) async {
    try {
      final pdfBytes =
          await PdfGenerator.generateHojitaPdf(hojita, letrasMap);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/${hojita.titulo}.pdf');
      await file.writeAsBytes(pdfBytes);
      await Share.shareXFiles(
        [XFile(file.path)],
        text: '${hojita.titulo} - Hoja de cantos',
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al compartir: $e')),
        );
      }
    }
  }

  String _categoriaLabel(String cat) {
    const labels = {
      'entrada': 'Entrada',
      'gloria': 'Gloria',
      'salmo': 'Salmo',
      'aleluya': 'Aleluya',
      'ofertorio': 'Ofertorio',
      'santo': 'Santo',
      'memorial': 'Memorial',
      'comunion': 'Comunión',
      'accionGracias': 'Acción de Gracias',
      'salida': 'Salida',
      'adoracion': 'Adoración',
      'varios': 'Varios',
    };
    return labels[cat] ?? cat;
  }

  /// Extrae las primeras líneas del Coro para mostrar como adelanto.
  String _getCoroSnippet(String letra) {
    final match = RegExp(r'\{C\}').firstMatch(letra);
    if (match == null) return '';

    final start = match.end;
    final nextMarker =
        RegExp(r'\{(E\d+|P|Puente|Final)\}').firstMatch(
            letra.substring(start));
    final end = nextMarker != null
        ? start + nextMarker.start
        : letra.length;

    return letra
        .substring(start, end)
        .trim()
        .split('\n')
        .where((l) => l.trim().isNotEmpty)
        .take(3)
        .join('\n');
  }
}

class _ExportButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Gradient? gradient;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback onTap;

  const _ExportButton({
    required this.label,
    required this.icon,
    this.gradient,
    required this.textColor,
    this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(14),
          border: borderColor != null
              ? Border.all(color: borderColor!)
              : null,
          boxShadow: gradient != null
              ? [
                  BoxShadow(
                    color: AppColors.goldDeep
                        .withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Icon(icon, size: 22, color: textColor),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppTypography.sans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
