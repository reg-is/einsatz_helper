import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../utils/data_box.dart';
import '../../model/etb_data.dart';
import '../../model/etb_entry_data.dart';
import 'new_etb_confirm_page.dart';

/// Page to create a new ETB.
class NewETBPage extends StatelessWidget {
  NewETBPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();
  late ETBData etb;

  /// Build page with form to create a new ETB.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ETB beginnen'),
          // Close Button
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const FaIcon(Ionicons.close_circle)),
          actions: [
            // Continue Button
            IconButton(
                onPressed: () {
                  bool result = onPressAccept();
                  if (result) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewETBConfirmPage(
                                  etb: etb,
                                )));
                  }
                },
                icon: const FaIcon(Ionicons.arrow_forward_circle)),
          ],
        ),
        body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
          const SizedBox(height: 4),
          buildNewETBForm(context)
        ]));
  }

  /// Build form for creating a new ETB.
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
            keyboardType: TextInputType.multiline,
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
            keyboardType: TextInputType.multiline,
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
              labelText: 'F??hrungskraft*',
            ),
            maxLines: null,
            keyboardType: TextInputType.name,
            validator: FormBuilderValidators.required(),
          ),
          FormBuilderTextField(
            name: 'etbWriter',
            decoration: const InputDecoration(
              labelText: 'ETB-F??hrung*',
            ),
            initialValue:
                DataBox.getSettings().get('etbWriter', defaultValue: null),
            maxLines: null,
            keyboardType: TextInputType.name,
            validator: FormBuilderValidators.required(),
          ),
          FormBuilderTextField(
            name: 'units',
            decoration: const InputDecoration(
              labelText: 'Einheiten und St??rke',
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          FormBuilderTextField(
            name: 'damage',
            decoration: const InputDecoration(
              labelText: 'Schadenereignis',
            ),
          ),
          FormBuilderDropdown(
            name: 'weather',
            decoration: const InputDecoration(
              labelText: 'Wetterlage',
            ),
            allowClear: true,
            isDense: true,
            hint: const Text('W??hle Wetterlage'),
            items: Weather.weatherOptions
                .map((weather) => DropdownMenuItem(
                      value: weather.name,
                      child: Wrap(
                        spacing: 8,
                        children: [
                          SizedBox(
                              width: 32,
                              child: Center(
                                child: FaIcon(
                                  weather.iconData,
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(weather.name),
                          ),
                        ],
                      ),
                    ))
                .toList(),
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
                              builder: (context) => NewETBConfirmPage(
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
        ]));
  }

  /// Is called when user submits the form data.
  /// Checks if form data is valide.
  bool onPressAccept() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      etb = createETB();
      return true;
    } else {
      print("Validation new ETB failed");
      return false;
    }
  }

  /// Create and return a ETB with a first entry containing the form input.
  ETBData createETB() {
    // Get user input data from form
    final Map formInput = _formKey.currentState!.value;

    // Create first entry for new ETB
    final firstEntry = ETBEntryData()
      ..id = 1
      ..captureTime = DateTime.now()
      ..eventTime = formInput['startedDate']
      ..description = createDescription();

    // Crate new ETB with first entry
    final etb = ETBData()
      ..name = formInput['name']
      ..attachmentsSum = 0
      ..finished = false
      ..leader = formInput['leader']
      ..etbWriter = formInput['etbWriter']
      ..startedDate = formInput['startedDate']
      ..entries = <ETBEntryData>[firstEntry];

    return etb;
  }

  /// Return the entry description based on the form input.
  String createDescription() {
    // Get user input data from form
    final Map formInput = _formKey.currentState!.value;

    String description = '';

    description += 'Einsatzbeginn: ${toDTG(formInput['startedDate'])}\n';
    if (formInput['location'] != null && formInput['location'] != '') {
      description += 'Einsatzort: ${formInput['location']}\n';
    }
    if (formInput['damage'] != null && formInput['damage'] != '') {
      description += 'Schadenereignis: ${formInput['damage']}\n';
    }
    if (formInput['weather'] != null && formInput['weather'] != '') {
      description += 'Wetterlage: ${formInput['weather']}\n';
    }
    if (formInput['request'] != null && formInput['request'] != '') {
      description += 'Einsatzauftrag: ${formInput['request']}\n';
    }
    if (formInput['units'] != null && formInput['units'] != '') {
      description += 'Einheiten:\n${formInput['units']}\n';
    }

    description += '\nF??hrungskraft: ${formInput['leader']}\n';
    description += 'ETB-F??hrung: ${formInput['etbWriter']}';

    return description;
  }
}

/// Class for weather options. 
/// Needs a [name] of the weather and a corresponding icon [iconData].
class Weather {
  String name;
  IconData iconData;

  Weather(this.name, this.iconData);

  static List<Weather> weatherOptions = [
    Weather('Heiter', WeatherIcons.wi_day_sunny),
    Weather('Leicht Bew??lkt', WeatherIcons.wi_day_cloudy),
    Weather('Bew??lkt', WeatherIcons.wi_day_cloudy_high),
    Weather('Bedeckt', WeatherIcons.wi_cloud),
    Weather('Regenschauer', WeatherIcons.wi_day_sleet),
    Weather('Regen', WeatherIcons.wi_sleet),
    Weather('Starker Regen', WeatherIcons.wi_rain),
    Weather('Schnee', WeatherIcons.wi_snow),
    Weather('Schneeschauer', WeatherIcons.wi_day_snow),
    // Weather('Schneeregen', WeatherIcons.wi_snow),
    // Weather('Schneeregenschauer', WeatherIcons.wi_snow),
    Weather('Gewitter', WeatherIcons.wi_thunderstorm),
    Weather('Glatteis', WeatherIcons.wi_snowflake_cold),
    Weather('Nebel', WeatherIcons.wi_fog),
  ];
}
