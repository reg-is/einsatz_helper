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
  bool extendAbbreviation = false;

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
            ListTile(
              title: const Text('Kürzel ausschreiben'),
              subtitle: const Text('Kürzel werden automatisch ausgeschrieben.'),
              trailing: Switch(
                onChanged: (bool value) {
                  extendAbbreviation = value;
                },
                value: extendAbbreviation,
              ),
            ),
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
              //subtitle: const Text('Kürzel entfernen oder hinzufügen.'),
            ),
            const Divider(height: 1, thickness: 2),
            ListTile(
              title: const Text('Standard ETB-Führung'),
              subtitle: const Text(
                  'Dieser Name wir beim erstellen neuer ETBs genutzt.'),
              trailing: Text('Max Mustermann'),
            ),
          ],
        ));
  }
}
