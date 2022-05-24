import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../etb_start_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
            child: const Text(
              'Einsatzunterstützung',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const Divider(height: 1, thickness: 3),
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            minLeadingWidth: 0,
            leading: FaIcon(Ionicons.eye),
            title: Text('Modul Erkundung'),
            iconColor: Color.fromARGB(255, 214, 185, 228),
          ),
          const Divider(height: 1, thickness: 1),
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            minLeadingWidth: 0,
            leading: FaIcon(Ionicons.construct),
            title: Text('Modul Ausrüstungsverwaltung'),
            iconColor: Color.fromARGB(255, 184, 210, 247),
          ),
          const Divider(height: 1, thickness: 1),
          ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
              selected: true,
              minLeadingWidth: 0,
              leading: const FaIcon(Ionicons.book),
              title: const Text('Modul Einsatztagebuch'),
              onTap: () => Navigator.pop(context)),
          const Divider(height: 1, thickness: 1),
          ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
              minLeadingWidth: 0,
              leading: const FaIcon(Ionicons.settings),
              title: const Text('Einstellungen'),
              onTap: () {
                // setState(() {
                //   currentIdx = 3;
                // });
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ETBStartPage(
                              index: 3,
                            )));
              }),
        ],
      ),
    );
  }
}
