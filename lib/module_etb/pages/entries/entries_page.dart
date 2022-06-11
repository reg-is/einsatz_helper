import 'package:einsatz_helper/module_etb/utils/data_box.dart';
import 'package:einsatz_helper/module_etb/model/etb_data.dart';
import 'package:einsatz_helper/module_etb/model/etb_entry_data.dart';
import 'package:einsatz_helper/module_etb/pages/entries/add_entry_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:einsatz_helper/module_etb/pages/entries/entry_details_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../utils/theme.dart';
import '../../utils/global_variables.dart' as globals;
import '../../widgets/etb-status-Chip.dart';

/// Page showing a list of all entries contained inside a ETB with key [etbKey].
class EntriesPage extends StatefulWidget {
  late dynamic etbKey;
  bool noDrawer;

  EntriesPage({Key? key, this.etbKey, this.noDrawer = false}) : super(key: key);

  @override
  State<EntriesPage> createState() => _EntriesPageState();
}

/// Dispose method that runs when EntriesPage is closed.
class _EntriesPageState extends State<EntriesPage> {
  @override
  void dispose() {
    // Rest the etbKey when Widget is disposed
    widget.etbKey = null;
    super.dispose();
  }

  /// Build page with a list of all entries of an ETB.
  @override
  Widget build(BuildContext context) {
    bool noETBs = DataBox.getETBs().values.isEmpty;
    widget.etbKey = (noETBs || widget.etbKey != null)
        ? widget.etbKey
        : DataBox.getETBs().values.last.key;
    ETBData? etb = DataBox.getETBByKey(widget.etbKey);
    bool finished = (noETBs || etb == null) ? true : etb.finished;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einträge'),
        elevation: 1,
        leading: (!widget.noDrawer)
            ? IconButton(
                onPressed: () {
                  globals.scaffoldKey.currentState?.openDrawer();
                },
                icon: const FaIcon(Ionicons.menu))
            : null,
        actions: [
          // Filter button
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Funktion noch nicht implementiert.')));
              },
              icon: const FaIcon(Ionicons.funnel)),
          // Search button
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Funktion noch nicht implementiert.')));
              },
              icon: const FaIcon(Ionicons.search)),
        ],
      ),
      body: buildEntriesListView(context, widget.etbKey, noETBs),
      // Button to create new Entry. Don't show if ETB is finished.
      floatingActionButton: Visibility(
        visible: (!noETBs && !finished),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddEntryPage(widget.etbKey)))
                .then((value) {
              // Reload entries page when coming back from creating a new entry.
              setState(() {});
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  /// Build a ListView with entries from etb with key [etbKey].
  Widget buildEntriesListView(
      BuildContext context, dynamic etbKey, bool noETBs) {
    return ValueListenableBuilder<Box<ETBData>>(
        valueListenable: DataBox.getETBs().listenable(),
        builder: (context, box, _) {
          // If no ETB exists
          if (noETBs) {
            return const Center(
              child: Text(
                'Es wurden noch keine Einsatztagebücher erstellt.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            final ETBData? etb = DataBox.getETBByKey(etbKey);
            final entries =
                etb?.entries?.cast<ETBEntryData>().reversed.toList();
            // If ETB has no entry
            if (etb == null || entries == null || entries.isEmpty) {
              return const Center(
                child: Text(
                  'Einsatztagebuch enthält noch keine Einträge.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              // If ETB exists and has entries.
              return ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: entries.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Container(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 12, right: 12),
                        color: Theme.of(context).cardColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Chip with the number of the ETB.
                            Chip(
                              visualDensity: const VisualDensity(
                                  horizontal: 0.0, vertical: -4),
                              padding: const EdgeInsets.all(0),
                              label: Text('ETB: ' + etb.id.toString()),
                              labelStyle: TextStyle(
                                  color: Theme.of(context).indicatorColor),
                              backgroundColor: Theme.of(context).dividerColor,
                              elevation: 1.0,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            // Name of the ETB
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Text(
                                  etb.name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ),
                            etbStatusChip(etb.finished, context),
                          ],
                        ),
                      );
                    }
                    index -= 1;
                    return buildEntryCard(context, entries[index]);
                  });
            }
          }
        });
  }

  /// Builds a Card Widget for [entry].
  Widget buildEntryCard(BuildContext context, ETBEntryData entry) => InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EntryDetailsPage(entry)));
        },
        child: Card(
          shape: MyThemes.myCardBorder(context),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 4,
              runSpacing: 1,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Chip with the number of the ETB-Entry
                    Chip(
                      visualDensity:
                          const VisualDensity(horizontal: 0.0, vertical: -4),
                      padding: const EdgeInsets.all(0),
                      label: Text(entry.id.toString()),
                      labelStyle:
                          TextStyle(color: Theme.of(context).indicatorColor),
                      backgroundColor: Theme.of(context).dividerColor,
                      elevation: 1.0,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    // Text box with the date and time of the entry
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          entry.captureTimeAsDTG,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    // Chip with the number of attachments of the entry
                    buildAttachmentsChip((entry.attachments == null)
                        ? 0
                        : entry.attachments!.length),
                  ],
                ),
                // Text box with the content of the entry
                Text(
                  entry.description,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      );

  /// Build Chip with number of [attachments] if [attachments] > 0.
  Widget buildAttachmentsChip(int attachments) {
    if (attachments > 0) {
      // Return Chip with number of attachments
      return Chip(
        visualDensity: const VisualDensity(horizontal: 0.0, vertical: -4),
        labelPadding:
            const EdgeInsets.all(1).copyWith(right: 8, top: 0, bottom: 0),
        avatar: const FaIcon(
          Ionicons.attach,
          size: 16,
        ),
        label: (attachments == 1)
            ? Text(attachments.toString() + ' Anlage')
            : Text(attachments.toString() + ' Anlagen'),
        elevation: 1.0,
      );
    } else {
      // Return nothing
      return const SizedBox.shrink();
    }
  }
}
