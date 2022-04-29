import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class AddEntryPage extends StatelessWidget {
  const AddEntryPage({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    DateTime captureTime = DateTime.now();
    String captureTimeAsString = captureTime.toString().substring(0,16);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eintrag anlegen'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Ionicons.close_circle)),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Ionicons.checkmark_circle)),
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
        Wrap(spacing: 8, runSpacing: 8, children: [
          Center(
              child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Aus Vorlage erstellen'))),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Ereigniszeit',
            ),
            enabled: false,
            initialValue: captureTimeAsString,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Erfassungszeit',
              hintText: 'Hint',
            ),
            keyboardType: TextInputType.datetime,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Gegenstelle',
              //hintText: 'Hint',
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Darstellung des Ereignis',
              //hintText: 'Hint',
            ),
            minLines: 4,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            validator: (description) =>
                description != null && description.isEmpty
                    ? 'Füge eine Beschreibung hinzu'
                    : null,
          ),
          Center(
              child: ElevatedButton(
                  onPressed: () {}, child: const Text('Anlage hinzufügen'))),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Bemerkung',
              //hintText: 'Hint',
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Referenz',
              //hintText: 'Hint',
            ),
          ),
          Center(
            child: Wrap(
              //mainAxisAlignment: MainAxisAlignment.center,
              runSpacing: 8,
              spacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('Verwerfen'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, 'Save'),
                  child: const Text('Eintrag speichern'),
                ),
              ],
            ),
          )
        ])
      ]),
    );
  }
}
