// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procigar_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProcigarTypeAdapter extends TypeAdapter<ProcigarType> {
  @override
  final int typeId = 32;

  @override
  ProcigarType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ProcigarType.test;
      case 1:
        return ProcigarType.procigar;
      default:
        return ProcigarType.test;
    }
  }

  @override
  void write(BinaryWriter writer, ProcigarType obj) {
    switch (obj) {
      case ProcigarType.test:
        writer.writeByte(0);
        break;
      case ProcigarType.procigar:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProcigarTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
