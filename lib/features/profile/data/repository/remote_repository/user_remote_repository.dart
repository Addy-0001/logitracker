import 'package:logitracker/features/profile/data/remote_datasource/user_remote_datasource.dart';
import 'package:logitracker/features/profile/domain/entity/user_entity.dart';
import 'package:logitracker/features/profile/domain/repository/user_repository.dart';

class UserRemoteRepository implements IUserRepository {
  final UserRemoteDatasource _datasource;

  UserRemoteRepository(this._datasource);

  @override
  Future<UserEntity> getUserInformation() async {
    return await _datasource.getUserInformation();
  }

  @override
  Future<String> updateUser(UserEntity data) async {
    return await _datasource.updateUser(data);
  }
}
