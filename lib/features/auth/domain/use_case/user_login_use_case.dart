import 'package:dartz/dartz.dart';
import 'package:logitracker/core/error/failure.dart';
import 'package:logitracker/features/auth/domain/entity/user_entity.dart';
import 'package:logitracker/features/auth/domain/repository/user_repository.dart';

class UserLoginUseCase {
  final UserRepository repository;

  UserLoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(
    String email,
    String password,
  ) async {
    return await repository.login(email, password);
  }
}
