import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:cantor_app/features/hojitas/domain/hojita.dart';
import 'package:intl/intl.dart';

class PdfGenerator {
  static Future<Uint8List> generateHojitaPdf(Hojita hojita) async {
    final fontRegular = await PdfGoogleFonts.playfairDisplayRegular();
    final fontBold = await PdfGoogleFonts.playfairDisplayBold();
    final fontItalic = await PdfGoogleFonts.playfairDisplayItalic();
    final bodyFont = await PdfGoogleFonts.crimsonProRegular();
    final bodyFontBold = await PdfGoogleFonts.crimsonProBold();

    final navyColor = PdfColor.fromHex('#1A2744');
    final goldColor = PdfColor.fromHex('#C9973A');
    final textColor = PdfColor.fromHex('#1A1A2E');
    final mutedColor = PdfColor.fromHex('#6B6B7A');

    final dateFormat = DateFormat('d \'de\' MMMM, yyyy', 'es');
    final fechaStr = dateFormat.format(hojita.fecha);

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        header: (context) => _buildHeader(
          hojita: hojita,
          fechaStr: fechaStr,
          fontBold: fontBold,
          fontItalic: fontItalic,
          bodyFont: fontRegular,
          navyColor: navyColor,
          goldColor: goldColor,
        ),
        footer: (context) => _buildFooter(
          hojita: hojita,
          bodyFont: bodyFont,
          mutedColor: mutedColor,
        ),
        build: (context) => [
          pw.SizedBox(height: 20),
          ...hojita.cantos.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final item = entry.value;
            return pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 12),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 28,
                    height: 28,
                    decoration: pw.BoxDecoration(
                      color: goldColor,
                      shape: pw.BoxShape.circle,
                    ),
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      '$index',
                      style: pw.TextStyle(
                        font: fontBold,
                        fontSize: 14,
                        color: PdfColors.white,
                      ),
                    ),
                  ),
                  pw.SizedBox(width: 12),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          item.cantoTitulo,
                          style: pw.TextStyle(
                            font: bodyFontBold,
                            fontSize: 15,
                            color: textColor,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Row(
                          children: [
                            pw.Text(
                              item.cantoAutor,
                              style: pw.TextStyle(
                                font: bodyFont,
                                fontSize: 11,
                                color: mutedColor,
                              ),
                            ),
                            pw.SizedBox(width: 12),
                            pw.Text(
                              _categoriaLabel(item.cantoCategoria),
                              style: pw.TextStyle(
                                font: fontItalic,
                                fontSize: 11,
                                color: mutedColor,
                              ),
                            ),
                          ],
                        ),
                        if (item.tonalidad != null &&
                            item.tonalidad!.isNotEmpty)
                          pw.Text(
                            'Tonalidad: ${item.tonalidad}',
                            style: pw.TextStyle(
                              font: bodyFont,
                              fontSize: 10,
                              color: goldColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          if (hojita.notas != null && hojita.notas!.isNotEmpty) ...[
            pw.SizedBox(height: 16),
            pw.Divider(color: goldColor, thickness: 0.5),
            pw.SizedBox(height: 8),
            pw.Text(
              'Notas:',
              style: pw.TextStyle(
                font: bodyFontBold,
                fontSize: 12,
                color: textColor,
              ),
            ),
            pw.Text(
              hojita.notas!,
              style: pw.TextStyle(
                font: bodyFont,
                fontSize: 11,
                color: mutedColor,
              ),
            ),
          ]
        ],
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader({
    required Hojita hojita,
    required String fechaStr,
    required pw.Font fontBold,
    required pw.Font fontItalic,
    required pw.Font bodyFont,
    required PdfColor navyColor,
    required PdfColor goldColor,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: navyColor,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            '✝',
            style: pw.TextStyle(
              font: fontBold,
              fontSize: 28,
              color: goldColor,
            ),
          ),
          pw.SizedBox(height: 4),
          if (hojita.parroquiaNombre != null &&
              hojita.parroquiaNombre!.isNotEmpty)
            pw.Text(
              hojita.parroquiaNombre!.toUpperCase(),
              style: pw.TextStyle(
                font: bodyFont,
                fontSize: 10,
                color: PdfColors.white,
                letterSpacing: 2,
              ),
            ),
          pw.SizedBox(height: 8),
          pw.Text(
            hojita.titulo,
            style: pw.TextStyle(
              font: fontBold,
              fontSize: 22,
              color: PdfColors.white,
            ),
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            fechaStr,
            style: pw.TextStyle(
              font: fontItalic,
              fontSize: 12,
              color: goldColor,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Container(
            height: 1,
            decoration: pw.BoxDecoration(
              gradient: pw.LinearGradient(
                colors: [
                  PdfColor.fromHex('#1A274400'),
                  goldColor,
                  PdfColor.fromHex('#1A274400'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildFooter({
    required Hojita hojita,
    required pw.Font bodyFont,
    required PdfColor mutedColor,
  }) {
    return pw.Container(
      alignment: pw.Alignment.center,
      padding: const pw.EdgeInsets.only(top: 8),
      child: pw.Text(
        'Generado con CantorApp${hojita.parroquiaNombre != null ? ' • ${hojita.parroquiaNombre}' : ''}',
        style: pw.TextStyle(
          font: bodyFont,
          fontSize: 9,
          color: mutedColor,
          fontStyle: pw.FontStyle.italic,
        ),
      ),
    );
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
