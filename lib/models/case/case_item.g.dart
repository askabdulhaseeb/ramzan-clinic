// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CaseItemAdapter extends TypeAdapter<CaseItem> {
  @override
  final int typeId = 52;

  @override
  CaseItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CaseItem(
      id: fields[0] as String,
      isTest: fields[1] as bool,
      price: fields[2] as double,
      quantity: fields[3] as int,
      discountInPercent: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CaseItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isTest)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.discountInPercent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaseItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
