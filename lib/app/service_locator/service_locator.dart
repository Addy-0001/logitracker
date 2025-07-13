import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logitracker_mobile_app/core/common/internet_checker/internet_checker.dart';
import 'package:logitracker_mobile_app/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:logitracker_mobile_app/features/auth/data/data_source/remote_datasource/user_remote_datasource.dart';
import 'package:logitracker_mobile_app/features/auth/domain/repository/user_repository.dart';
import 'package:logitracker_mobile_app/features/auth/domain/use_case/user_login_use_case.dart';
import 'package:logitracker_mobile_app/features/auth/domain/use_case/user_logout_usecase.dart';
import 'package:logitracker_mobile_app/features/auth/domain/use_case/user_register_use_case.dart';
import 'package:logitracker_mobile_app/features/auth/domain/use_case/user_get_current_use_case.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view_model/login_view_model/login_bloc.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view_model/register_view_model/register_bloc.dart';
import 'package:logitracker_mobile_app/app/service_locator/navigation_service.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => NavigationService());
  sl.registerLazySingleton(() => InternetChecker());
  sl.registerLazySingleton(() => UserRemoteDataSource(sl(), sl()));
  sl.registerLazySingleton(() => UserLocalDataSource());
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(() => UserLoginUseCase(sl()));
  sl.registerLazySingleton(() => UserRegisterUseCase(sl()));
  sl.registerLazySingleton(() => UserLogoutUseCase(sl()));
  sl.registerLazySingleton(() => UserGetCurrentUseCase(sl()));
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => RegisterBloc(sl(), sl()));
}
