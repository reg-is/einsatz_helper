// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttachmentDataAdapter extends TypeAdapter<AttachmentData> {
  @override
  final int typeId = 3;

  @override
  AttachmentData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttachmentData(
      id: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AttachmentData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttachmentDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
