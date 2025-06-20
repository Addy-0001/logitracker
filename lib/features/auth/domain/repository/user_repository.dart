import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String company,
    required String phone,
    required String position,
    required String avatar,
    required String industry,
    required String size,
    required String website,
    required String address,
    required String preferences,
  });
}
