import 'package:einsatz_helper/module_etb/entries_page.dart';
import 'package:einsatz_helper/module_etb/etbs_page.dart';
import 'package:einsatz_helper/module_etb/settings_page.dart';
import 'package:einsatz_helper/module_etb/templates_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ETBStartPage extends StatefulWidget {
  const ETBStartPage({Key? key}) : super(key: key);

  @override
  State<ETBStartPage> createState() => _ETBStartPageState();
}

class _ETBStartPageState extends State<ETBStartPage> {
  int currentIdx = 0;
  final screens = const [
    ETBsPage(),
    EntriesPage(),
    TemplatesPage(),
    SettingsPage(),
  ];
  
  // Method runs when ETB-App is closed
  @override
  void dispose(){
    // Close ETB box/database
    Hive.box('etbBox').close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIdx],
      bottomNavigationBar: BottomNavigationBar(
          //elevation: 8,
          type: BottomNavigationBarType.fixed,
          //backgroundColor: Color.fromARGB(255, 220, 219, 219),
          currentIndex: currentIdx,
          onTap: (index) => setState(() {
                currentIdx = index;
              }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Ionicons.book_outline),
              activeIcon: Icon(Ionicons.book),
              label: 'ETBs',
              // backgroundColor: Colors.yellow,
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.file_tray_full_outline),
              activeIcon: Icon(Ionicons.file_tray_full),
              label: 'Einträge',
              //backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.albums_outline),
              activeIcon: Icon(Ionicons.albums),
              label: 'Vorlagen',
              // backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.settings_outline),
              activeIcon: Icon(Ionicons.settings),
              label: 'Einstellungen',
              // backgroundColor: Colors.green,
            ),
          ]),
    );
  }
}
