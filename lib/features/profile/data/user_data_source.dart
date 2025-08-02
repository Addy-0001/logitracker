import 'package:logitracker/features/profile/domain/entity/user_entity.dart';

abstract interface class IUserDataSoure {
  Future<UserEntity> getUserInformation();
  Future<String> updateUser(UserEntity data);
}
