import 'package:einsatz_helper/module_etb/data_box.dart';
import 'package:einsatz_helper/module_etb/entries_page.dart';
import 'package:einsatz_helper/module_etb/model/etb_data.dart';
import 'package:einsatz_helper/module_etb/model/etb_entry_data.dart';
import 'package:einsatz_helper/module_etb/utils/pdf_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../theme.dart';
import 'pages/new_etb_page.dart';

class ETBsPage extends StatelessWidget {
  const ETBsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).indicatorColor.withOpacity(0.1),
      appBar: AppBar(
        title: const Text('Einsatztagebücher'),
        actions: [
          IconButton(onPressed: () {}, icon: const FaIcon(Ionicons.search)),
        ],
      ),
      body: ValueListenableBuilder<Box<ETBData>>(
        valueListenable: DataBox.getETBs().listenable(),
        builder: (context, box, _) {
          final etbs = box.values.toList().cast<ETBData>();
          return buildETBListView(context, etbs);
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewETBPage()))),
    );
  }

  Widget buildETBListView(context, List<ETBData> etbs) {
    if (etbs.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Es wurden noch kein Einsatztagebücher erstellt.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              label: const Text('ETB erstellen'),
              icon: const FaIcon(Ionicons.add_outline),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewETBPage())),
            )
          ],
        ),
      );
    } else {
      var etbsReversed = List<ETBData>.from(etbs.reversed);
      return ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: etbs.length,
          itemBuilder: (BuildContext context, int index) {
            return buildETBOverviewCard(
                context, etbsReversed[index], etbsReversed[index].key);
          });
    }
  }

  Future addETB(String name, double amount, bool isExpense) async {
    final firstEntry = ETBEntryData()
      ..id = 1
      ..captureTime = DateTime.now()
      ..description = 'Einsatzbeginn\nTodo';
    //..eventTime = DateTime.now()
    //..counterpart = ''
    //..comment = ''
    //..reference = 0

    final etb = ETBData()
      ..name = name
      ..attachmentsSum = 0
      ..finished = isExpense
      ..id = amount.toInt()
      ..leader = 'Max Mustermann'
      ..etbWriter = 'Maxi Musterschreiber'
      ..startedDate = DateTime.now()
      ..entries = <ETBEntryData>[firstEntry];

    final etbDB = DataBox.getETBs();
    etbDB.add(etb); // Auto key
    //box.put('myKey', etb) // Individual key
  }

  // Delete a ETB with all its entries
  Future deleteETB(context, ETBData etb) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Einsatztagebuch löschen?'),
        content: Text(
            'Wollen Sie wirklich das Einsatztagebuch "${etb.name}" löschen?'),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              etb.delete();
              Navigator.pop(context, 'OK');
            },
            child: const Text('Löschen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Abbrechen'),
          ),
        ],
      ),
    );
  }

// Builds a Card Widget for an ETB Overview
  Widget buildETBOverviewCard(context, ETBData etb, dynamic etbKey) => InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EntriesPage(
                        etbKey: etbKey,
                      )));
        },
        child: Card(
          shape: MyThemes.myCardBorder(context),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 1,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      visualDensity:
                          const VisualDensity(horizontal: 0.0, vertical: -4),
                      padding: const EdgeInsets.all(0),
                      label: Text('ETB: ' + etb.id.toString()),
                      labelStyle:
                          TextStyle(color: Theme.of(context).indicatorColor),
                      backgroundColor: Theme.of(context).dividerColor,
                      elevation: 1.0,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          etb.name,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    //Spacer(),
                    buildETBStatusChip(etb.finished, context),
                  ],
                ),
                //SizedBox(height: 8,),
                Row(
                  children: [
                    const Text(
                      'Einsatzbeginn: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(etb.startedDateAsDTG),
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      'Führungskraft: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(etb.leader)
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      'ETB-Führung: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(etb.etbWriter)
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Chip(
                      visualDensity:
                          const VisualDensity(horizontal: 0.0, vertical: -4),
                      labelPadding: const EdgeInsets.all(1)
                          .copyWith(right: 8, top: 0, bottom: 0),
                      //padding: EdgeInsets.all(0),
                      avatar: FaIcon(
                        Ionicons.file_tray_full,
                        color:
                            Theme.of(context).indicatorColor.withOpacity(0.8),
                        size: 16,
                      ),
                      label: Text('${etb.entries?.length} Einträge'),
                      labelStyle:
                          TextStyle(color: Theme.of(context).indicatorColor),
                      backgroundColor: Theme.of(context).dividerColor,
                      elevation: 1.0,
                      //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    Chip(
                      visualDensity:
                          const VisualDensity(horizontal: 0.0, vertical: -4),
                      labelPadding: const EdgeInsets.all(1)
                          .copyWith(right: 8, top: 0, bottom: 0),
                      //padding: EdgeInsets.all(0),
                      avatar: FaIcon(
                        Ionicons.attach,
                        color:
                            Theme.of(context).indicatorColor.withOpacity(0.8),
                        size: 16,
                      ),
                      label: Text('${etb.attachmentsSum} Anlagen'),
                      labelStyle:
                          TextStyle(color: Theme.of(context).indicatorColor),
                      backgroundColor: Theme.of(context).dividerColor,
                      elevation: 1.0,
                      //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    ActionChip(
                      visualDensity:
                          const VisualDensity(horizontal: 0.0, vertical: -4),
                      labelPadding: const EdgeInsets.all(1)
                          .copyWith(right: 8, top: 0, bottom: 0),
                      avatar: const FaIcon(
                        Ionicons.share,
                        size: 16,
                      ),
                      label: const Text('Exportieren'),
                      onPressed: () async {
                        //final data = await PdfService.createHelloWord();
                        final data = await PdfService.createEtbPdf(etb);
                        PdfService.savePdfFile(
                            'ETB_${etb.id}_${etb.startedDateAsDTG}', data);
                      },
                      //labelStyle: TextStyle(color: Colors.white),
                      //backgroundColor: Theme.of(context).unselectedWidgetColor,
                      elevation: 1.0,
                      //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    ActionChip(
                      label: const Text('Löschen'),
                      onPressed: () => deleteETB(context, etb),
                      visualDensity:
                          const VisualDensity(horizontal: 0.0, vertical: -4),
                      labelPadding: const EdgeInsets.all(1)
                          .copyWith(right: 8, top: 0, bottom: 0),
                      avatar: const FaIcon(
                        Ionicons.trash,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

// Build a Chip depending on the current status ('Laufend' or 'Abgeschlossen') of the ETB
Chip buildETBStatusChip(bool finished, context) {
  if (finished) {
    return Chip(
      label: const Text('Abgeschlossen'),
      labelStyle: const TextStyle(color: Colors.white),
      backgroundColor: Theme.of(context).errorColor.withOpacity(0.7),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.all(2),
      elevation: 1.0,
    );
  } else {
    return Chip(
      label: const Text('Laufend'),
      labelStyle: const TextStyle(color: Colors.white),
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.all(2),
      elevation: 1.0,
    );
  }
}
