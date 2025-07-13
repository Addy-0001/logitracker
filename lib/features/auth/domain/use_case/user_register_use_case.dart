import 'package:dartz/dartz.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';
import 'package:logitracker_mobile_app/features/auth/domain/entity/user_entity.dart';
import 'package:logitracker_mobile_app/features/auth/domain/repository/user_repository.dart';

class UserRegisterUseCase {
  final UserRepository repository;

  UserRegisterUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String company,
    required String password,
    String? role,
  }) async {
    return await repository.signup(
      firstName: firstName,
      lastName: lastName,
      email: email,
      company: company,
      password: password,
      role: role,
    );
  }
}
