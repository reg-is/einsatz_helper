import 'package:hive/hive.dart';

part 'attachment_data.g.dart';

@HiveType(typeId: 3)
class AttachmentData extends HiveObject {
  @HiveField(0)
  late String id;

  // @HiveField(1)
  // String? filePath;

  // @HiveField(2)
  // num? fileSize;

  AttachmentData({required this.id});

  @override
  String toString() {
    return '{id=$id}';
  }
}
