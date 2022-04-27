import 'package:hive/hive.dart';

part 'etb_entry_data.g.dart';

@HiveType(typeId: 1)
class ETBEntryData extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late DateTime captureTime;

  @HiveField(2)
  DateTime? eventTime;

  @HiveField(3)
  String? counterpart;

  @HiveField(4)
  late String description;

  @HiveField(5)
  String? comment;

  @HiveField(6)
  int? reference;

  // @HiveField(7)
  // List? attachments;
}
