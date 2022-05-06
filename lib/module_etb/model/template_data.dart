import 'package:hive/hive.dart';

part 'template_data.g.dart';

@HiveType(typeId: 2)
class TemplateData extends HiveObject {
  @HiveField(0)
  late int id = key;

  @HiveField(1)
  late String name;

  @HiveField(2)
  String? counterpart;

  @HiveField(3)
  late String description;

  @HiveField(4)
  String? comment;

  @HiveField(5)
  late DateTime creationTime;

  @HiveField(6)
  late DateTime modificationTime;
}
