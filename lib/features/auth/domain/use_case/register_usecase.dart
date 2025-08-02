import 'package:dartz/dartz.dart';
import 'package:logitracker/core/utility/usecase.dart';
import 'package:logitracker/features/auth/domain/entity/signup_entity.dart';
import 'package:logitracker/features/auth/domain/repository/auth_repository.dart';

class RegisterUsecase implements UsecaseWithParams<void, SignupEntity> {
  final IAuthRepository authRepository;

  RegisterUsecase({required this.authRepository});

  @override
  Future<Either<Exception, void>> call(SignupEntity params) async {
    try {
      await authRepository.registerUser(params);
    } on Exception catch (e) {
      return Future.value(Left(e));
    } catch (ex) {
      return Future.value(Left(Exception(ex.toString())));
    }
  }
}
