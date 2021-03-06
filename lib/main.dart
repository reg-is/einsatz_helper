import 'package:einsatz_helper/module_etb/model/attachment_data.dart';
import 'package:einsatz_helper/module_etb/model/etb_data.dart';
import 'package:einsatz_helper/module_etb/model/etb_entry_data.dart';
import 'package:einsatz_helper/module_etb/model/template_data.dart';
import 'package:einsatz_helper/module_etb/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'module_etb/etb_module_start_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// The main function is called when the the app starts.
Future<void> main() async {
  // Initiate and create Hive database for ETBs.
  await Hive.initFlutter();
  Hive.registerAdapter(ETBDataAdapter());
  Hive.registerAdapter(ETBEntryDataAdapter());
  Hive.registerAdapter(AttachmentDataAdapter());
  Hive.registerAdapter(TemplateDataAdapter());
  await Hive.openBox<ETBData>('etbBox');
  await Hive.openBox<TemplateData>('templateBox');
  await Hive.openBox('settingsBox');

  // Start App by displaying the MyApp widget.
  runApp(const MyApp());
}

/// Widget displayed when App starts.
/// Loads ETBModuleStartPage() on the screen.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Einsatz Helper',
      debugShowCheckedModeBanner: false,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: ThemeMode.system,
      supportedLocales: const [Locale('de')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      home: const ETBModuleStartPage(),
    );
  }
}
