import 'package:dio/dio.dart';
import 'package:logitracker/core/error/failure.dart';
import 'package:logitracker/features/auth/domain/entity/user_entity.dart';

class UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSource(this.dio);

  Future<UserEntity> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/users/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = response.data['user'];
        return UserEntity(
          userId: data['userId'],
          firstName: data['firstName'],
          lastName: data['lastName'],
          email: data['email'],
          password: data['password'],
          company: '',
          phone: '',
          position: '',
          avatar: '',
          industry: '',
          size: '',
          website: '',
          address: '',
          preferences: '',
          role: '',
        );
      } else {
        throw Failure('Login failed: ${response.data['error'] ?? 'Unknown error'}');
      }
    } on DioException catch (e) {
      throw Failure('Login failed: ${e.response?.data['error'] ?? e.message ?? 'Network error'}');
    }
  }

  Future<UserEntity> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await dio.post(
        '/users/register',
        data: {
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
        },
      );

      if (response.statusCode == 201) {
        final data = response.data['user'];
        return UserEntity(
          userId: data['userId'],
          firstName: data['firstName'],
          lastName: data['lastName'],
          email: data['email'],
          password: data['password'],
          company: '',
          phone: '',
          position: '',
          avatar: '',
          industry: '',
          size: '',
          website: '',
          address: '',
          preferences: '',
          role: '',
        );
      } else {
        throw Failure('Registration failed: ${response.data['error'] ?? 'Unknown error'}');
      }
    } on DioException catch (e) {
      throw Failure('Registration failed: ${e.response?.data['error'] ?? e.message ?? 'Network error'}');
    }
  }
}