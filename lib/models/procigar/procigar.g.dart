// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procigar.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProcigarAdapter extends TypeAdapter<Procigar> {
  @override
  final int typeId = 31;

  @override
  Procigar read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Procigar(
      name: fields[1] as String,
      fee: fields[2] as double,
      discountInPercent: fields[3] as double,
      type: fields[8] as ProcigarType,
      testID: fields[0] as String?,
      discountInRupees: fields[4] as double?,
      addBy: fields[5] as String?,
      registerTime: fields[6] as DateTime?,
      lastUpdate: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Procigar obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.testID)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.fee)
      ..writeByte(3)
      ..write(obj.discountInPercent)
      ..writeByte(4)
      ..write(obj.discountInRupees)
      ..writeByte(5)
      ..write(obj.addBy)
      ..writeByte(6)
      ..write(obj.registerTime)
      ..writeByte(7)
      ..write(obj.lastUpdate)
      ..writeByte(8)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProcigarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
