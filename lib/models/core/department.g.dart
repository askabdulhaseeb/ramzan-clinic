// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DepartmentAdapter extends TypeAdapter<Department> {
  @override
  final int typeId = 201;

  @override
  Department read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Department(
      title: fields[1] == null ? 'null' : fields[1] as String,
      departmentID: fields[0] == null ? 'null' : fields[0] as String?,
      registerBy: fields[2] == null ? 'null' : fields[2] as String?,
      registerDate: fields[3] as DateTime?,
      lastUpdate: fields[4] as DateTime?,
      isActive: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Department obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.departmentID)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.registerBy)
      ..writeByte(3)
      ..write(obj.registerDate)
      ..writeByte(4)
      ..write(obj.lastUpdate)
      ..writeByte(5)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DepartmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
