import 'package:einsatz_helper/module_etb/model/etb_entry_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class EntryDetailsPage extends StatelessWidget {
  //const EntryDetailsPage({ Key? key }) : super(key: key);
  final ETBEntryData entry;

  const EntryDetailsPage(this.entry, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Eintrag Details'),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Ionicons.color_palette))
          ],
        ),
        body: ListView(
          children: [
            buildDetailsCard(
              title: Row(children: [
                const Text('Laufende Nummer: '),
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
              ]),
            ),
            (entry.eventTimeAsDTG != '')
                ? buildDetailsCard(
                    title: const Text('Datum / Uhrzeit'),
                    details: Text('Erfassungszeit: ${entry.captureTimeAsDTG}'
                        '\nEreigniszeit: ${entry.eventTimeAsDTG}'))
                : buildDetailsCard(
                    title: const Text('Datum / Uhrzeit'),
                    details: Text('Erfassungszeit: ${entry.captureTimeAsDTG}')),
            if (entry.counterpart != null)
              buildDetailsCard(
                title: const Text('Gegenstelle'),
                details: Text(entry.counterpart!),
              ),
            buildDetailsCard(
                title: const Text('Darstellung des Ereignis'),
                details: Text(entry.description)),
            if (entry.comment != null)
              buildDetailsCard(
                  title: const Text('Bemerkung'),
                  //details: Text('Anlagen: 2 (Nr. 42-3-1, 42-3-2)')),
                  details: Text(entry.comment!)),
            buildDetailsCard(
                title: const Text('Digitale Anlagen'), details: Text('Todo')),
            if (entry.reference != null)
              buildDetailsCard(
                  title: const Text('Referenz'),
                  details: Text(entry.reference!.toString())),
            buildDetailsCard(
              details: Column(
                children: [
                  const Text(
                      'Neuen Eintrag erstellen und diesen referenzieren.'),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Referenzieren'),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

// Builds Card Widget for the details of an ETB Entry
Widget buildDetailsCard({Widget? title, Widget? details}) => Card(
      child: ListTile(
        title: title,
        subtitle: details,
      ),
    );
