import 'package:dartz/dartz.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';
import 'package:logitracker_mobile_app/features/auth/data/model/user_hive_model.dart';

abstract class UserDataSource {
  Future<Either<Failure, UserHiveModel>> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String company,
    required String password,
    String? role,
  });
  Future<Either<Failure, UserHiveModel>> login(String email, String password);
  Future<Either<Failure, UserHiveModel>> getCurrentUser(String token);
}
