import 'package:einsatz_helper/module_etb/model/etb_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataBox {
  static Box<ETBData> getETBs() => Hive.box<ETBData>('etbBox');
}
