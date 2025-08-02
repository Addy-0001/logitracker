import 'package:logitracker/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:logitracker/features/auth/domain/entity/auth_response_entity.dart';
import 'package:logitracker/features/auth/domain/entity/login_entity.dart';
import 'package:logitracker/features/auth/domain/entity/signup_entity.dart';
import 'package:logitracker/features/auth/domain/repository/auth_repository.dart';
import 'package:logitracker/features/profile/domain/entity/change_password_entity.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRemoteRepository(this._authRemoteDatasource);

  @override
  Future<String> changePassword(ChangePasswordEntity model) async {
    return await _authRemoteDatasource.changePassword(model);
  }

  @override
  Future<AuthResponseEntity> loginuser(LoginEntity model) async {
    return await _authRemoteDatasource.loginUser(model);
  }

  @override
  Future<void> registerUser(SignupEntity model) async {
    await _authRemoteDatasource.registerUser(model);
  }
}
