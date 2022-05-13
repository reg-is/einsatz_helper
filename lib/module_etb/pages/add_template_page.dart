import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../data_box.dart';
import '../model/template_data.dart';

class AddTemplatePage extends StatefulWidget {
  dynamic templateKey;

  AddTemplatePage({Key? key, this.templateKey}) : super(key: key);

  @override
  State<AddTemplatePage> createState() => _AddTemplatePageState();
}

class _AddTemplatePageState extends State<AddTemplatePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    TemplateData? template = (widget.templateKey == null)
        ? null
        : DataBox.getTemplates().get(widget.templateKey);
    return Scaffold(
      appBar: (template == null)
          ? AppBar(
              title: const Text('Vorlage anlegen'),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const FaIcon(Ionicons.close_circle)),
              actions: [
                IconButton(
                    onPressed: () {
                      bool result = onPressAccept();
                      if (result) {
                        Navigator.pop(context, 'Save');
                      }
                    },
                    icon: const FaIcon(Ionicons.checkmark_circle)),
              ],
            )
          : AppBar(
              title: const Text('Vorlage'),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const FaIcon(Ionicons.arrow_back)),
              actions: [
                IconButton(
                    onPressed: () {
                      deleteTemplate(context, template);
                    },
                    icon: const FaIcon(Ionicons.trash)),
                IconButton(
                    onPressed: () {
                      bool result = onPressAccept();
                      if (result) {
                        Navigator.pop(context, 'Save');
                      }
                    },
                    icon: const FaIcon(Ionicons.checkmark_circle)),
              ],
            ),
      body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
        buildNewTemplateForm(context, template),
      ]),
    );
  }

  Widget buildNewTemplateForm(BuildContext context, TemplateData? template) {
    return FormBuilder(
      key: _formKey,
      child: Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          const SizedBox(height: 0),
          FormBuilderTextField(
            name: 'name',
            initialValue: template?.name,
            decoration: const InputDecoration(
              labelText: 'Name der Vorlage*',
            ),
            validator: FormBuilderValidators.required(),
          ),
          FormBuilderTextField(
            name: 'counterpart',
            initialValue: template?.counterpart,
            decoration: const InputDecoration(
              labelText: 'Gegenstelle',
            ),
          ),
          FormBuilderTextField(
            name: 'description',
            initialValue: template?.description,
            decoration: const InputDecoration(
              labelText: 'Darstellung des Ereignis',
            ),
            minLines: 4,
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          FormBuilderTextField(
            name: 'comment',
            initialValue: template?.comment,
            decoration: const InputDecoration(
              labelText: 'Bemerkung',
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          if (template == null)
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
      saveTemplate();
      return true;
    } else {
      print("validation failed");
      return false;
    }
  }

  // Get user input data from form, create a new template and append it to the templateBox
  Future saveTemplate() async {
    // Get user input data from form
    final Map formInput = _formKey.currentState!.value;

    // Create a new entry with input from form
    final template = TemplateData()
      ..name = formInput['name']
      ..counterpart = formInput['counterpart']
      ..description = formInput['description']
      ..comment = formInput['comment']
      ..creationTime = DateTime.now()
      ..modificationTime = DateTime.now();

    if (widget.templateKey == null) {
      // Append new template in the templateBox
      DataBox.getTemplates().add(template);
    } else {
      // Modify template in the templateBox
      DataBox.getTemplates().put(widget.templateKey, template);
    }
  }

  Future deleteTemplate(BuildContext context, TemplateData template) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Vorlage löschen?'),
        content:
            Text('Wollen Sie wirklich die Vorlage "${template.name}" löschen?'),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              template.delete();
              Navigator.pop(context, 'OK');
              Navigator.pop(context);
            },
            child: const Text('Löschen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Abbrechen'),
          ),
        ],
      ),
    );
  }
}
