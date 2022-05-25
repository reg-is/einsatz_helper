import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'utils/global_variables.dart' as globals;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _extendAbbreviation = false;
  String _etbWriter = '';
  final TextEditingController _etbWriterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          leading: IconButton(
              onPressed: () {
                globals.scaffoldKey.currentState?.openDrawer();
              },
              icon: const FaIcon(Ionicons.menu)),
        ),
        body: ListView(
          children: [
            SwitchListTile(
                title: const Text('Kürzel ausschreiben'),
                subtitle:
                    const Text('Kürzel werden automatisch ausgeschrieben.'),
                value: _extendAbbreviation,
                onChanged: (bool value) {
                  setState(() => _extendAbbreviation = value);
                }),
            const Divider(height: 1, thickness: 2),
            ListTile(
              title: const Text('Kürzeldatenbank'),
              subtitle: const Text('Kürzel entfernen oder hinzufügen.'),
              trailing: TextButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Verwalten'),
                    FaIcon(Icons.arrow_forward)
                  ],
                ),
                onPressed: () {},
              ),
            ),
            const Divider(height: 1, thickness: 2),
            ListTile(
              title: const Text('Organisation'),
              trailing: TextButton(
                child: const Text('Auswählen'),
                onPressed: () {},
              ),
            ),
            const Divider(height: 1, thickness: 2),
            ListTile(
              title: const Text('Standard Name ETB-Führung'),
              subtitle: const Text(
                  'Dieser Name wir beim erstellen neuer ETBs genutzt.'),
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
                    });
                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('Speichern'),
                ),
              ],
            ));
  }
}
