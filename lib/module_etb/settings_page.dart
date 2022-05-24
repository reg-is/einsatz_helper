import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/navigation_drawer_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool extendAbbreviation = true;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        drawer: const NavigationDrawerWidget(),
        body: ListView(
          children: [
            ListTile(
              title: const Text('Kürzel ausschreiben'),
              subtitle: const Text('Kürzel werden automatich ausgeschrieben.'),
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
