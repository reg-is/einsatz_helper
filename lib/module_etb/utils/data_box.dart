import 'package:einsatz_helper/module_etb/model/etb_data.dart';
import 'package:einsatz_helper/module_etb/model/etb_entry_data.dart';
import 'package:einsatz_helper/module_etb/model/template_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Collection of methods to access boxes and manipulate data.
class DataBox {
  /// Gets the box containing all ETBs.
  static Box<ETBData> getETBs() => Hive.box<ETBData>('etbBox');

  /// Gets the box containing all templates.
  static Box<TemplateData> getTemplates() =>
      Hive.box<TemplateData>('templateBox');

  /// Gets the box containing all settings.
  static Box getSettings() => Hive.box('settingsBox');

  /// Adds [entry] to the etb with the key: [etbKey].
  static void appendEntry(dynamic etbKey, ETBEntryData entry) {
    final etbBox = DataBox.getETBs();
    ETBData? etb = etbBox.get(etbKey);
    if (etb != null) {
      List<ETBEntryData>? entries = etb.entries;
      entries != null ? entries.add(entry) : entries = [entry];
      etb.entries = entries;
      etbBox.put(etbKey, etb);
      print('Append done');
    } else {
      print('No ETB with key=$etbKey found');
    }
  }

  /// Returns the ID the next entry should have inside a etb with the key: [etbKey].
  static int getNextEntryID(dynamic etbKey) {
    final etbBox = DataBox.getETBs();
    ETBData? etb = etbBox.get(etbKey);
    if (etb != null) {
      List<ETBEntryData>? entries = etb.entries;
      return entries != null ? entries.length + 1 : 1;
    } else {
      print('etb is null');
      return 1;
    }
  }

  /// Returns the etb‚ associated with the given [etbKey]. If the key does not exist, null is returned.
  static ETBData? getETBByKey(dynamic etbKey) => getETBs().get(etbKey);
}
