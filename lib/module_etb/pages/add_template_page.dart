import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../data_box.dart';
import '../model/template_data.dart';

class AddTemplatePage extends StatefulWidget {
  const AddTemplatePage({Key? key}) : super(key: key);

  @override
  State<AddTemplatePage> createState() => _AddTemplatePageState();
}

class _AddTemplatePageState extends State<AddTemplatePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vorlage anlegen'),
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
    return FormBuilder(
      key: _formKey,
      child: Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          FormBuilderTextField(
            name: 'name',
            decoration: const InputDecoration(
              labelText: 'Name der Vorlage*',
            ),
            validator: FormBuilderValidators.required(),
          ),
          FormBuilderTextField(
            name: 'counterpart',
            decoration: const InputDecoration(
              labelText: 'Gegenstelle',
            ),
          ),
          FormBuilderTextField(
            name: 'description',
            decoration: const InputDecoration(
              labelText: 'Darstellung des Ereignis',
            ),
            minLines: 4,
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          FormBuilderTextField(
            name: 'comment',
            decoration: const InputDecoration(
              labelText: 'Bemerkung',
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          Center(
            child: Wrap(
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
                  onPressed: () {
                    bool result = onPressAccept();
                    if (result) {
                      Navigator.pop(context, 'Save');
                    }
                  },
                  child: const Text('Vorlage speichern'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // Is called when user accepts the inputted data.
  bool onPressAccept() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print(_formKey.currentState!.value);
      addTemplate();
      return true;
    } else {
      print("validation failed");
      return false;
    }
  }

  // Get user input data from form, create a new template and append it to the templateBox
  Future addTemplate() async {
    // Get user input data from form
    final Map formInput = _formKey.currentState!.value;

    // Create a new entry with input from form
    final template = TemplateData()
      //..id = DataBox.getNextEntryID(widget.etbKey)
      ..name = formInput['name']
      ..counterpart = formInput['counterpart']
      ..description = formInput['description']
      ..comment = formInput['comment']
      ..creationTime = DateTime.now()
      ..modificationTime = DateTime.now();

    // Append new template in the templateBox
    DataBox.getTemplates().add(template);
  }
}
