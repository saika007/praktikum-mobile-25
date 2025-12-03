// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PurchaseHistoryAdapter extends TypeAdapter<PurchaseHistory> {
  @override
  final int typeId = 2;

  @override
  PurchaseHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PurchaseHistory(
      items: (fields[0] as List).cast<CartItem>(),
      total: fields[1] as double,
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PurchaseHistory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.items)
      ..writeByte(1)
      ..write(obj.total)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PurchaseHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
