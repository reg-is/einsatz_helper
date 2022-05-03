import 'package:einsatz_helper/module_etb/data_box.dart';
import 'package:einsatz_helper/module_etb/model/etb_data.dart';
import 'package:einsatz_helper/module_etb/model/etb_entry_data.dart';
import 'package:einsatz_helper/module_etb/pages/add_entry_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:einsatz_helper/module_etb/entry_details_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EntriesPage extends StatelessWidget {
  const EntriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
  dynamic etbKey = DataBox.getETBs().values.last.key;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Einträge'),
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Filter pressed')));
              },
              icon: Icon(Ionicons.funnel)),
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Search pressed')));
              },
              icon: Icon(Ionicons.search)),
        ],
      ),
      body: buildEntriesListView(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddEntryPage(etbKey)));
          // Todo
        },
        child: const Icon(Icons.add),
        //child: const Icon(Feather.plus),
        //child: const Icon(Ionicons.add),
        //child: const Icon(Fontisto.bookmark),
      ),
    );
  }

  Widget buildEntriesListView(context) {
    return ValueListenableBuilder<Box<ETBData>>(
        valueListenable: DataBox.getETBs().listenable(),
        builder: (context, box, _) {
          final etbs = box.values.toList().cast<ETBData>();
          if (etbs.isEmpty) {
            return const Center(
              child: Text(
                'Es wurde noch kein Einsatztagebuch erstellt.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            final entries = etbs.last.entries?.cast<ETBEntryData>().reversed.toList();
            if (entries == null || entries.isEmpty) {
              return const Center(
                child: Text(
                  'Einsatztagebuch enthält noch keine Einträge.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildEntryCard(context, entries[index]);
                  });
            }
          }
        });
  }

// Builds a Card Widget for an ETB Entry
  Widget buildEntryCard(BuildContext context, ETBEntryData entry) => InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EntryDetailsPage(entry)));
        },
        child: Card(
          elevation: 2,
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
                    //const Spacer(),
                    // Chip with the number of attachments of the entry
                    buildAttachmentsChip(0),
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

// Build a Chip depending on number of attachments an entry has
  Widget buildAttachmentsChip(int attachments) {
    if (attachments > 0) {
      return Chip(
        visualDensity: const VisualDensity(horizontal: 0.0, vertical: -4),
        labelPadding:
            const EdgeInsets.all(1).copyWith(right: 8, top: 0, bottom: 0),
        avatar: const Icon(
          Ionicons.attach,
          size: 16,
        ),
        label: (attachments == 1)
            ? Text(attachments.toString() + ' Anlage')
            : Text(attachments.toString() + ' Anlagen'),
        //labelStyle: TextStyle(color: Colors.white),
        //backgroundColor: Theme.of(context).unselectedWidgetColor,
        elevation: 1.0,
        //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    } else {
      // Display no Attachment Chip if there are no Attachments
      return const SizedBox.shrink();
    }
  }
}
