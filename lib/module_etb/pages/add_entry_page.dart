import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class AddEntryPage extends StatelessWidget {
  const AddEntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        Center(
            child: ElevatedButton(
                onPressed: () {}, child: const Text('Aus Vorlage erstellen'))),
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
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Darstellung des Ereignis',
            //hintText: 'Hint',
          ),
        ),
        Center(
            child: ElevatedButton(
                onPressed: () {}, child: const Text('Anlage hinzufügen'))),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Bemerkung',
            //hintText: 'Hint',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Referenz',
            //hintText: 'Hint',
          ),
        ),
      ]),
    );
  }
}
