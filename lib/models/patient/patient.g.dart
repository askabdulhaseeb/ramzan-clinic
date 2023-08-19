// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PatientAdapter extends TypeAdapter<Patient> {
  @override
  final int typeId = 21;

  @override
  Patient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Patient(
      name: fields[1] as String,
      lastName: fields[2] as String,
      gender: fields[3] as Gender,
      cnic: fields[4] as String,
      address: fields[5] as Address,
      phoneNumber: fields[7] as String,
      fullAddress: fields[6] as String?,
      patientID: fields[0] as String?,
      registerDate: fields[8] as DateTime?,
      lastUpdate: fields[9] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Patient obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.patientID)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.cnic)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.fullAddress)
      ..writeByte(7)
      ..write(obj.phoneNumber)
      ..writeByte(8)
      ..write(obj.registerDate)
      ..writeByte(9)
      ..write(obj.lastUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
