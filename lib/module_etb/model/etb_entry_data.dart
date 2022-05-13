import 'attachment_data.dart';
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

  @HiveField(7)
  List<AttachmentData>? attachments;

  @override
  String toString() {
    return '{id=$id, captureTime=$captureTime, eventTime=$eventTime, counterpart=$counterpart, description=$description, comment=$comment, reference=$reference}';
  }

  // Get captureTime in Date Time Group (DTG) format
  String get captureTimeAsDTG => toDTG(captureTime);

  // Get eventTime in Date Time Group (DTG) format
  String get eventTimeAsDTG {
    return (eventTime != null) ? toDTG(eventTime!) : '';
  }
}

// Converts a DateTime object to a String in Date Time Group (DTG) format
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
  return '${dateTime.day.toString().padLeft(2,'0')} ${dateTime.hour.toString().padLeft(2,'0')}${dateTime.minute.toString().padLeft(2,'0')}${months[dateTime.month - 1]}${dateTime.year.toString().substring(2, 4)}';
}
