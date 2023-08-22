// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressAdapter extends TypeAdapter<Address> {
  @override
  final int typeId = 200;

  @override
  Address read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Address(
      province: fields[2] == null ? 'null' : fields[2] as String,
      district: fields[3] == null ? 'null' : fields[3] as String,
      city: fields[4] == null ? 'null' : fields[4] as String,
      town: fields[5] == null ? 'null' : fields[5] as String,
      string: fields[9] == null ? 'null' : fields[9] as String?,
      addBy: fields[8] == null ? 'null' : fields[8] as String?,
      addressID: fields[0] == null ? 'null' : fields[0] as String?,
      country: fields[1] == null ? 'null' : fields[1] as String?,
      registerDate: fields[6] as DateTime?,
      lastUpdate: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Address obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.addressID)
      ..writeByte(1)
      ..write(obj.country)
      ..writeByte(2)
      ..write(obj.province)
      ..writeByte(3)
      ..write(obj.district)
      ..writeByte(4)
      ..write(obj.city)
      ..writeByte(5)
      ..write(obj.town)
      ..writeByte(6)
      ..write(obj.registerDate)
      ..writeByte(7)
      ..write(obj.lastUpdate)
      ..writeByte(8)
      ..write(obj.addBy)
      ..writeByte(9)
      ..write(obj.string);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
