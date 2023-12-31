// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CounterAdapter extends TypeAdapter<Counter> {
  @override
  final int typeId = 53;

  @override
  Counter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Counter(
      openingCash: fields[4] as double,
      cashInCounter: fields[5] as double,
      counterID: fields[0] as String?,
      uid: fields[1] as String?,
      isOpened: fields[6] as bool,
      counterCases: fields[2] as int,
      dayCases: fields[3] as int,
      lastUpdate: fields[10] as DateTime?,
      openingTime: fields[7] as DateTime?,
      closingTime: fields[8] as DateTime?,
      isLive: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Counter obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.counterID)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.counterCases)
      ..writeByte(3)
      ..write(obj.dayCases)
      ..writeByte(4)
      ..write(obj.openingCash)
      ..writeByte(5)
      ..write(obj.cashInCounter)
      ..writeByte(6)
      ..write(obj.isOpened)
      ..writeByte(7)
      ..write(obj.openingTime)
      ..writeByte(8)
      ..write(obj.closingTime)
      ..writeByte(9)
      ..write(obj.isLive)
      ..writeByte(10)
      ..write(obj.lastUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
