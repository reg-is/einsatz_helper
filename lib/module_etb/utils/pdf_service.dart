import 'dart:io';
import 'dart:typed_data';

import 'package:einsatz_helper/module_etb/model/etb_data.dart';
import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../model/etb_entry_data.dart';

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
    List<EntryRow> rows = [
      EntryRow(
          id: 'Lfd.\nNr.',
          time: 'Datum / Uhrzeit',
          description: 'Darstellung der Ereignisse',
          comment: 'Bemerkung'),
    ];
    final List<ETBEntryData> entries = etb.entries ?? [];

    for (var entry in entries) {
      rows.add(EntryRow(
          id: entry.id.toString(),
          time: entry.captureTimeAsDTG,
          description: entry.description,
          comment: entry.comment ?? ''));
    }

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    children: [
                      pw.Text("Customer Name"),
                      pw.Text("Customer Address"),
                      pw.Text("Customer City"),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text("Max Weber"),
                      pw.Text("Weird Street Name 1"),
                      pw.Text("77662 Not my City"),
                      pw.Text("Vat-id: 123456"),
                      pw.Text("Invoice-Nr: 00001")
                    ],
                  )
                ],
              ),
              pw.SizedBox(height: 50),
              pw.Text(
                  "Dear Customer, thanks for buying at Flutter Explained, feel free to see the list of items below."),
              pw.SizedBox(height: 25),
              _itemColumn(rows),
              pw.Divider()
            ],
          );
        }));

    return pdf.save();
  }

  static pw.Expanded _itemColumn(List<EntryRow> elements) {
    return pw.Expanded(
      child: pw.Column(
        children: [
          for (var element in elements)
            pw.Row(
              children: [
                pw.Expanded(child: pw.Text(element.id, textAlign: pw.TextAlign.right)),
                pw.Expanded(child: pw.Text(element.time, textAlign: pw.TextAlign.center)),
                pw.Expanded(child: pw.Text(element.description, textAlign: pw.TextAlign.left), flex: 3),
                pw.Expanded(child: pw.Text(element.comment, textAlign: pw.TextAlign.left)),
              ],
            )
        ],
      ),
    );
  }

  // Source: https://github.com/md-weber/pdf_invoice_generator_flutter/blob/master/lib/invoice_service.dart
  static Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenDocument.openDocument(filePath: filePath);
  }
}

class EntryRow {
  late String id;
  late String time;
  late String description;
  late String comment;

  EntryRow(
      {required this.id,
      required this.time,
      required this.description,
      required this.comment});
}
