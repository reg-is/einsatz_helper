// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'etb_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ETBDataAdapter extends TypeAdapter<ETBData> {
  @override
  final int typeId = 0;

  @override
  ETBData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ETBData()
      ..id = fields[0] as int
      ..name = fields[1] as String
      ..leader = fields[2] as String
      ..etbWriter = fields[3] as String
      ..finished = fields[4] as bool
      ..startedDate = fields[5] as DateTime
      ..attachmentsCount = fields[6] as int;
  }

  @override
  void write(BinaryWriter writer, ETBData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.leader)
      ..writeByte(3)
      ..write(obj.etbWriter)
      ..writeByte(4)
      ..write(obj.finished)
      ..writeByte(5)
      ..write(obj.startedDate)
      ..writeByte(6)
      ..write(obj.attachmentsCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ETBDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
