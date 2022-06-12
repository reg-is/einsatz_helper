import 'package:einsatz_helper/module_etb/model/etb_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../utils/data_box.dart';

/// Page to confirm the creation of a new ETB.
class NewETBConfirmPage extends StatelessWidget {
  late ETBData etb;
  NewETBConfirmPage({Key? key, required this.etb}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  /// Build page with confirmation option for new ETB.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ETB beginnen'),
          // Button to go back
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context, 'Back');
              },
              icon: const FaIcon(Ionicons.arrow_back_circle)),
          actions: [
            // Button to save new ETB
            IconButton(
                onPressed: () {
                  bool result = onPressAccept();
                  if (result) {
                    Navigator.pop(context, 'Save');
                    Navigator.pop(context, 'Save');
                  }
                },
                icon: const FaIcon(Ionicons.checkmark_circle)),
          ],
        ),
        body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
          const SizedBox(height: 4),
          buildConfirmNewETBForm(context)
        ]));
  }

  // Build form to confirm new ETB.
  Widget buildConfirmNewETBForm(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: Wrap(spacing: 8, runSpacing: 16, children: [
          FormBuilderTextField(
            name: 'name',
            decoration: const InputDecoration(
              labelText: 'Einsatzname*',
            ),
            initialValue: etb.name,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            validator: FormBuilderValidators.required(),
          ),
          FormBuilderTextField(
            name: 'description',
            decoration: const InputDecoration(
              labelText: 'Darstellung des Ereignisses',
            ),
            initialValue: etb.entries!.first.description,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            validator: FormBuilderValidators.required(),
          ),
          Center(
            child: Wrap(
              runSpacing: 8,
              spacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, 'Back');
                  },
                  child: const Text('Zurück'),
                ),
                ElevatedButton(
                  onPressed: () {
                    bool result = onPressAccept();
                    if (result) {
                      Navigator.pop(context, 'Save');
                      Navigator.pop(context, 'Save');
                    }
                  },
                  child: const Text('ETB beginnen'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ]));
  }

  /// Is called when user submits the form data.
  /// Checks if form data is valide.
  bool onPressAccept() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      addETB();
      return true;
    } else {
      print("validation failed");
      return false;
    }
  }

  /// Get form data, create a new etb with it and add it to the database.
  Future addETB() async {
    final Map formInput = _formKey.currentState!.value;

    etb.name = formInput['name'];
    etb.entries!.first.description = formInput['description'];

    final etbDB = DataBox.getETBs();
    etbDB.add(etb);
  }
}
