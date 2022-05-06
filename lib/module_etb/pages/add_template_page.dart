import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class AddTemplatePage extends StatefulWidget {
  const AddTemplatePage({Key? key}) : super(key: key);

  @override
  State<AddTemplatePage> createState() => _AddTemplatePageState();
}

class _AddTemplatePageState extends State<AddTemplatePage> {
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
              onPressed: () {
                bool result = onPressAccept();
                if (result) {
                  Navigator.pop(context, 'Save');
                }
              },
              icon: const Icon(Ionicons.checkmark_circle)),
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
        buildNewTemplateForm(context),
      ]),
    );
  }

  Widget buildNewTemplateForm(BuildContext context) {
    return Text('Hello');
  }

  bool onPressAccept() {
    return false;
  }
}
