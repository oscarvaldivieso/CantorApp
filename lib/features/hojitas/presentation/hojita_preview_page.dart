import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:printing/printing.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/features/cantos/presentation/providers/cantos_provider.dart';
import 'package:cantor_app/features/hojitas/domain/hojita.dart';
import 'package:cantor_app/features/hojitas/data/pdf_generator.dart';
import 'package:cantor_app/shared/widgets/empty_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

final _hojitaDetailProvider =
    FutureProvider.family<Hojita?, int>((ref, id) async {
  final isar = ref.watch(isarServiceProvider);
  return isar.getHojitaById(id);
});

class HojitaPreviewPage extends ConsumerWidget {
  final int hojitaId;
  const HojitaPreviewPage({super.key, required this.hojitaId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hojitaAsync = ref.watch(_hojitaDetailProvider(hojitaId));

    return hojitaAsync.when(
      data: (hojita) {
        if (hojita == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('No encontrada')),
            body: const EmptyState(
              icon: '📋',
              title: 'Hojita no encontrada',
              subtitle: 'La hojita que buscas no existe',
            ),
          );
        }
        return _HojitaPreviewContent(hojita: hojita);
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.gold),
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
  const _HojitaPreviewContent({required this.hojita});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d \'de\' MMMM, yyyy', 'es');
    final fechaStr = dateFormat.format(hojita.fecha);

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.navyDeep,
        title: Text(
          'Vista Previa',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        leading: IconButton(
          icon: Text(
            '← Volver',
            style: GoogleFonts.crimsonPro(
              fontSize: 13,
              color: AppColors.gold,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        leadingWidth: 100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Preview Card simulating PDF
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      gradient: AppColors.navyGradient,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '✝',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 32,
                            color: AppColors.gold,
                          ),
                        ),
                        if (hojita.parroquiaNombre != null &&
                            hojita.parroquiaNombre!.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            hojita.parroquiaNombre!.toUpperCase(),
                            style: GoogleFonts.crimsonPro(
                              fontSize: 10,
                              color: AppColors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                        const SizedBox(height: 8),
                        Text(
                          hojita.titulo,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          fechaStr,
                          style: GoogleFonts.crimsonPro(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: AppColors.gold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Divider dorado
                  Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.gold,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Cantos list
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: hojita.cantos.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final item = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  color: AppColors.gold,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '$index',
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.cantoTitulo,
                                      style: GoogleFonts.crimsonPro(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                    Text(
                                      '${item.cantoAutor} • ${_categoriaLabel(item.cantoCategoria)}',
                                      style: GoogleFonts.crimsonPro(
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
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
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColors.parchment),
                      ),
                    ),
                    child: Text(
                      'Generado con CantorApp${hojita.parroquiaNombre != null ? ' • ${hojita.parroquiaNombre}' : ''}',
                      style: GoogleFonts.crimsonPro(
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        color: AppColors.textMuted,
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
                    emoji: '📄',
                    color: AppColors.navyDeep,
                    textColor: AppColors.white,
                    onTap: () => _exportPdf(context, hojita),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ExportButton(
                    label: 'WhatsApp',
                    emoji: '💬',
                    color: AppColors.whatsappGreen,
                    textColor: AppColors.white,
                    onTap: () => _sharePdf(context, hojita),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ExportButton(
                    label: 'Más',
                    emoji: '📤',
                    color: AppColors.creamDark,
                    textColor: AppColors.navyDeep,
                    borderColor: AppColors.parchment,
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
      final pdfBytes = await PdfGenerator.generateHojitaPdf(hojita);
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
      final pdfBytes = await PdfGenerator.generateHojitaPdf(hojita);
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
}

class _ExportButton extends StatelessWidget {
  final String label;
  final String emoji;
  final Color color;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback onTap;

  const _ExportButton({
    required this.label,
    required this.emoji,
    required this.color,
    required this.textColor,
    this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: borderColor != null
              ? Border.all(color: borderColor!)
              : null,
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.crimsonPro(
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
