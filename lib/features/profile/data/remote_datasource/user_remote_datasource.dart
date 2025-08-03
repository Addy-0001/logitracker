import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logitracker/core/constant/api_endpoints.dart';
import 'package:logitracker/dependency_inject.dart';
import 'package:logitracker/features/profile/domain/entity/user_entity.dart';
import 'package:logitracker/features/profile/data/user_data_source.dart';
import 'package:logitracker/services/core/http_service.dart';
import 'package:logitracker/services/core/preference_service.dart';

class UserRemoteDatasource implements IUserDataSoure {
  final HttpService _httpService;

  UserRemoteDatasource(this._httpService);

  @override
  Future<UserEntity> getUserInformation() async {
    var uid = locator<PreferenceService>().userName;

    var response = await _httpService.getData(
      "${ApiEndpoints.getUserProfile}/$uid",
    );
    print(response);
    return UserEntity.fromMap(response['user']);
  }

  @override
  Future<String> updateUser(UserEntity data) async {
    // Create a map with only allowed fields
    final allowedUpdates = {
      'firstName': data.firstName,
      'lastName': data.lastName,
      'email': data.email,
      'phone': data.phone,
    };

    var response = await _httpService.patchData(
      ApiEndpoints.updateProfile,
      data: allowedUpdates, // Send only allowed fields
    );
    return response['message'].toString();
  }

  @override
  Future<String> uploadProfileImage(String imagePath) async {
    var file = await MultipartFile.fromFile(
      imagePath,
      filename: imagePath.split('/').last,
    );

    FormData formData = FormData.fromMap({'file': file});

    var response = await _httpService.patchFileUpload(
      ApiEndpoints.uploadAvatar, // define this endpoint
      fieldName: 'avatar',
      file: File(imagePath),
    );

    // Return the new image URL
    return response['image'] as String;
  }
}
