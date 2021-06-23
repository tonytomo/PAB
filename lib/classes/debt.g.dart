// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DebtListAdapter extends TypeAdapter<DebtList> {
  @override
  final int typeId = 3;

  @override
  DebtList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DebtList(
      fields[0] as int,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DebtList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.nom)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebtListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
