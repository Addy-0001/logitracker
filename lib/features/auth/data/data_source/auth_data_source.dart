import 'package:logitracker/features/auth/domain/entity/auth_response_entity.dart';
import 'package:logitracker/features/auth/domain/entity/login_entity.dart';
import 'package:logitracker/features/auth/domain/entity/signup_entity.dart';

abstract interface class IAuthDataSource{
  Future<AuthResponseEntity> loginUser(LoginEntity data);
  Future<void> registerUser(SignupEntity data); 
  Future<String> changePassword(ChangePasswordEntity data); 
}