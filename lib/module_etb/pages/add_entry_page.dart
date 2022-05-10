import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../data_box.dart';
import '../model/etb_entry_data.dart';

class AddEntryPage extends StatefulWidget {
  final dynamic etbKey;

  AddEntryPage(this.etbKey, {Key? key}) : super(key: key);

  @override
  State<AddEntryPage> createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  final _formKey2 = GlobalKey<FormBuilderState>();

  final continents = [
    'Africa',
    'Asia',
    'Australia',
    'Europe',
    'North America',
    'South America'
  ];

  String? selectedTemplate;

  List<String> templates = [
    'Vorlage1',
    'Vorlage2',
    'Vorlage3',
    'Vorlage4',
    'Vorlage5',
    'Vorlage6',
    'Vorlage7',
    'Vorlage8',
    'Vorlage9',
    'Vorlage10 very long very long very long very long very long very long',
    'Vorlage11',
    'Vorlage12',
    'Vorlage13',
    'Vorlage14',
    'Vorlage15',
    'Vorlage16',
    'Vorlage17',
    'Vorlage18',
    'Vorlage19',
  ];

  @override
  Widget build(BuildContext context) {
    DateTime captureTime = DateTime.now();
    String captureTimeAsString = captureTime.toString().substring(0, 16);

    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final Color elevatedButtonColor = theme
            .elevatedButtonTheme.style?.backgroundColor
            ?.resolve(<MaterialState>{}) ??
        colorScheme.primary;

    var genderOptions = ['male', 'female'];
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
        buildNewEntryForm(context, captureTime, elevatedButtonColor),
        //buildNewEntryForm2(captureTimeAsString, context, genderOptions),
        //buildFormExample(genderOptions, context),
      ]),
    );
  }

  Widget buildNewEntryForm(
      BuildContext context, DateTime captureTime, Color elevatedButtonColor) {
    return FormBuilder(
      key: _formKey,
      child: Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Aus Vorlage erstellen'))),
          Center(
            child: DropdownButton2(
              isExpanded: true,
              hint: Row(
                children: [
                  Icon(
                    Icons.list,
                    size: 16,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: 14,
                        //fontWeight: FontWeight.bold,
                        color: elevatedButtonColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items: templates
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              value: selectedTemplate,
              onChanged: (value) {
                setState(() {
                  selectedTemplate = value as String;
                });
              },
              icon: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.yellow,
              iconDisabledColor: Colors.grey,
              buttonHeight: 50,
              buttonWidth: 160,
              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: Colors.redAccent,
              ),
              buttonElevation: 2,
              itemHeight: 40,
              itemPadding: const EdgeInsets.only(left: 14, right: 14),
              dropdownMaxHeight: 200,
              dropdownWidth: 200,
              dropdownPadding: null,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.redAccent,
              ),
              dropdownElevation: 8,
              scrollbarRadius: const Radius.circular(40),
              scrollbarThickness: 6,
              scrollbarAlwaysShow: true,
              offset: const Offset(-20, 0),
            ),
          ),

          DropdownButtonFormField2(
            isExpanded: true,
            hint: const Text(
              'Vorlage Auswählen',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
            items: templates
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          //fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: selectedTemplate,
            onChanged: (value) {
              setState(() {
                selectedTemplate = value as String;
              });
            },
            //buttonHeight: 40,
            //buttonWidth: 200,
            itemHeight: 40,
            dropdownMaxHeight: 500,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          FormBuilderDateTimePicker(
            name: 'captureTime',
            inputType: InputType.both,
            decoration: const InputDecoration(
              labelText: 'Erfassungszeit',
            ),
            initialValue: captureTime,
            enabled: false,
          ),
          FormBuilderCupertinoDateTimePicker(
            name: 'eventTime',
            alwaysUse24HourFormat: true,
            decoration: const InputDecoration(
              labelText: 'Ereigniszeit',
            ),
            initialValue: DateTime.now(),
          ),
          FormBuilderTextField(
            name: 'counterpart',
            decoration: const InputDecoration(
              labelText: 'Gegenstelle',
            ),
          ),
          //   FormBuilderTypeAhead<String>(
          //   decoration: const InputDecoration(
          //       labelText: 'Gegenstelle',
          //       ),
          //   name: 'counterpart2',
          //   itemBuilder: (context, continent) {
          //     return ListTile(title: Text(continent));
          //   },
          //   suggestionsCallback: (query) {
          //     if (query.isNotEmpty) {
          //       var lowercaseQuery = query.toLowerCase();
          //       return continents.where((continent) {
          //         return continent.toLowerCase().contains(lowercaseQuery);
          //       }).toList(growable: false)
          //         ..sort((a, b) => a
          //             .toLowerCase()
          //             .indexOf(lowercaseQuery)
          //             .compareTo(
          //                 b.toLowerCase().indexOf(lowercaseQuery)));
          //     } else {
          //       return continents;
          //     }
          //   },
          // ),
          FormBuilderTextField(
            name: 'description',
            decoration: const InputDecoration(
              labelText: 'Darstellung des Ereignis*',
            ),
            minLines: 4,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            validator: FormBuilderValidators.required(),
            // validator: (description) =>
            //     description != null && description.isEmpty
            //         ? 'Füge eine Beschreibung hinzu'
            //         : null,
          ),
          Center(
              child: ElevatedButton(
                  onPressed: () {}, child: const Text('Anlage hinzufügen'))),
          FormBuilderTextField(
            name: 'comment',
            decoration: const InputDecoration(
              labelText: 'Bemerkung',
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          FormBuilderTextField(
            name: 'reference',
            decoration: const InputDecoration(
              labelText: 'Referenz',
            ),
            keyboardType: TextInputType.number,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.integer(
                  errorText: 'Der Wert muss eine Zahl sein'),
              FormBuilderValidators.min(1,
                  errorText:
                      'Es muss eine bereits existierende Lfd. Nr. sein.'),
              FormBuilderValidators.max(
                  DataBox.getNextEntryID(widget.etbKey) - 1,
                  errorText:
                      'Es muss eine bereits existierende Lfd. Nr. sein.'),
            ]),
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
                  child: const Text('Eintrag speichern'),
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
      addEntry();
      return true;
    } else {
      print("validation failed");
      return false;
    }
  }

  // Get user input data from form, create a new entry with them and append them to the etb in the database
  Future addEntry() async {
    // Get user input data from form
    final Map formInput = _formKey.currentState!.value;

    // Create a new entry with input from form
    final entry = ETBEntryData()
      ..id = DataBox.getNextEntryID(widget.etbKey)
      ..captureTime = formInput['captureTime']
      ..eventTime = formInput['eventTime']
      ..counterpart = formInput['counterpart']
      ..description = formInput['description']
      ..comment = formInput['comment']
      ..reference = (formInput['reference'].runtimeType != String)
          ? null
          : int.parse(formInput['reference']);
    // Append new entry to the etb in the database
    DataBox.appendEntry(widget.etbKey, entry);
  }

  Wrap buildNewEntryFormOld(String captureTimeAsString, BuildContext context,
      List<String> genderOptions) {
    return Wrap(spacing: 8, runSpacing: 8, children: [
      Center(
          child: ElevatedButton(
              onPressed: () {}, child: const Text('Aus Vorlage erstellen'))),
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
        validator: (description) => description != null && description.isEmpty
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
      ),
    ]);
  }

  FormBuilder buildFormExample(
      List<String> genderOptions, BuildContext context) {
    return FormBuilder(
        key: _formKey2,
        child: Wrap(
          spacing: 8,
          runSpacing: 16,
          children: [
            FormBuilderFilterChip(
              name: 'filter_chip',
              decoration: InputDecoration(labelText: 'Select many options'),
              options: [
                FormBuilderFieldOption(value: 'Test', child: Text('Test')),
                FormBuilderFieldOption(value: 'Test 1', child: Text('Test 1')),
                FormBuilderFieldOption(value: 'Test 2', child: Text('Test 2')),
                FormBuilderFieldOption(value: 'Test 3', child: Text('Test 3')),
                FormBuilderFieldOption(value: 'Test 4', child: Text('Test 4')),
              ],
            ),
            FormBuilderChoiceChip(
              name: 'choice_chip',
              decoration: InputDecoration(
                labelText: 'Select an option',
              ),
              options: [
                FormBuilderFieldOption(value: 'Test', child: Text('Test')),
                FormBuilderFieldOption(value: 'Test 1', child: Text('Test 1')),
                FormBuilderFieldOption(value: 'Test 2', child: Text('Test 2')),
                FormBuilderFieldOption(value: 'Test 3', child: Text('Test 3')),
                FormBuilderFieldOption(value: 'Test 4', child: Text('Test 4')),
              ],
            ),
            FormBuilderDateTimePicker(
              name: 'date',
              // onChanged: _onChanged,
              inputType: InputType.time,
              decoration: InputDecoration(
                labelText: 'Appointment Time',
              ),
              initialTime: TimeOfDay(hour: 8, minute: 0),
              // initialValue: DateTime.now(),
              // enabled: true,
            ),
            FormBuilderDateRangePicker(
              name: 'date_range',
              firstDate: DateTime(1970),
              lastDate: DateTime(2030),
              //format: DateFormat('yyyy-MM-dd'),
              decoration: const InputDecoration(
                labelText: 'Date Range',
                helperText: 'Helper text',
                hintText: 'Hint text',
              ),
            ),
            FormBuilderSlider(
              name: 'slider',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.min(6),
              ]),
              min: 0.0,
              max: 10.0,
              initialValue: 7.0,
              divisions: 20,
              activeColor: Colors.red,
              inactiveColor: Colors.pink[100],
              decoration: InputDecoration(
                labelText: 'Number of things',
              ),
            ),
            FormBuilderCheckbox(
              name: 'accept_terms',
              initialValue: false,
              title: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'I have read and agree to the ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Terms and Conditions',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
              validator: FormBuilderValidators.equal(
                true,
                errorText: 'You must accept terms and conditions to continue',
              ),
            ),
            FormBuilderTextField(
              name: 'age',
              decoration: const InputDecoration(
                labelText:
                    'This value is passed along to the [Text.maxLines] attribute of the [Text] widget used to display the hint text.',
              ),
              // valueTransformer: (text) => num.tryParse(text),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
                FormBuilderValidators.max(70),
              ]),
              keyboardType: TextInputType.number,
            ),
            FormBuilderDropdown(
              name: 'gender',
              decoration: const InputDecoration(
                labelText: 'Gender',
              ),
              // initialValue: 'Male',
              allowClear: true,
              hint: const Text('Select Gender'),
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required()]),
              items: genderOptions
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text('$gender'),
                      ))
                  .toList(),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).colorScheme.secondary,
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _formKey2.currentState!.save();
                      if (_formKey2.currentState!.validate()) {
                        print(_formKey2.currentState!.value);
                      } else {
                        print("validation failed");
                      }
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).colorScheme.secondary,
                    child: const Text(
                      "Reset",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Widget buildFormExample2(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      //autovalidate: true,
      child: Column(
        children: <Widget>[
          FormBuilderSearchableDropdown(
            name: 'searchable_dropdown',
            items: continents,
            decoration: const InputDecoration(labelText: 'Searchable Dropdown'),
          ),
          const SizedBox(height: 15),
          FormBuilderColorPickerField(
            name: 'color_picker',
            initialValue: Colors.yellow,
            // readOnly: true,
            colorPickerType: ColorPickerType.colorPicker,
            decoration: const InputDecoration(labelText: 'Color Picker'),
          ),
          FormBuilderCupertinoDateTimePicker(
            name: 'date_time',
            initialValue: DateTime.now(),
            inputType: CupertinoDateTimePickerInputType.both,
            decoration: const InputDecoration(
              labelText: 'Cupertino DateTime Picker',
            ),
            locale: Locale.fromSubtags(languageCode: 'en_GB'),
          ),
          FormBuilderCupertinoDateTimePicker(
            name: 'date',
            initialValue: DateTime.now(),
            inputType: CupertinoDateTimePickerInputType.date,
            decoration: const InputDecoration(
              labelText: 'Cupertino DateTime Picker - Date Only',
            ),
            locale: Locale.fromSubtags(languageCode: 'en_GB'),
          ),
          FormBuilderCupertinoDateTimePicker(
            name: 'time',
            initialValue: DateTime.now(),
            inputType: CupertinoDateTimePickerInputType.time,
            decoration: const InputDecoration(
              labelText: 'Cupertino DateTime Picker - Time Only',
            ),
            locale: Locale.fromSubtags(languageCode: 'en_GB'),
          ),
          FormBuilderTypeAhead<String>(
            decoration: const InputDecoration(
                labelText: 'TypeAhead (Autocomplete TextField)',
                hintText: 'Start typing continent name'),
            name: 'continent',
            itemBuilder: (context, continent) {
              return ListTile(title: Text(continent));
            },
            suggestionsCallback: (query) {
              if (query.isNotEmpty) {
                var lowercaseQuery = query.toLowerCase();
                return continents.where((continent) {
                  return continent.toLowerCase().contains(lowercaseQuery);
                }).toList(growable: false)
                  ..sort((a, b) => a
                      .toLowerCase()
                      .indexOf(lowercaseQuery)
                      .compareTo(b.toLowerCase().indexOf(lowercaseQuery)));
              } else {
                return continents;
              }
            },
          ),
          FormBuilderTouchSpin(
            decoration: const InputDecoration(labelText: 'TouchSpin'),
            name: 'touch_spin',
            initialValue: 10,
            step: 1,
            iconSize: 48.0,
            addIcon: const Icon(Icons.arrow_right),
            subtractIcon: const Icon(Icons.arrow_left),
          ),
          // FormBuilderRating(
          //   decoration: const InputDecoration(labelText: 'Rating'),
          //   name: 'rate',
          //   iconSize: 32.0,
          //   initialValue: 1.0,
          //   max: 5.0,
          // ),
          FormBuilderSignaturePad(
            decoration: const InputDecoration(
              labelText: 'Signature Pad',
            ),
            name: 'signature',
            border: Border.all(color: Colors.green),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      print(_formKey.currentState!.value);
                    } else {
                      print("validation failed");
                    }
                  },
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    "Reset",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _formKey.currentState!.reset();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
