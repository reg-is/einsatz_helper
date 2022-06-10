import 'dart:io';
import 'dart:typed_data';

import 'package:einsatz_helper/module_etb/model/etb_data.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  static Future<Uint8List> createHelloWord() {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(child: pw.Text('Hello'));
    }));
    return pdf.save();
  }

  static Future<Uint8List> createEtbPdf(ETBData etb) {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(1 * PdfPageFormat.cm),
      header: (pw.Context context) => buildHeader(etb, context),
      build: (pw.Context context) => [
        buildEntriesTable(etb),
      ],
      footer: (pw.Context context) => buildFooter(etb),
    ));

    return pdf.save();
  }

  static pw.Widget buildEntriesTable(ETBData etb) {
    final headers = [
      'Lfd.\nNr.',
      'Datum /\nUhrzeit',
      'Darstellung der Ereignisse',
      'Bemerkung'
    ];

    final data = etb.entries!.map((entry) {
      return [
        entry.id.toString(),
        entry.captureTimeAsDTG.replaceAll(' ', ''),
        entry.description,
        entry.comment ?? ''
      ];
    }).toList();

    return pw.Table.fromTextArray(
        headers: headers,
        headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        headerAlignment: pw.Alignment.topCenter,
        data: data,
        cellHeight: 0,
        columnWidths: const {
          0: pw.IntrinsicColumnWidth(),
          1: pw.IntrinsicColumnWidth(),
          2: pw.FlexColumnWidth(),
          3: pw.FixedColumnWidth(3 * PdfPageFormat.cm),
        },
        cellPadding: const pw.EdgeInsets.all(4),
        cellAlignments: const {
          0: pw.Alignment.topRight,
          1: pw.Alignment.topCenter,
          2: pw.Alignment.topLeft,
          3: pw.Alignment.topLeft,
        },
        border: pw.TableBorder.all(width: 0.5));
  }

  // Source: https://github.com/md-weber/pdf_invoice_generator_flutter/blob/master/lib/invoice_service.dart
  static Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    String filePath = '${output.path}/$fileName.pdf';
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFilex.open(filePath);
  }

  static pw.Widget buildHeader(ETBData etb, pw.Context context) {
    return pw.Column(
      children: [
        pw.Table(
            border: pw.TableBorder.all(width: 0.5),
            defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: pw.FractionColumnWidth(0.2),
              1: pw.FractionColumnWidth(0.6),
              2: pw.FractionColumnWidth(0.2),
            },
            children: [
              pw.TableRow(children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(4),
                  alignment: pw.Alignment.center,
                  child: pw.Text('ETB-Nr.: ${etb.id}'),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(4),
                  alignment: pw.Alignment.center,
                  color: PdfColors.grey300,
                  child: pw.Text('Einsatztagebuch',
                      style: pw.TextStyle(
                          fontSize: 16, fontWeight: pw.FontWeight.bold)),
                ),
                pw.Container(
                  // For Logo
                  padding: const pw.EdgeInsets.all(4),
                  alignment: pw.Alignment.center,
                  child: pw.Text(''),
                ),
              ])
            ]),
        pw.SizedBox(height: 3 * PdfPageFormat.mm),
        pw.Table(
            border: pw.TableBorder.all(width: 0.5),
            defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: pw.FlexColumnWidth(),
              1: pw.FractionColumnWidth(0.2),
              //1: pw.IntrinsicColumnWidth(),
            },
            children: [
              pw.TableRow(children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text('Einsatz: ${etb.name}'),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(
                      'Datum ${etb.startedDateFormatted('dd.MM.yyyy')}\n'
                      'Seite: ${context.pageNumber} von ${context.pagesCount}'),
                ),
              ])
            ]),
        pw.SizedBox(height: 3 * PdfPageFormat.mm),
      ],
    );
  }

  static pw.Widget buildFooter(ETBData etb) {
    return pw.Column(children: [
      //pw.SizedBox(height: 3 * PdfPageFormat.mm),
      pw.Container(
          height: 0.3 * PdfPageFormat.mm, color: const PdfColorGrey(0.5)),
      pw.SizedBox(height: 0.3 * PdfPageFormat.mm),
      pw.Container(
          height: 0.3 * PdfPageFormat.mm, color: const PdfColorGrey(0.5)),
      pw.SizedBox(height: 1.5 * PdfPageFormat.cm),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            child: pw.Center(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                      height: 0.5 * PdfPageFormat.mm,
                      width: 4 * PdfPageFormat.cm,
                      color: const PdfColorGrey(0.1)),
                  pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 2, right: 2),
                      child: pw.Text(etb.leader)),
                  pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 2, right: 2),
                      child: pw.Text('Führung',
                          style: const pw.TextStyle(
                              fontSize: 10, color: PdfColorGrey(0.5)))),
                ],
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Center(
                child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                    height: 0.5 * PdfPageFormat.mm,
                    width: 4 * PdfPageFormat.cm,
                    color: const PdfColorGrey(0.1)),
                pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 2, right: 2),
                    child: pw.Text(etb.etbWriter)),
                pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 2, right: 2),
                    child: pw.Text('ETB-Führung',
                        style: const pw.TextStyle(
                            fontSize: 10, color: PdfColorGrey(0.5))))
              ],
            )),
          ),
        ],
      ),
    ]);
  }
}
