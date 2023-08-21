// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashback.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CashbackAdapter extends TypeAdapter<Cashback> {
  @override
  final int typeId = 1;

  @override
  Cashback read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cashback(
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Cashback obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CashbackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
