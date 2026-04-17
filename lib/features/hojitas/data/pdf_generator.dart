import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:cantor_app/features/hojitas/domain/hojita.dart';
import 'package:intl/intl.dart';

/// Sección parseada de una letra (Coro, Estrofa 1, etc.)
class _LetraSection {
  final String tag;
  final String text;
  const _LetraSection({required this.tag, required this.text});
}

class PdfGenerator {
  /// Genera el PDF de una hojita con las letras de los cantos.
  ///
  /// [letrasMap] mapea cantoUuid → texto de la letra.
  /// Estrategia para cumplir el límite de 2 páginas:
  ///  1. Intenta con letras completas (coro + estrofas).
  ///  2. Si excede 2 páginas → solo coro de cada canto.
  ///  3. Si aún excede → trunca forzosamente a 2 páginas.
  static Future<Uint8List> generateHojitaPdf(
    Hojita hojita,
    Map<String, String> letrasMap,
  ) async {
    final regular = await PdfGoogleFonts.crimsonProRegular();
    final bold = await PdfGoogleFonts.crimsonProBold();
    final italic = await PdfGoogleFonts.crimsonProItalic();
    final titleBold = await PdfGoogleFonts.playfairDisplayBold();
    final titleItalic = await PdfGoogleFonts.playfairDisplayItalic();

    final navy = PdfColor.fromHex('#1A2744');
    final gold = PdfColor.fromHex('#C9973A');
    final textClr = PdfColor.fromHex('#1A1A2E');
    final muted = PdfColor.fromHex('#6B6B7A');

    final fechaStr =
        DateFormat("d 'de' MMMM, yyyy", 'es').format(hojita.fecha);

    // Closure que construye el documento con una configuración dada.
    pw.Document buildDoc({
      required bool coroOnly,
      int maxPages = 100,
    }) {
      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(
              horizontal: 36, vertical: 28),
          maxPages: maxPages,
          header: (ctx) {
            if (ctx.pageNumber > 1) {
              return pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 8),
                child: pw.Row(
                  mainAxisAlignment:
                      pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      hojita.titulo,
                      style: pw.TextStyle(
                          font: titleBold,
                          fontSize: 10,
                          color: navy),
                    ),
                    pw.Text(
                      'Pág. ${ctx.pageNumber}',
                      style: pw.TextStyle(
                          font: regular,
                          fontSize: 8,
                          color: muted),
                    ),
                  ],
                ),
              );
            }
            return _buildHeader(
              hojita: hojita,
              fechaStr: fechaStr,
              titleBold: titleBold,
              titleItalic: titleItalic,
              regular: regular,
              navy: navy,
              gold: gold,
            );
          },
          footer: (ctx) => pw.Container(
            alignment: pw.Alignment.center,
            padding: const pw.EdgeInsets.only(top: 6),
            child: pw.Text(
              'Generado con CantorApp'
              '${hojita.parroquiaNombre != null ? ' · ${hojita.parroquiaNombre}' : ''}',
              style: pw.TextStyle(
                  font: italic, fontSize: 8, color: muted),
            ),
          ),
          build: (ctx) => _buildSongs(
            hojita: hojita,
            letrasMap: letrasMap,
            coroOnly: coroOnly,
            regular: regular,
            bold: bold,
            italic: italic,
            titleBold: titleBold,
            navy: navy,
            gold: gold,
            textClr: textClr,
            muted: muted,
          ),
        ),
      );

      return pdf;
    }

    // Intento 1: letras completas
    var pdf = buildDoc(coroOnly: false);
    var bytes = await pdf.save();
    if (pdf.document.pdfPageList.pages.length <= 2) return bytes;

    // Intento 2: solo coro
    pdf = buildDoc(coroOnly: true);
    bytes = await pdf.save();
    if (pdf.document.pdfPageList.pages.length <= 2) return bytes;

    // Intento 3: forzar máximo 2 páginas
    pdf = buildDoc(coroOnly: true, maxPages: 2);
    return pdf.save();
  }

  // ─── Header (solo página 1) ────────────────────────────────────

  static pw.Widget _buildHeader({
    required Hojita hojita,
    required String fechaStr,
    required pw.Font titleBold,
    required pw.Font titleItalic,
    required pw.Font regular,
    required PdfColor navy,
    required PdfColor gold,
  }) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12),
      padding:
          const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: pw.BoxDecoration(
        color: navy,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          pw.Text('✝',
              style: pw.TextStyle(
                  font: titleBold, fontSize: 20, color: gold)),
          if (hojita.parroquiaNombre != null &&
              hojita.parroquiaNombre!.isNotEmpty) ...[
            pw.SizedBox(height: 2),
            pw.Text(
              hojita.parroquiaNombre!.toUpperCase(),
              style: pw.TextStyle(
                font: regular,
                fontSize: 8,
                color: PdfColors.white,
                letterSpacing: 2,
              ),
            ),
          ],
          pw.SizedBox(height: 5),
          pw.Text(
            hojita.titulo,
            style: pw.TextStyle(
                font: titleBold, fontSize: 16, color: PdfColors.white),
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 3),
          pw.Text(
            fechaStr,
            style: pw.TextStyle(
                font: titleItalic, fontSize: 10, color: gold),
          ),
          pw.SizedBox(height: 4),
          pw.Container(height: 0.5, color: gold),
        ],
      ),
    );
  }

  // ─── Contenido: lista de cantos con letras ─────────────────────

  static List<pw.Widget> _buildSongs({
    required Hojita hojita,
    required Map<String, String> letrasMap,
    required bool coroOnly,
    required pw.Font regular,
    required pw.Font bold,
    required pw.Font italic,
    required pw.Font titleBold,
    required PdfColor navy,
    required PdfColor gold,
    required PdfColor textClr,
    required PdfColor muted,
  }) {
    final widgets = <pw.Widget>[];

    for (int i = 0; i < hojita.cantos.length; i++) {
      final item = hojita.cantos[i];
      final numero = i + 1;
      final letra = letrasMap[item.cantoUuid];

      // ── Título del canto ──
      widgets.add(
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 6, bottom: 2),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                width: 20,
                height: 20,
                decoration: pw.BoxDecoration(
                    color: gold, shape: pw.BoxShape.circle),
                alignment: pw.Alignment.center,
                child: pw.Text('$numero',
                    style: pw.TextStyle(
                        font: bold,
                        fontSize: 9,
                        color: PdfColors.white)),
              ),
              pw.SizedBox(width: 6),
              pw.Expanded(
                child: pw.Text(item.cantoTitulo,
                    style: pw.TextStyle(
                        font: bold, fontSize: 11, color: navy)),
              ),
              pw.Text(_categoriaLabel(item.cantoCategoria),
                  style: pw.TextStyle(
                      font: italic, fontSize: 7.5, color: muted)),
            ],
          ),
        ),
      );

      // ── Autor ──
      widgets.add(
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 26, bottom: 3),
          child: pw.Text(item.cantoAutor,
              style: pw.TextStyle(
                  font: italic, fontSize: 7.5, color: muted)),
        ),
      );

      // ── Letra ──
      if (letra != null && letra.isNotEmpty) {
        final sections = _parseLetra(letra);
        final displaySections = coroOnly
            ? sections.where((s) => s.tag == 'C').toList()
            : sections;

        for (final section in displaySections) {
          final label = _sectionLabel(section.tag);
          widgets.add(
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 26, bottom: 2),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (label.isNotEmpty)
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 1),
                      child: pw.Text(label,
                          style: pw.TextStyle(
                              font: bold,
                              fontSize: 7.5,
                              color: gold)),
                    ),
                  pw.Text(
                    section.text,
                    style: pw.TextStyle(
                      font: regular,
                      fontSize: 8,
                      color: textClr,
                      lineSpacing: 1.2,
                    ),
                  ),
                  pw.SizedBox(height: 2),
                ],
              ),
            ),
          );
        }
      }

      // ── Separador entre cantos ──
      if (i < hojita.cantos.length - 1) {
        widgets.add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(
                left: 26, right: 10, top: 3, bottom: 3),
            child: pw.Divider(color: gold, thickness: 0.3),
          ),
        );
      }
    }

    // ── Notas ──
    if (hojita.notas != null && hojita.notas!.isNotEmpty) {
      widgets.add(pw.SizedBox(height: 8));
      widgets.add(
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: gold, width: 0.5),
            borderRadius: pw.BorderRadius.circular(4),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Notas:',
                  style: pw.TextStyle(
                      font: bold, fontSize: 8, color: navy)),
              pw.SizedBox(height: 2),
              pw.Text(hojita.notas!,
                  style: pw.TextStyle(
                      font: regular, fontSize: 7.5, color: muted)),
            ],
          ),
        ),
      );
    }

    return widgets;
  }

  // ─── Parser de letras ──────────────────────────────────────────

  static List<_LetraSection> _parseLetra(String letra) {
    final regex = RegExp(r'\{(C|E\d+|P|Puente|Final)\}');
    final matches = regex.allMatches(letra).toList();
    final sections = <_LetraSection>[];

    for (int i = 0; i < matches.length; i++) {
      final tag = matches[i].group(1)!;
      final start = matches[i].end;
      final end =
          i + 1 < matches.length ? matches[i + 1].start : letra.length;
      final text = letra.substring(start, end).trim();
      if (text.isNotEmpty) {
        sections.add(_LetraSection(tag: tag, text: text));
      }
    }

    // Si no hay marcadores, tratar todo el texto como una sola sección
    if (sections.isEmpty && letra.trim().isNotEmpty) {
      sections.add(_LetraSection(tag: '', text: letra.trim()));
    }

    return sections;
  }

  static String _sectionLabel(String tag) {
    if (tag == 'C') return 'Coro';
    if (tag == 'P') return 'Pre-coro';
    if (tag == 'Puente') return 'Puente';
    if (tag == 'Final') return 'Final';
    if (tag.startsWith('E')) return 'Estrofa ${tag.substring(1)}';
    return '';
  }

  static String _categoriaLabel(String categoria) {
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
    return labels[categoria] ?? categoria;
  }
}
