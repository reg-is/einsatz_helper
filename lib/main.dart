import 'package:einsatz_helper/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'module_etb/etb_start_page.dart';

late Box box;
Future<void> main() async {
  await Hive.initFlutter();
  box = await Hive.openBox('etbBox');
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

