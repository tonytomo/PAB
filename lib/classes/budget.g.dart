// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BudgetListAdapter extends TypeAdapter<BudgetList> {
  @override
  final int typeId = 2;

  @override
  BudgetList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BudgetList(
      fields[0] as String,
      fields[1] as int,
      fields[2] as String,
      fields[3] as DateTime,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BudgetList obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.sym)
      ..writeByte(1)
      ..write(obj.nom)
      ..writeByte(2)
      ..write(obj.ket)
      ..writeByte(3)
      ..write(obj.crDate)
      ..writeByte(4)
      ..write(obj.period);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
