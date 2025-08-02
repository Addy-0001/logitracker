import 'package:dartz/dartz.dart';
import 'package:logitracker/core/utility/usecase.dart';
import 'package:logitracker/features/auth/domain/entity/auth_response_entity.dart';
import 'package:logitracker/features/auth/domain/entity/login_entity.dart';
import 'package:logitracker/features/auth/domain/repository/auth_repository.dart';
import 'package:logitracker/services/core/preference_service.dart';

class LoginUsecase implements UsecaseWithParams<void, LoginEntity> {
  final IAuthRepository authRepository;
  final PreferenceService preferenceService;
  LoginUsecase(this.authRepository, this.preferenceService);

  @override
  Future<Either<Exception, AuthResponseEntity>> call(LoginEntity params) async {
    try {
      var user = await authRepository.loginuser(params);
      preferenceService.userName = user.firstName + user.lastName;
      preferenceService.accessToken = user.token;
      return Right(user);
    } on Exception catch (e) {
      return Future.value(Left(e));
    } catch (ex) {
      return Future.value(Left(Exception(ex.toString())));
    }
  }
}
