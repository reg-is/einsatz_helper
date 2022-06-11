import 'package:hive/hive.dart';

part 'attachment_data.g.dart';

/// Data model for an attachment.
@HiveType(typeId: 3)
class AttachmentData extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  String? filePath;

  @HiveField(2)
  num? fileSize;

  AttachmentData({required this.id});

  /// Returns an [AttachmentData] object as string.
  @override
  String toString() {
    return '{id=$id, filePath=$filePath, fileSize=$fileSize}';
  }
}
