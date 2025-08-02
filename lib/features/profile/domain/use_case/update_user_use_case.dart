import 'package:dartz/dartz.dart';
import 'package:logitracker/core/utility/usecase.dart';
import 'package:logitracker/features/profile/domain/entity/user_entity.dart';
import 'package:logitracker/features/profile/domain/repository/user_repository.dart';

class UpdateUserUseCase implements UsecaseWithParams<String, UserEntity> {
  final IUserRepository _repository;
  UpdateUserUseCase(this._repository);

  @override
  Future<Either<Exception, String>> call(UserEntity params) async {
    try {
      var response = await _repository.updateUser(params);
      return Right(response);
    } catch (e) {
      return Future.value(Left(Exception(e.toString())));
    }
  }
}
