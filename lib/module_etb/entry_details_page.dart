import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class EntryDetailsPage extends StatelessWidget {
  //const EntryDetailsPage({ Key? key }) : super(key: key);
  final int entryID;
  final String tacticalTime;
  final String content;

  const EntryDetailsPage(this.entryID, this.tacticalTime, this.content,
      {Key? key})
      : super(key: key);

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
                  label: Text('$entryID'),
                  labelStyle:
                      TextStyle(color: Theme.of(context).indicatorColor),
                  backgroundColor: Theme.of(context).dividerColor,
                  elevation: 1.0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ]),
            ),
            buildDetailsCard(
                title: const Text('Datum / Uhrzeit'),
                details: Text(
                    'Erfassungszeit: 261840Feb22\nEreignisszeit: 261820Feb22')),
            buildDetailsCard(
                title: const Text('Gegenstelle'),
                details: Text('Erkundungstrupp')),
            buildDetailsCard(
                title: const Text('Darstellung des Ereignis'),
                details: Text(content)),
            buildDetailsCard(
                title: const Text('Bemerkung'),
                details: Text('Anlagen: 2 (Nr. 42-3-1, 42-3-2)')),
            buildDetailsCard(
                title: const Text('Digitale Anlagen'), details: Text('Todo')),
            buildDetailsCard(
              details: Column(
                children: [
                  const Text(
                      'Neuen Eintrag erstellen und diesen referenzieren.'),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Referenziern'),
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
