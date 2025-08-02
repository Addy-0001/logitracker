import 'package:dio/dio.dart';
import 'package:logitracker/core/constant/api_endpoints.dart';
import 'package:logitracker/core/utility/extension.dart';
import 'package:logitracker/features/profile/domain/entity/user_entity.dart';
import 'package:logitracker/features/profile/data/user_data_source.dart';
import 'package:logitracker/services/core/http_service.dart';

class UserRemoteDatasource implements IUserDataSoure {
  final HttpService _httpService;

  UserRemoteDatasource(this._httpService);

  @override
  Future<UserEntity> getUserInformation() async {
    var response = await _httpService.getData(ApiEndpoints.getUserProfile);
    return UserEntity.fromMap(response);
  }

  @override
  Future<String> updateUser(UserEntity data) async {
    var formData = data.toMap();
    if (data.profileImage != null && !data.profileImage!.isNetworkFile) {
      var file = await MultipartFile.fromFile(
        data.profileImage!,
        filename: data.profileImage!.split('/').last,
      );
      formData['profileImage'] = file;
    }

    var response = await _httpService.putDataFormData(
      ApiEndpoints.updateProfile,
      data: data,
    );
    return response['message'].toString();
  }
}
