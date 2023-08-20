// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppUserAdapter extends TypeAdapter<AppUser> {
  @override
  final int typeId = 11;

  @override
  AppUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppUser(
      uid: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      imageURL: fields[4] as String,
      department: fields[5] as Department,
      phoneNumber: (fields[6] as List).cast<String>(),
      jobDescription: fields[7] as String,
      salary: fields[8] as double,
      address: fields[9] as Address,
      routine: (fields[11] as List?)?.cast<Routine>(),
      password: fields[14] as String,
      isAdmin: fields[3] as bool,
      isRegistered: fields[15] as bool,
      fullAddress: fields[10] as String?,
      registerDate: fields[12] as DateTime?,
      lastUpdate: fields[13] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, AppUser obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.isAdmin)
      ..writeByte(4)
      ..write(obj.imageURL)
      ..writeByte(5)
      ..write(obj.department)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(7)
      ..write(obj.jobDescription)
      ..writeByte(8)
      ..write(obj.salary)
      ..writeByte(9)
      ..write(obj.address)
      ..writeByte(10)
      ..write(obj.fullAddress)
      ..writeByte(11)
      ..write(obj.routine)
      ..writeByte(12)
      ..write(obj.registerDate)
      ..writeByte(13)
      ..write(obj.lastUpdate)
      ..writeByte(14)
      ..write(obj.password)
      ..writeByte(15)
      ..write(obj.isRegistered);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
