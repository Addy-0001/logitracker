import 'package:dartz/dartz.dart';
import 'package:logitracker/core/routes/routes.dart';
import 'package:logitracker/core/utility/usecase.dart';
import 'package:logitracker/main.dart';
import 'package:logitracker/services/core/preference_service.dart';

class ShakeNavigationUseCase implements UsecaseWithoutParams<void> {
  final PreferenceService _preferenceService;

  ShakeNavigationUseCase(this._preferenceService);
  @override
  Future<Either<Exception, void>> call() async {
    try {
      await _preferenceService.clearAll();
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        Routes.loginPage,
        (route) => false,
      );
      return Right(null);
    } catch (ex) {
      return Left(Exception(ex.toString()));
    }
  }
}
