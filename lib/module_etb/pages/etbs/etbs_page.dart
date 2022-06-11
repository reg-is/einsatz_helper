import 'package:einsatz_helper/module_etb/utils/data_box.dart';
import 'package:einsatz_helper/module_etb/pages/entries/entries_page.dart';
import 'package:einsatz_helper/module_etb/model/etb_data.dart';
import 'package:einsatz_helper/module_etb/model/etb_entry_data.dart';
import 'package:einsatz_helper/module_etb/utils/pdf_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../utils/theme.dart';
import 'new_etb_page.dart';
import '../../utils/global_variables.dart' as globals;
import '../../widgets/etb-status-Chip.dart';

/// Page handling the overview of all ETBS
class ETBsPage extends StatelessWidget {
  const ETBsPage({Key? key}) : super(key: key);

  /// Build view with a list of all ETBs
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einsatztagebücher'),
        actions: [
          // Search button
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Funktion noch nicht implementiert.')));
              },
              icon: const FaIcon(Ionicons.search)),
        ],
        // Navigation Drawer button
        leading: IconButton(
            onPressed: () {
              globals.scaffoldKey.currentState?.openDrawer();
            },
            icon: const FaIcon(Ionicons.menu)),
      ),
      // List of ETBs
      body: ValueListenableBuilder<Box<ETBData>>(
        valueListenable: DataBox.getETBs().listenable(),
        builder: (context, box, _) {
          final etbs = box.values.toList().cast<ETBData>();
          return buildETBListView(context, etbs);
        },
      ),
      // Button to create new ETBs
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewETBPage()))),
    );
  }

  /// Build a ListView with ETBs from [etbs]
  Widget buildETBListView(context, List<ETBData> etbs) {
    // Check if ETBs exist
    if (etbs.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display informativ text if there ar no ETBs
            const Center(
              child: Text(
                'Es wurden noch keine Einsatztagebücher erstellt.',
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
      // Display a ListView of ETB overview cards
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

  /// Delete [etb] with all its entries.
  /// Shows confirmation Dialog before deleting.
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

  /// Build a Card Widget with key information of [etb]
  Widget buildETBOverviewCard(context, ETBData etb, dynamic etbKey) => InkWell(
        // Open EntriesPage when taped
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EntriesPage(
                        etbKey: etbKey,
                        noDrawer: true,
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
                // First Row on Card with ETB-Number, ETB-Name and ETB-Status
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text('ETB: ' + etb.id.toString()),
                      visualDensity:
                          const VisualDensity(horizontal: 0.0, vertical: -4),
                      padding: const EdgeInsets.all(0),
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
                    etbStatusChip(etb.finished, context),
                  ],
                ),
                // Second Row with start date, leader and ETB writer
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
                // Third Row with information and actin chips
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Chip(
                      label: Text('${etb.entries?.length} Einträge'),
                      elevation: 1.0,
                      visualDensity:
                          const VisualDensity(horizontal: 0.0, vertical: -4),
                      labelPadding: const EdgeInsets.all(1)
                          .copyWith(right: 8, top: 0, bottom: 0),
                      avatar: FaIcon(
                        Ionicons.file_tray_full,
                        color:
                            Theme.of(context).indicatorColor.withOpacity(0.8),
                        size: 16,
                      ),
                      labelStyle:
                          TextStyle(color: Theme.of(context).indicatorColor),
                      backgroundColor: Theme.of(context).dividerColor,
                    ),
                    Chip(
                      label: Text('${etb.attachmentsSum} Anlagen'),
                      elevation: 1.0,
                      visualDensity:
                          const VisualDensity(horizontal: 0.0, vertical: -4),
                      labelPadding: const EdgeInsets.all(1)
                          .copyWith(right: 8, top: 0, bottom: 0),
                      avatar: FaIcon(
                        Ionicons.attach,
                        color:
                            Theme.of(context).indicatorColor.withOpacity(0.8),
                        size: 16,
                      ),
                      labelStyle:
                          TextStyle(color: Theme.of(context).indicatorColor),
                      backgroundColor: Theme.of(context).dividerColor,
                    ),
                    ActionChip(
                      label: const Text('Exportieren'),
                      elevation: 1.0,
                      visualDensity:
                          const VisualDensity(horizontal: 0.0, vertical: -4),
                      labelPadding: const EdgeInsets.all(1)
                          .copyWith(right: 8, top: 0, bottom: 0),
                      avatar: const FaIcon(
                        Ionicons.share,
                        size: 16,
                      ),
                      onPressed: () async {
                        final data = await PdfService.createEtbPdf(etb);
                        PdfService.savePdfFile(
                            'ETB_${etb.id}_${etb.startedDateAsDTG.replaceAll(' ', '')}',
                            data);
                      },
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
