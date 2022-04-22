import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class ETBStartPage extends StatefulWidget {
  const ETBStartPage({ Key? key }) : super(key: key);

  @override
  State<ETBStartPage> createState() => _ETBStartPageState();
}

class _ETBStartPageState extends State<ETBStartPage> {
    int currentIdx = 0;
  final screens = const [
    Center(
      child: Text(
        'ETB',
        style: TextStyle(fontSize: 60),
      ),
    ),
    Center(
      child: Text(
        'Einträge',
        style: TextStyle(fontSize: 60),
      ),
    ),
    Center(
      child: Text(
        'Vorlagen',
        style: TextStyle(fontSize: 60),
      ),
    ),
    Center(
      child: Text(
        'Einstellungen',
        style: TextStyle(fontSize: 60),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title')),
      body: screens[currentIdx],
      bottomNavigationBar: BottomNavigationBar(
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
              label: 'ETB',
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