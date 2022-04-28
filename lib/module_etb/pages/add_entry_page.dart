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
      body: ListView(children: [
        Center(
            child: ElevatedButton(
                onPressed: () {}, child: Text('Aus Vorlage erstellen'))),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Name',
            hintText: 'Hint',
            //label: Text('Label'),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            //labelText: 'Name',
            hintText: 'Hint',
            label: Text('Label'),
          ),
        )
      ]),
    );
  }
}
