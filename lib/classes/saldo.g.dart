// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saldo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaldoAdapter extends TypeAdapter<Saldo> {
  @override
  final int typeId = 1;

  @override
  Saldo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Saldo(
      fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Saldo obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.nom);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaldoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
