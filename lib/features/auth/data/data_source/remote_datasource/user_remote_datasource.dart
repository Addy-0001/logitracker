import 'package:dio/dio.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';
import 'package:logitracker_mobile_app/core/common/internet_checker/internet_checker.dart';
import 'package:logitracker_mobile_app/features/auth/data/model/user_hive_model.dart';
import 'package:logitracker_mobile_app/app/constant/api_constants.dart';

class UserRemoteDataSource {
  final Dio dio;
  final InternetChecker internetChecker;

  UserRemoteDataSource(this.dio, this.internetChecker);

  Future<UserHiveModel> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String company,
    required String password,
    String? role,
  }) async {
    if (!await internetChecker.hasConnection()) {
      throw NetworkFailure('No internet connection');
    }
    try {
      final response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.signupEndpoint,
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'company': company,
          'password': password,
          'role': role ?? 'driver',
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      print('Signup response: ${response.statusCode} - ${response.data}');

      if (response.statusCode == 201) {
        return UserHiveModel.fromJson(response.data as Map<String, dynamic>);
      } else if (response.statusCode == 400) {
        final errorData = response.data as Map<String, dynamic>;
        throw ServerFailure(errorData['message'] ?? 'Signup failed');
      } else {
        throw ServerFailure(
          'Unexpected error: ${response.statusCode} - ${response.data}',
        );
      }
    } on DioException catch (e) {
      throw ServerFailure(_handleDioError(e));
    } catch (e) {
      throw ServerFailure('Signup error: $e');
    }
  }

  Future<UserHiveModel> login(String email, String password) async {
    if (!await internetChecker.hasConnection()) {
      throw NetworkFailure('No internet connection');
    }
    try {
      final response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.loginEndpoint,
        data: {'email': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      print('Login response: ${response.statusCode} - ${response.data}');

      if (response.statusCode == 200) {
        return UserHiveModel.fromJson(response.data as Map<String, dynamic>);
      } else if (response.statusCode == 400 || response.statusCode == 403) {
        final errorData = response.data as Map<String, dynamic>;
        throw ServerFailure(errorData['message'] ?? 'Login failed');
      } else {
        throw ServerFailure(
          'Unexpected error: ${response.statusCode} - ${response.data}',
        );
      }
    } on DioException catch (e) {
      throw ServerFailure(_handleDioError(e));
    } catch (e) {
      throw ServerFailure('Login error: $e');
    }
  }

  Future<UserHiveModel> getCurrentUser(String token) async {
    if (!await internetChecker.hasConnection()) {
      throw NetworkFailure('No internet connection');
    }
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.userEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('Get user response: ${response.statusCode} - ${response.data}');

      if (response.statusCode == 200) {
        return UserHiveModel.fromJson(response.data as Map<String, dynamic>);
      } else if (response.statusCode == 401 || response.statusCode == 404) {
        final errorData = response.data as Map<String, dynamic>;
        throw ServerFailure(errorData['message'] ?? 'Failed to fetch user');
      } else {
        throw ServerFailure(
          'Unexpected error: ${response.statusCode} - ${response.data}',
        );
      }
    } on DioException catch (e) {
      throw ServerFailure(_handleDioError(e));
    } catch (e) {
      throw ServerFailure('Get user error: $e');
    }
  }

  String _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection timeout';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return 'Receive timeout';
    } else if (e.type == DioExceptionType.badResponse) {
      final response = e.response;
      final statusCode = response?.statusCode;
      final data = response?.data;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        return data['message'] as String;
      }
      return 'Bad response: $statusCode - $data';
    } else if (e.type == DioExceptionType.connectionError) {
      return 'Connection error: ${e.message}';
    } else {
      return 'Network error: ${e.message}';
    }
  }
}
