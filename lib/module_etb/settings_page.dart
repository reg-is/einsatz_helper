import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'data_box.dart';
import 'utils/global_variables.dart' as globals;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _extendAbbreviation = false;
  var settingsBox = DataBox.getSettings();
  String _etbWriter = DataBox.getSettings().get('etbWriter', defaultValue: '');

  final TextEditingController _etbWriterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Einstellungen'),
          leading: IconButton(
              onPressed: () {
                globals.scaffoldKey.currentState?.openDrawer();
              },
              icon: const FaIcon(Ionicons.menu)),
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          children: [
            // const Divider(height: 8, thickness: 0),
            SwitchListTile(
                title: const Text('Kürzel ausschreiben'),
                subtitle:
                    const Text('Kürzel werden automatisch ausgeschrieben.'),
                value: _extendAbbreviation,
                onChanged: (bool value) {
                  setState(() => _extendAbbreviation = value);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Funktion noch nicht implementiert.')));
                }),
            const Divider(height: 12, thickness: 2),
            ListTile(
              title: const Text('Kürzeldatenbank'),
              subtitle: const Text('Kürzel entfernen oder hinzufügen.'),
              trailing: TextButton(
                child: const Text('Verwalten'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Funktion noch nicht implementiert.')));
                },
              ),
            ),
            const Divider(height: 12, thickness: 2),
            ListTile(
              title: const Text('Organisation'),
              subtitle: const Text('Name der zugehörigen Organisation.'),
              trailing: TextButton(
                child: const Text('Auswählen'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Funktion noch nicht implementiert.')));
                },
              ),
            ),
            const Divider(height: 12, thickness: 2),
            ListTile(
              title: const Text('Standard Name ETB-Führung'),
              subtitle: const Text(
                  'Dieser Name wir beim Erstellen neuer ETBs genutzt.'),
              trailing: Container(
                constraints: const BoxConstraints(maxWidth: 110),
                child: (_etbWriter == '')
                    ? TextButton(
                        child: const Text('Auswählen'),
                        onPressed: () => _showEtbWriterInputDialog(context),
                      )
                    : Text(
                        _etbWriter,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
              onTap: () {
                _etbWriterController.text = _etbWriter;
                _showEtbWriterInputDialog(context);
              },
            ),
            const Divider(height: 12, thickness: 2),
            ListTile(
              title: const Text('Vorlagen zurücksetzen'),
              subtitle: const Text(
                  'Alle eigenen Vorlagen löschen und Standard-Vorlagen wiederherstellen.'),
              trailing: TextButton(
                child: const Text('Zurücksetzen'),
                onPressed: () {
                  _deleteTemplates(context);
                },
              ),
            ),
          ],
        ));
  }

  // Show Dialog with text field to input name of etb-writer
  Future<void> _showEtbWriterInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Standard Name ETB-Führung'),
              content: TextField(
                controller: _etbWriterController,
                decoration: const InputDecoration(hintText: "Name"),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _etbWriter = _etbWriterController.text;
                      settingsBox.put('etbWriter', _etbWriter);
                    });
                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('Speichern'),
                ),
              ],
            ));
  }

  // Delete all templates and reset to defaults
  Future _deleteTemplates(context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Vorlagen löschen?'),
        content: const Text(
            'Wollen Sie wirklich alle eigenen Vorlagen löschen?\nDie Standard-Vorlagen werden anschließend wiederhergestellt.'),
        actions: <Widget>[
          OutlinedButton(
            child: const Text('Zurücksetzen'),
            onPressed: () {
              DataBox.getTemplates().clear();
              Navigator.pop(context, 'OK');
            },
          ),
          ElevatedButton(
            child: const Text('Abbrechen'),
            onPressed: () => Navigator.pop(context, 'Cancel'),
          ),
        ],
      ),
    );
  }
}
