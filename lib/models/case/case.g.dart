// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CaseAdapter extends TypeAdapter<Case> {
  @override
  final int typeId = 51;

  @override
  Case read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Case(
      caseID: fields[0] as String,
      tokenID: fields[1] as String,
      patientID: fields[2] as String,
      departmentID: fields[14] as String,
      doctorID: fields[3] as String,
      operatorID: fields[4] as String,
      counterID: fields[5] as String,
      items: (fields[6] as List).cast<CaseItem>(),
      discountInPercent: fields[7] as double,
      discountInRupees: fields[8] as double,
      payable: fields[9] as double,
      paidAmount: fields[10] as double,
      reigsterDate: fields[11] as DateTime,
      lastUpdate: fields[12] as DateTime,
      isLive: fields[13] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Case obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.caseID)
      ..writeByte(1)
      ..write(obj.tokenID)
      ..writeByte(2)
      ..write(obj.patientID)
      ..writeByte(3)
      ..write(obj.doctorID)
      ..writeByte(4)
      ..write(obj.operatorID)
      ..writeByte(5)
      ..write(obj.counterID)
      ..writeByte(6)
      ..write(obj.items)
      ..writeByte(7)
      ..write(obj.discountInPercent)
      ..writeByte(8)
      ..write(obj.discountInRupees)
      ..writeByte(9)
      ..write(obj.payable)
      ..writeByte(10)
      ..write(obj.paidAmount)
      ..writeByte(11)
      ..write(obj.reigsterDate)
      ..writeByte(12)
      ..write(obj.lastUpdate)
      ..writeByte(13)
      ..write(obj.isLive)
      ..writeByte(14)
      ..write(obj.departmentID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
