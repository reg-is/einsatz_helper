import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Navigation drawer to switch between the modules of the app.
class NavigationDrawerWidget extends StatelessWidget {
  final Function callback;
  const NavigationDrawerWidget(this.callback, {Key? key}) : super(key: key);

  // Build a drawer to navigate between modules.
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(13.0, 24.0, 13.0, 8.0),
            child: const Text(
              'Einsatz Helper',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const Divider(height: 1, thickness: 3),
          moduleListTile(context,
              title: const Text('Modul Erkundung'),
              backgroundColor: const Color.fromARGB(255, 214, 185, 228),
              iconData: Ionicons.map),
          const Divider(height: 1, thickness: 1),
          moduleListTile(context,
              title: const Text('Modul Ausrüstungsverwaltung'),
              backgroundColor: const Color.fromARGB(255, 184, 210, 247),
              iconData: Ionicons.construct),
          const Divider(height: 1, thickness: 1),
          moduleListTile(
            context,
            title: const Text('Modul Einsatztagebuch'),
            backgroundColor: const Color.fromARGB(255, 166, 200, 165),
            iconData: Ionicons.book,
            onTap: () {
              callback(0);
              Navigator.pop(context);
            },
          ),
          const Divider(height: 1, thickness: 1),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
            minLeadingWidth: 0,
            leading: const FaIcon(Ionicons.settings),
            title: const Text('Einstellungen'),
            onTap: () {
              callback(3);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  /// Build a row for the Drawer.
  static ListTile moduleListTile(BuildContext context,
      {required Color backgroundColor,
      required Widget title,
      required IconData iconData,
      void Function()? onTap,
      bool roundedBox = true}) {
    if (roundedBox) {
      return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 13.0),
        minLeadingWidth: 0,
        leading: Container(
          child: FaIcon(iconData,
              size: 18, color: Theme.of(context).colorScheme.background),
          height: 28,
          width: 28,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          alignment: Alignment.center,
        ),
        title: title,
        onTap: onTap,
      );
    } else {
      return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
        minLeadingWidth: 0,
        leading: FaIcon(iconData),
        iconColor: backgroundColor,
        title: title,
        onTap: onTap,
      );
    }
  }
}
