import 'package:einsatz_helper/module_etb/model/etb_data.dart';
import 'package:einsatz_helper/module_etb/model/etb_entry_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataBox {
  static Box<ETBData> getETBs() => Hive.box<ETBData>('etbBox');

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
}
