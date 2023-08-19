// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoutineAdapter extends TypeAdapter<Routine> {
  @override
  final int typeId = 203;

  @override
  Routine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Routine(
      day: fields[0] as Day,
      staringHour: fields[1] == null ? 0 : fields[1] as int,
      staringMinute: fields[2] == null ? 0 : fields[2] as int,
      endingHour: fields[3] == null ? 0 : fields[3] as int,
      endingMinute: fields[4] == null ? 0 : fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Routine obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.staringHour)
      ..writeByte(2)
      ..write(obj.staringMinute)
      ..writeByte(3)
      ..write(obj.endingHour)
      ..writeByte(4)
      ..write(obj.endingMinute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
