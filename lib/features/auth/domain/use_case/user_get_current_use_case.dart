import 'package:dartz/dartz.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';
import 'package:logitracker_mobile_app/features/auth/domain/entity/user_entity.dart';
import 'package:logitracker_mobile_app/features/auth/domain/repository/user_repository.dart';

class UserGetCurrentUseCase {
  final UserRepository repository;

  UserGetCurrentUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call() async {
    return await repository.getCurrentUser();
  }
}
