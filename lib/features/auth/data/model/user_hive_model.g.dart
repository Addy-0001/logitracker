// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHiveModelAdapter extends TypeAdapter<UserHiveModel> {
  @override
  final int typeId = 0;

  @override
  UserHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserHiveModel(
      userId: fields[0] as String?,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      email: fields[3] as String,
      password: fields[4] as String,
      company: fields[5] as String,
      phone: fields[6] as String,
      position: fields[7] as String,
      avatar: fields[8] as String,
      industry: fields[9] as String,
      size: fields[10] as String,
      website: fields[11] as String,
      address: fields[12] as String,
      preferences: fields[13] as String,
      role: fields[14] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserHiveModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.company)
      ..writeByte(6)
      ..write(obj.phone)
      ..writeByte(7)
      ..write(obj.position)
      ..writeByte(8)
      ..write(obj.avatar)
      ..writeByte(9)
      ..write(obj.industry)
      ..writeByte(10)
      ..write(obj.size)
      ..writeByte(11)
      ..write(obj.website)
      ..writeByte(12)
      ..write(obj.address)
      ..writeByte(13)
      ..write(obj.preferences)
      ..writeByte(14)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
