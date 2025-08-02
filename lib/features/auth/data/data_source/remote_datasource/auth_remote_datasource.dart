import 'package:logitracker/core/constant/api_endpoints.dart';
import 'package:logitracker/features/auth/data/data_source/auth_data_source.dart';
import 'package:logitracker/features/auth/domain/entity/auth_response_entity.dart';
import 'package:logitracker/features/auth/domain/entity/login_entity.dart';
import 'package:logitracker/features/auth/domain/entity/signup_entity.dart';
import 'package:logitracker/features/profile/domain/entity/change_password_entity.dart';
import 'package:logitracker/services/core/http_service.dart';

class AuthRemoteDatasource implements IAuthDataSource {
  final HttpService _httpService;

  AuthRemoteDatasource(this._httpService);

  @override
  Future<String> changePassword(ChangePasswordEntity data) async {
    var response = await _httpService.postDataJson(
      ApiEndpoints.updatePassword,
      data: data.toMap(),
    );
    return response['message'].toString();
  }

  @override
  Future<AuthResponseEntity> loginUser(LoginEntity data) async {
    var response = await _httpService.postDataJson(
      ApiEndpoints.login,
      data: data.toMap(),
    );
    return AuthResponseEntity.fromMap(response);
  }

  @override
  Future<void> registerUser(SignupEntity data) async {}
}
