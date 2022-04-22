import 'package:einsatz_helper/theme.dart';
import 'package:flutter/material.dart';
import 'module_etb/etb_start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: ThemeMode.system,
      home: const ETBStartPage(),
    );
  }
}

