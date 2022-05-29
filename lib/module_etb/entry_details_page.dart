import 'package:einsatz_helper/module_etb/model/etb_entry_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../theme.dart';

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
            //IconButton(
            //    onPressed: () {}, icon: const FaIcon(Ionicons.color_palette))
          ],
        ),
        body: ListView(
          children: [
            buildDetailsCard(
              context,
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
                ? buildDetailsCard(context,
                    title: const Text('Datum / Uhrzeit'),
                    details: Text('Erfassungszeit: ${entry.captureTimeAsDTG}'
                        '\nEreigniszeit: ${entry.eventTimeAsDTG}'))
                : buildDetailsCard(context,
                    title: const Text('Datum / Uhrzeit'),
                    details: Text('Erfassungszeit: ${entry.captureTimeAsDTG}')),
            if (entry.counterpart != null)
              buildDetailsCard(
                context,
                title: const Text('Gegenstelle'),
                details: Text(entry.counterpart!),
              ),
            buildDetailsCard(context,
                title: const Text('Darstellung des Ereignisses'),
                details: Text(entry.description)),
            if (entry.comment != null)
              buildDetailsCard(context,
                  title: const Text('Bemerkung'),
                  //details: Text('Anlagen: 2 (Nr. 42-3-1, 42-3-2)')),
                  details: Text(entry.comment!)),
            // buildDetailsCard(
            //     title: const Text('Digitale Anlagen'), details: Text('Todo')),
            if (entry.reference != null)
              buildDetailsCard(context,
                  title: const Text('Referenz'),
                  details: Text(entry.reference!.toString())),
            buildDetailsCard(
              context,
              details: Column(
                children: [
                  const Text(
                      'Neuen Eintrag erstellen und diesen referenzieren.'),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Funktion noch nicht implementiert.')));
                    },
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
Widget buildDetailsCard(BuildContext context,
        {Widget? title, Widget? details}) =>
    Card(
      shape: MyThemes.myCardBorder(context),
      child: ListTile(
        title: title,
        subtitle: details,
      ),
    );
