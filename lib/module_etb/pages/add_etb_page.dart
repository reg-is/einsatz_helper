import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../data_box.dart';
import '../model/etb_data.dart';
import '../model/etb_entry_data.dart';
import 'confirm_new_etb_page.dart';

class AddETBPage extends StatelessWidget {
  AddETBPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();
  var options = ["Option 1", "Option 2", "Option 3"];
  late ETBData etb;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ETB beginnen'),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfirmNewETBPage(
                                  etb: etb,
                                )));
                  }
                },
                icon: const Icon(Ionicons.arrow_forward_circle)),
          ],
        ),
        body: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[buildNewETBForm(context)]));
  }

  Widget buildNewETBForm(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: Wrap(spacing: 8, runSpacing: 16, children: [
          FormBuilderTextField(
            name: 'name',
            decoration: const InputDecoration(
              labelText: 'Einsatzname*',
            ),
            maxLines: null,
            keyboardType: TextInputType.name,
            validator: FormBuilderValidators.required(),
          ),
          FormBuilderCupertinoDateTimePicker(
            name: 'startedDate',
            decoration: const InputDecoration(
              labelText: 'Einsatzbeginn*',
            ),
            alwaysUse24HourFormat: true,
            initialValue: DateTime.now(),
            validator: FormBuilderValidators.required(),
          ),
          FormBuilderTextField(
            name: 'location',
            decoration: const InputDecoration(
              labelText: 'Einsatzort',
            ),
            maxLines: null,
            keyboardType: TextInputType.name,
          ),
          FormBuilderTextField(
            name: 'request',
            decoration: const InputDecoration(
              labelText: 'Einsatzauftrag',
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          FormBuilderTextField(
            name: 'leader',
            decoration: const InputDecoration(
              labelText: 'Einsatzleitung*',
            ),
            maxLines: null,
            keyboardType: TextInputType.name,
            validator: FormBuilderValidators.required(),
          ),
          FormBuilderTextField(
            name: 'etbWriter',
            decoration: const InputDecoration(
              labelText: 'ETB-Führung*',
            ),
            maxLines: null,
            keyboardType: TextInputType.name,
            validator: FormBuilderValidators.required(),
          ),
          FormBuilderField(
            name: "units",
            builder: (FormFieldState<dynamic> field) {
              return InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Einheiten und Stärke",
                    //contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                    //border: InputBorder.none,
                    errorText: field.errorText,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Einheiten und Stärke'),
                      Icon(Ionicons.chevron_forward)
                    ],
                  ));
            },
          ),
          // Container(
          //           //height: 200,
          //           child: ListTile(
          //         title: Text('Einheiten und Stärke'),
          //         trailing: Icon(Ionicons.chevron_forward),
          //         onTap: () {
          //           // ToDo
          //         },
          //       )
          //           //Text('ToDo: Einheiten und Stärke')
          //           ),
          FormBuilderTextField(
            name: 'damage',
            decoration: const InputDecoration(
              labelText: 'Schadensereignis',
            ),
          ),
          FormBuilderTextField(
            name: 'weather',
            decoration: const InputDecoration(
              labelText: 'Wetterlage',
            ),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmNewETBPage(
                                    etb: etb,
                                  )));
                    }
                  },
                  child: const Text('Weiter'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // FormBuilderField(
          //   name: "name",
          //   // validator: FormBuilderValidators.compose([
          //   //   FormBuilderValidators.required(context),
          //   // ]),
          //   builder: (FormFieldState<dynamic> field) {
          //     return InputDecorator(
          //       decoration: InputDecoration(
          //         labelText: "Select option",
          //         contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
          //         border: InputBorder.none,
          //         errorText: field.errorText,
          //       ),
          //       child: Container(
          //         height: 200,
          //         child: CupertinoPicker(
          //           itemExtent: 30,
          //           children: options.map((c) => Text(c)).toList(),
          //           onSelectedItemChanged: (index) {
          //             field.didChange(options[index]);
          //           },
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ]));
  }

  bool onPressAccept() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print(_formKey.currentState!.value);
      etb = createETB();
      return true;
    } else {
      print("validation failed");
      return false;
    }
  }

  ETBData createETB() {
    // Get user input data from form
    final Map formInput = _formKey.currentState!.value;

    // Create first Entry for new ETB
    final firstEntry = ETBEntryData()
      ..id = 1
      ..captureTime = DateTime.now()
      ..eventTime = formInput['startedDate']
      //..counterpart = ''
      //..comment = ''
      //..reference = 0
      ..description = createDescription();

    // Crate new ETB with first Entry
    final etb = ETBData()
      ..name = formInput['name']
      ..attachmentsSum = 0
      ..finished = false
      ..id = 42
      ..leader = formInput['leader']
      ..etbWriter = formInput['etbWriter']
      ..startedDate = formInput['startedDate']
      ..entries = <ETBEntryData>[firstEntry];

    return etb;
  }

  String createDescription() {
    // Get user input data from form
    final Map formInput = _formKey.currentState!.value;

    String description = '';

    description += 'Einsatzbeginn: ${toDTG(formInput['startedDate'])}\n';
    if (formInput['location'] != null) {
      description += 'Einsatzort: ${formInput['location']}\n';
    }
    if (formInput['damage'] != null) {
      description += 'Schadensereignis: ${formInput['damage']}\n';
    }
    if (formInput['weather'] != null) {
      description += 'Wetterlage: ${formInput['weather']}\n';
    }
    if (formInput['request'] != null) {
      description += 'Einsatzauftrag: ${formInput['request']}\n';
    }
    if (formInput['units'] != null) {
      description += 'Einheiten: ${formInput['units']}\n';
    }

    description += '\nEinsatzleitung: ${formInput['leader']}\n';
    description += 'ETB-Führung: ${formInput['etbWriter']}';

    return description;
  }
}
