// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BankCardAdapter extends TypeAdapter<BankCard> {
  @override
  final int typeId = 0;

  @override
  BankCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BankCard(
      bankName: fields[0] as String,
      cashbackCategories: (fields[1] as List).cast<Cashback>(),
      lastUpdate: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BankCard obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.bankName)
      ..writeByte(1)
      ..write(obj.cashbackCategories)
      ..writeByte(2)
      ..write(obj.lastUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
