// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'user_hive_model.dart';

class UserHiveModelAdapter extends TypeAdapter<UserHiveModel> {
  @override
  final int typeId = HiveTableConstant.userTypeId;

  @override
  UserHiveModel read(BinaryReader reader) {
    return UserHiveModel(
      id: reader.read(),
      firstName: reader.read(),
      lastName: reader.read(),
      email: reader.read(),
      company: reader.read(),
      role: reader.read(),
      token: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, UserHiveModel obj) {
    writer.write(obj.id);
    writer.write(obj.firstName);
    writer.write(obj.lastName);
    writer.write(obj.email);
    writer.write(obj.company);
    writer.write(obj.role);
    writer.write(obj.token);
  }
}