import 'attachment_data.dart';
import 'package:hive/hive.dart';

part 'etb_entry_data.g.dart';

/// Data model for an entry.
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

  @HiveField(7)
  List<AttachmentData>? attachments;

  /// Returns an [ETBEntryData] object as string.
  @override
  String toString() {
    return '{id=$id, captureTime=$captureTime, eventTime=$eventTime, counterpart=$counterpart, description=$description, comment=$comment, reference=$reference, attachments=${attachments.toString()}}';
  }

  /// Get [captureTime] in Date Time Group (DTG) format.
  String get captureTimeAsDTG => toDTG(captureTime);

  /// Get [eventTime] in Date Time Group (DTG) format.
  String get eventTimeAsDTG {
    return (eventTime != null) ? toDTG(eventTime!) : '';
  }
}

/// Converts [dateTime] to a String in Date Time Group (DTG) format.
String toDTG(DateTime dateTime) {
  dateTime.toUtc();
  List<String> months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];
  return '${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}${dateTime.minute.toString().padLeft(2, '0')}${months[dateTime.month - 1]}${dateTime.year.toString().substring(2, 4)}';
}

/// Create a list of AttachmentData of size [attachmentsCount]
/// and generate attachment IDs with [entryID].
List<AttachmentData> createAttachments(int entryID, int attachmentsCount) {
  List<AttachmentData> attachments = [];
  for (var i = 1; i <= attachmentsCount; i++) {
    attachments.add(AttachmentData(id: '$entryID-$i'));
  }
  return attachments;
}

/// Converts a list of AttachmentData [attachments] to a String with comma separated IDs.
String attachmentsAsText(List<AttachmentData> attachments) {
  String text = '';
  for (int i = 0; i < attachments.length; i++) {
    AttachmentData attachment = attachments[i];
    if (i < attachments.length - 1) {
      text += '${attachment.id}, ';
    } else {
      text += attachment.id;
    }
  }
  return text;
}
