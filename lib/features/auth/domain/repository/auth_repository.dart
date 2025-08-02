import 'package:logitracker/features/auth/domain/entity/auth_response_entity.dart';
import 'package:logitracker/features/auth/domain/entity/login_entity.dart';
import 'package:logitracker/features/auth/domain/entity/signup_entity.dart';
import 'package:logitracker/features/profile/domain/entity/change_password_entity.dart';

abstract interface class IAuthRepository {
  Future<AuthResponseEntity> loginuser(LoginEntity model);
  Future<void> registerUser(SignupEntity model);
  Future<String> changePassword(ChangePasswordEntity model);
}
