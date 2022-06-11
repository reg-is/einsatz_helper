import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/data_box.dart';
import '../../model/attachment_data.dart';
import '../../model/etb_entry_data.dart';
import '../../model/etb_data.dart';
import '../../model/template_data.dart';

/// Page to add a new entry.
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

  /// Build page with form to create a new entry.
  @override
  Widget build(BuildContext context) {
    DateTime captureTime = DateTime.now();

    // Get ID for new entry
    entryID = DataBox.getNextEntryID(widget.etbKey);

    // Get ETB
    ETBData? etb = DataBox.getETBByKey(widget.etbKey);

    // Get templates
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
        // Cancel button
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(Ionicons.close_circle)),
        actions: [
          // Save button
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
        buildNewEntryForm(context, captureTime, templates),
      ]),
    );
  }

  /// Build form for creating a new entry.
  Widget buildNewEntryForm(BuildContext context, DateTime captureTime,
      List<TemplateData> templates) {
    return FormBuilder(
      key: _formKey,
      child: Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          // Template form field.
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
            itemHeight: 40,
            dropdownMaxHeight: 500,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          // Capture time form field.
          FormBuilderDateTimePicker(
            name: 'captureTime',
            inputType: InputType.both,
            decoration: const InputDecoration(
              labelText: 'Erfassungszeit',
            ),
            initialValue: captureTime,
            enabled: false,
          ),
          // Event time form field.
          FormBuilderCupertinoDateTimePicker(
            name: 'eventTime',
            alwaysUse24HourFormat: true,
            decoration: const InputDecoration(
              labelText: 'Ereigniszeit',
            ),
            initialValue: DateTime.now(),
          ),
          // Counterpart form field.
          FormBuilderTextField(
            name: 'counterpart',
            decoration: const InputDecoration(
              labelText: 'Gegenstelle',
            ),
          ),
          // Description form field.
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
          // Attachment button.
          Center(
              child: ElevatedButton(
            child: const Text('Anlage hinzufügen'),
            onPressed: () {
              buildAttachmentAmountPicker(context);
            },
          )),
          // Comment form field.
          FormBuilderTextField(
            name: 'comment',
            decoration: const InputDecoration(
              labelText: 'Bemerkung',
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          // Reference form field.
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
          // Buttons to cancel or save new entry
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

  /// Build bottom sheet with picker to choose number of attachments.
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

  /// Build a bottom sheet with the confirmation of the new attachments.
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

  /// Is called when user submits the form data.
  /// Checks if form data is valide.
  bool onPressAccept() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      addEntry();
      return true;
    } else {
      print("Validation of new entry failed");
      return false;
    }
  }

  /// Get user input data from form, create a new entry with them and append them to the etb in the database.
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
