import 'package:hive/hive.dart';

part 'template_data.g.dart';

/// Data model for an template.
@HiveType(typeId: 2)
class TemplateData extends HiveObject {
  @HiveField(0)
  late String id = key.toString();

  @HiveField(1)
  late String name;

  @HiveField(2)
  String? counterpart;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? comment;

  @HiveField(5)
  late DateTime creationTime;

  @HiveField(6)
  late DateTime modificationTime;

  TemplateData();

  TemplateData.build(
      {required this.id,
      required this.name,
      this.counterpart,
      this.description,
      this.comment,
      required this.creationTime,
      required this.modificationTime});

  /// Returns an [TemplateData] object as string.
  @override
  String toString() {
    return '{name=$name, id=$id, counterpart=$counterpart, description=$description, comment=$comment, creationTime=$creationTime, modificationTime=$modificationTime}';
  }
}
