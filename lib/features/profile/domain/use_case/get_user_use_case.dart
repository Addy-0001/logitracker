import 'package:dartz/dartz.dart';
import 'package:logitracker/core/utility/usecase.dart';
import 'package:logitracker/features/profile/domain/entity/user_entity.dart';
import 'package:logitracker/features/profile/domain/repository/user_repository.dart';

class GetUserUseCase implements UsecaseWithoutParams<UserEntity> {
  final IUserRepository _repository;

  GetUserUseCase(this._repository);

  @override
  Future<Either<Exception, UserEntity>> call() async {
    try {
      var response = await _repository.getUserInformation();
      return Right(response);
    } catch (e) {
      return Future.value(Left(Exception(e.toString())));
    }
  }
}
