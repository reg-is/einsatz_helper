import 'package:hive/hive.dart';
import 'etb_entry_data.dart';

part 'etb_data.g.dart';

@HiveType(typeId: 0)
class ETBData extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String leader;

  @HiveField(3)
  late String etbWriter;

  @HiveField(4)
  bool finished = false;

  @HiveField(5)
  late DateTime startedDate;

  @HiveField(6)
  int attachmentsSum = 0;

  @HiveField(7)
  late List<ETBEntryData> entries;
}
