import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:logitracker/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:logitracker/features/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:logitracker/features/auth/domain/repository/auth_repository.dart';
import 'package:logitracker/features/auth/domain/use_case/login_usecase.dart';
import 'package:logitracker/features/auth/domain/use_case/register_usecase.dart';
import 'package:logitracker/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:logitracker/features/auth/presentation/view_model/register_view_model/signup_view_model.dart';
import 'package:logitracker/services/core/http_service.dart';
import 'package:logitracker/services/core/preference_service.dart';

final locator = GetIt.instance;

setupDependencies() async {
  locator.registerSingletonAsync<PreferenceService>(
    () => PreferenceService.getInstance(),
  );

  final preferenceService = await locator.getAsync<PreferenceService>();
  locator.registerSingleton<HttpService>(HttpService(preferenceService));

  // Data Source
  _dataSource();

  // Repository
  _repository();

  // services
  _services();

  // useCases
  _useCase();

  // viewmodels
  _viewModel();
}

_dataSource() {
  locator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(locator<HttpService>()),
  );
}

_services() {}

_repository() {
  locator.registerFactory<IAuthRepository>(
    () => AuthRemoteRepository(locator<AuthRemoteDatasource>()),
  );
}

_useCase() {
  locator.registerFactory(
    () =>
        LoginUsecase(locator<IAuthRepository>(), locator<PreferenceService>()),
  );
  locator.registerFactory(
    () => RegisterUsecase(authRepository: locator<IAuthRepository>()),
  );
}

_viewModel() {
  locator.registerFactory(() => LoginViewModel(locator<LoginUsecase>()));
  locator.registerFactory(() => SignupViewModel(locator<RegisterUsecase>()));
}
