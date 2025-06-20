import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

class UserGetCurrentUseCase {
  final UserRepository repository;

  UserGetCurrentUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call() async {
    return Left(Failure('Not implemented')); // Placeholder
  }
}
