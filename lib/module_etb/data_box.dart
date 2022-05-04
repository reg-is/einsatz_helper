import 'package:einsatz_helper/module_etb/model/etb_data.dart';
import 'package:einsatz_helper/module_etb/model/etb_entry_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataBox {
  // Gets the box containing all ETBs
  static Box<ETBData> getETBs() => Hive.box<ETBData>('etbBox');

  // Adds [entry] to the etb with the key: [etbKey[]
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

  // Returns the ID a new entry should have
  static int getNextEntryID(dynamic etbKey) {
    final etbBox = DataBox.getETBs();
    ETBData? etb = etbBox.get(etbKey);
    if (etb != null) {
      List<ETBEntryData>? entries = etb.entries;
      print('entries length: ${entries!.length}');
      return entries != null ? entries.length + 1 : 1;
    } else {
      print('etb is null');
      return 1;
    }
  }

  // Returns true if the Hive Box 'etbBox' is empty
  static bool isEmpty = getETBs().values.isEmpty;

  // Returns the etb‚ associated with the given [key]. If the key does not exist, null is returned.
  static ETBData? getETBByKey(dynamic etbKey) => getETBs().get(etbKey);
}
