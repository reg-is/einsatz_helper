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
  return '${dateTime.day} ${dateTime.hour}${dateTime.minute}${months[dateTime.month - 1]}${dateTime.year.toString().substring(2, 4)}';
}
