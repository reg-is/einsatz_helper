// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TemplateDataAdapter extends TypeAdapter<TemplateData> {
  @override
  final int typeId = 2;

  @override
  TemplateData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TemplateData()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..counterpart = fields[2] as String?
      ..description = fields[3] as String?
      ..comment = fields[4] as String?
      ..creationTime = fields[5] as DateTime
      ..modificationTime = fields[6] as DateTime;
  }

  @override
  void write(BinaryWriter writer, TemplateData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.counterpart)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.comment)
      ..writeByte(5)
      ..write(obj.creationTime)
      ..writeByte(6)
      ..write(obj.modificationTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemplateDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
