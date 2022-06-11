import 'package:einsatz_helper/module_etb/model/etb_data.dart';
import 'package:einsatz_helper/module_etb/model/template_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/data_box.dart';
import '../../model/attachment_data.dart';
import '../../model/etb_entry_data.dart';

class AddEntryPage extends StatefulWidget {
  final dynamic etbKey;

  const AddEntryPage(this.etbKey, {Key? key}) : super(key: key);

  @override
  State<AddEntryPage> createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  int attachmentsCount = 0;
  List<AttachmentData> attachments = [];

  late int entryID;

  TemplateData? selectedTemplate;
  String? selectedTemplateID;

  @override
  Widget build(BuildContext context) {
    DateTime captureTime = DateTime.now();
    entryID = DataBox.getNextEntryID(widget.etbKey);

    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final Color elevatedButtonColor = theme
            .elevatedButtonTheme.style?.backgroundColor
            ?.resolve(<MaterialState>{}) ??
        colorScheme.primary;

    ETBData? etb = DataBox.getETBByKey(widget.etbKey);
    List<TemplateData> templates = DataBox.getTemplates().values.toList() +
        [
          TemplateData.build(
              name: 'Einsatztagebuch abschließen',
              id: 'end',
              description: 'Einsatzende\n\n'
                  'Ende Einsatztagebuch (mit ${etb?.attachmentsSum ?? 0} Anlagen)\n'
                  'ETB-Führung: ${etb?.etbWriter}\n'
                  'Führungskraft: ${etb?.leader}',
              creationTime: DateTime.now(),
              modificationTime: DateTime.now())
        ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eintrag anlegen'),
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
      ),
      body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
        const SizedBox(height: 4),
        buildNewEntryForm(context, captureTime, elevatedButtonColor, templates),
      ]),
    );
  }

  Widget buildNewEntryForm(BuildContext context, DateTime captureTime,
      Color elevatedButtonColor, List<TemplateData> templates) {
    return FormBuilder(
      key: _formKey,
      child: Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          // Center(
          //     child: ElevatedButton(
          //         onPressed: () {},
          //         child: const Text('Aus Vorlage erstellen'))),
          // Center(
          //   child: DropdownButton2(
          //     isExpanded: true,
          //     hint: Row(
          //       children: [
          //         Icon(
          //           Icons.list,
          //           size: 16,
          //           color: Colors.yellow,
          //         ),
          //         SizedBox(
          //           width: 4,
          //         ),
          //         Expanded(
          //           child: Text(
          //             'Select Item',
          //             style: TextStyle(
          //               fontSize: 14,
          //               //fontWeight: FontWeight.bold,
          //               color: elevatedButtonColor,
          //             ),
          //             overflow: TextOverflow.ellipsis,
          //           ),
          //         ),
          //       ],
          //     ),
          //     items: templates
          //         .map((item) => DropdownMenuItem<String>(
          //               value: item,
          //               child: Text(
          //                 item,
          //                 style: const TextStyle(
          //                   fontSize: 14,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.white,
          //                 ),
          //                 overflow: TextOverflow.ellipsis,
          //               ),
          //             ))
          //         .toList(),
          //     value: selectedTemplate,
          //     onChanged: (value) {
          //       setState(() {
          //         selectedTemplate = value as String;
          //       });
          //     },
          //     icon: const Icon(
          //       Icons.arrow_forward_ios_outlined,
          //     ),
          //     iconSize: 14,
          //     iconEnabledColor: Colors.yellow,
          //     iconDisabledColor: Colors.grey,
          //     buttonHeight: 50,
          //     buttonWidth: 160,
          //     buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          //     buttonDecoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(14),
          //       border: Border.all(
          //         color: Colors.black26,
          //       ),
          //       color: Colors.redAccent,
          //     ),
          //     buttonElevation: 2,
          //     itemHeight: 40,
          //     itemPadding: const EdgeInsets.only(left: 14, right: 14),
          //     dropdownMaxHeight: 200,
          //     dropdownWidth: 200,
          //     dropdownPadding: null,
          //     dropdownDecoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(14),
          //       color: Colors.redAccent,
          //     ),
          //     dropdownElevation: 8,
          //     scrollbarRadius: const Radius.circular(40),
          //     scrollbarThickness: 6,
          //     scrollbarAlwaysShow: true,
          //     offset: const Offset(-20, 0),
          //   ),
          // ),
          DropdownButtonFormField2(
            isExpanded: true,
            hint: const Text(
              'Vorlage Auswählen',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
            items: templates
                .map((template) => DropdownMenuItem<String>(
                      value: template.id.toString(),
                      child: Text(
                        template.name,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ))
                .toList(),
            value: selectedTemplateID,
            onChanged: (value) {
              setState(() {
                // Update selectedTemplateID with the ID of the selected template
                selectedTemplateID = value as String;
                // Update selectedTemplate with the selected template
                selectedTemplate = templates
                    .firstWhere((template) => template.id == value as dynamic);
                // Update form fields with values from selected template
                _formKey.currentState?.patchValue({
                  'counterpart': selectedTemplate?.counterpart,
                  'description': selectedTemplate?.description,
                  'comment': selectedTemplate?.comment,
                });
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
              labelText: 'Darstellung des Ereignisses*',
            ),
            minLines: 4,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            validator: FormBuilderValidators.required(),
          ),
          Center(
              child: ElevatedButton(
            child: const Text('Anlage hinzufügen'),
            onPressed: () {
              buildAttachmentAmountPicker(context);
            },
          )),
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

  Future<dynamic> buildAttachmentAmountPicker(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Wie viele Anlagen soll der Eintrag haben?',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TouchSpin(
                    min: 0,
                    step: 1,
                    value: attachmentsCount,
                    textStyle: const TextStyle(fontSize: 36),
                    iconSize: 48.0,
                    addIcon: const Icon(Ionicons.add_circle_outline),
                    subtractIcon: const Icon(Ionicons.remove_circle_outline),
                    iconActiveColor: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.backgroundColor
                            ?.resolve(<MaterialState>{}) ??
                        Theme.of(context).primaryColor,
                    iconPadding: const EdgeInsets.all(20),
                    onChanged: (val) {
                      attachmentsCount = val as int;
                    },
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context, 'Cancel');
                        },
                        child: const Text('Abbrechen'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          attachments =
                              createAttachments(entryID, attachmentsCount);
                          String? comment;
                          switch (attachmentsCount) {
                            case 0:
                              comment = null;
                              break;
                            case 1:
                              comment =
                                  'Anlage: ' + attachmentsAsText(attachments);
                              break;
                            default:
                              comment =
                                  'Anlagen: ' + attachmentsAsText(attachments);
                          }
                          _formKey.currentState?.patchValue({
                            'comment': comment,
                          });
                          Navigator.pop(context, 'Save');
                          if (attachmentsCount > 0) {
                            buildAttachmentConfirmation(context);
                          }
                        },
                        child: const Text('Speichern'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ));
  }

  Future<dynamic> buildAttachmentConfirmation(BuildContext context) {
    final String title;
    final String subtitle;

    switch (attachmentsCount) {
      case 1:
        title = 'Es wurde eine Anlage erzeugt';
        subtitle =
            'Bitte vermerken sie die Nummer ${attachments.first.id} auf der zugehörigen Anlage.';
        break;
      case 2:
        title = 'Es wurden zwei Anlage erzeugt';
        subtitle =
            'Bitte vermerken sie die Nummern ${attachments.first.id} und ${attachments.last.id} auf den zugehörigen Anlagen.';
        break;
      default:
        title = 'Es wurden $attachmentsCount Anlagen erzeugt';
        subtitle =
            'Bitte vermerken sie die Nummern ${attachments.first.id} bis ${attachments.last.id} auf den zugehörigen Anlagen.';
    }

    return showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(subtitle),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Okay');
                },
                child: const Text('OK'),
              ),
              const SizedBox(height: 8),
            ])));
  }

  // Is called when user accepts the inputted data.
  bool onPressAccept() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      //print(_formKey.currentState!.value);
      addEntry();
      return true;
    } else {
      print("Validation of new entry failed");
      return false;
    }
  }

  // Get user input data from form, create a new entry with them and append them to the etb in the database
  Future addEntry() async {
    // Get user input data from form
    final Map formInput = _formKey.currentState!.value;

    // Create a new entry with input from form
    final entry = ETBEntryData()
      ..id = entryID
      ..captureTime = formInput['captureTime']
      ..eventTime = formInput['eventTime']
      ..counterpart = formInput['counterpart']
      ..description = formInput['description']
      ..comment = formInput['comment']
      ..reference = (formInput['reference'].runtimeType != String)
          ? null
          : int.parse(formInput['reference'])
      ..attachments = (attachments.isEmpty) ? null : attachments;

    // Append new entry to the etb in the database
    DataBox.appendEntry(widget.etbKey, entry);

    // Add the number of attachments to the attachmentsSum of the etb
    DataBox.getETBByKey(widget.etbKey)!.attachmentsSum += attachmentsCount;

    // Close ETB if template 'end' is used
    if (selectedTemplateID == 'end') {
      DataBox.getETBByKey(widget.etbKey)?.finished = true;
    }
  }
}
