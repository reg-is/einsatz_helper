import 'package:hive/hive.dart';

part 'attachment_data.g.dart';

@HiveType(typeId: 3)
class AttachmentData extends HiveObject {
  @HiveField(0)
  late String id;
}