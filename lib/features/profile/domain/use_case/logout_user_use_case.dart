import 'package:dartz/dartz.dart';
import 'package:logitracker/core/utility/usecase.dart';
import 'package:logitracker/services/core/preference_service.dart';

class LogoutUserUseCase implements UsecaseWithoutParams<String> {
  final PreferenceService _preferenceService;

  LogoutUserUseCase(this._preferenceService);

  @override
  Future<Either<Exception, String>> call() async {
    try {
      await _preferenceService.clearAll();
      return Right("Logged out Successfully");
    } catch (e) {
      return Future.value(Left(Exception(e.toString())));
    }
  }
}
