import 'package:logitracker/features/profile/domain/entity/user_entity.dart';

abstract interface class IUserRepository {
  Future<UserEntity> getUserInformation();
  Future<String> updateUser(UserEntity data);
}
