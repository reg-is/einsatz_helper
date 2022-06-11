import 'package:einsatz_helper/module_etb/pages/entries/entries_page.dart';
import 'package:einsatz_helper/module_etb/pages/etbs/etbs_page.dart';
import 'package:einsatz_helper/module_etb/pages/settings/settings_page.dart';
import 'package:einsatz_helper/module_etb/pages/templates/templates_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'utils/global_variables.dart' as globals;
import 'widgets/navigation_drawer_widget.dart';

/// Page handling the navigationDrawer and bottomNavigationBar.
class ETBModuleStartPage extends StatefulWidget {
  const ETBModuleStartPage({Key? key}) : super(key: key);

  @override
  State<ETBModuleStartPage> createState() => _ETBModuleStartPageState();
}

class _ETBModuleStartPageState extends State<ETBModuleStartPage> {
  // Index of the bottomNavigationBar
  int currentIndex = 0;

  // Pages of the bottomNavigationBar
  final pages = [
    const ETBsPage(),
    EntriesPage(),
    const TemplatesPage(),
    const SettingsPage(),
  ];

  /// Dispose method that runs when ETB-Module is closed.
  @override
  void dispose() {
    // Close ETB box/database
    Hive.box('etbBox').close();
    Hive.box('templateBox').close();
    Hive.box('settingsBox').close();

    super.dispose();
  }

  /// Callback function that drawer can call to change the [index] of bottomNavigationBar.
  void callbackDrawer(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  /// Build view with navigationDrawer, bottomNavigationBar and the current page.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globals.scaffoldKey,
      body: pages[currentIndex],
      drawer: NavigationDrawerWidget(callbackDrawer),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
                currentIndex = index;
              }),
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(Ionicons.book_outline),
              activeIcon: FaIcon(Ionicons.book),
              label: 'ETBs',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(Ionicons.file_tray_full_outline),
              activeIcon: FaIcon(Ionicons.file_tray_full),
              label: 'Einträge',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(Ionicons.albums_outline),
              activeIcon: FaIcon(Ionicons.albums),
              label: 'Vorlagen',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(Ionicons.settings_outline),
              activeIcon: FaIcon(Ionicons.settings),
              label: 'Einstellungen',
            ),
          ]),
    );
  }
}
