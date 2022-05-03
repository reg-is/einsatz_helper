import 'package:einsatz_helper/module_etb/model/etb_data.dart';
import 'package:einsatz_helper/module_etb/model/etb_entry_data.dart';
import 'package:einsatz_helper/theme.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'module_etb/etb_start_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

late Box box;
Future<void> main() async {
  // Initiate and create Hive database for ETBs
  await Hive.initFlutter();
  Hive.registerAdapter(ETBDataAdapter());
  Hive.registerAdapter(ETBEntryDataAdapter());
  await Hive.openBox<ETBData>('etbBox');

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
      supportedLocales: [Locale('de')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      home: const ETBStartPage(),
    );
  }
}
