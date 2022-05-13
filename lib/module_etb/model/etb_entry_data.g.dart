// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'etb_entry_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ETBEntryDataAdapter extends TypeAdapter<ETBEntryData> {
  @override
  final int typeId = 1;

  @override
  ETBEntryData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ETBEntryData()
      ..id = fields[0] as int
      ..captureTime = fields[1] as DateTime
      ..eventTime = fields[2] as DateTime?
      ..counterpart = fields[3] as String?
      ..description = fields[4] as String
      ..comment = fields[5] as String?
      ..reference = fields[6] as int?
      ..attachments = (fields[7] as List?)?.cast<AttachmentData>();
  }

  @override
  void write(BinaryWriter writer, ETBEntryData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.captureTime)
      ..writeByte(2)
      ..write(obj.eventTime)
      ..writeByte(3)
      ..write(obj.counterpart)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.comment)
      ..writeByte(6)
      ..write(obj.reference)
      ..writeByte(7)
      ..write(obj.attachments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ETBEntryDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
