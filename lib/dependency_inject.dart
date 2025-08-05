import 'package:get_it/get_it.dart';
import 'package:logitracker/core/domain/use_case/shake_navigation_use_case.dart';
import 'package:logitracker/features/job/data/data_source/remote_data_source/coordinate_remote_datasource.dart';
import 'package:logitracker/features/job/data/repository/remote_repository/coordinate_remote_repository.dart';
import 'package:logitracker/features/job/domain/repository/coordinate_repository.dart';
import 'package:logitracker/features/job/domain/use_case/get_all_coordinates_use_case.dart';
import 'package:logitracker/features/job/domain/use_case/get_all_jobs_use_case.dart';
import 'package:logitracker/features/job/domain/use_case/get_job_by_id_use_case.dart';
import 'package:logitracker/features/job/domain/use_case/get_pickup_dropoff_coordinate_use_case.dart';
import 'package:logitracker/features/job/domain/use_case/update_live_coordinate_use_case.dart';
import 'package:logitracker/features/job/presentation/view_model/map/map_view_model.dart';
import 'package:logitracker/features/profile/domain/use_case/change_password_use_case.dart';
import 'package:logitracker/features/profile/domain/use_case/logout_user_use_case.dart';
import 'package:logitracker/features/profile/presentation/change_password/view_model/change_password_view_model.dart';
import 'package:logitracker/features/profile/presentation/edit_profile/view_model/edit_profile_view_model.dart';

// Services
import 'package:logitracker/services/core/http_service.dart';
import 'package:logitracker/services/core/preference_service.dart';
import 'package:logitracker/services/location/location_service.dart';
import 'package:logitracker/services/tracking/live_tracking_service.dart';

// Data Sources
import 'package:logitracker/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:logitracker/features/job/data/data_source/remote_data_source/job_remote_datasource.dart';
import 'package:logitracker/features/profile/data/remote_datasource/user_remote_datasource.dart';

// Repositories
import 'package:logitracker/features/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:logitracker/features/job/data/repository/remote_repository/job_remote_repository.dart';
import 'package:logitracker/features/profile/data/repository/remote_repository/user_remote_repository.dart';

// Repository Interfaces
import 'package:logitracker/features/auth/domain/repository/auth_repository.dart';
import 'package:logitracker/features/job/domain/repository/job_repository.dart';
import 'package:logitracker/features/profile/domain/repository/user_repository.dart';

// Use Cases
import 'package:logitracker/features/auth/domain/use_case/login_usecase.dart';
import 'package:logitracker/features/auth/domain/use_case/register_usecase.dart';
import 'package:logitracker/features/profile/domain/use_case/get_user_use_case.dart';
import 'package:logitracker/features/profile/domain/use_case/update_user_use_case.dart';

// ViewModels
import 'package:logitracker/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:logitracker/features/auth/presentation/view_model/register_view_model/signup_view_model.dart';
import 'package:logitracker/features/job/presentation/view_model/home/home_view_model.dart';
import 'package:logitracker/features/job/presentation/view_model/job/job_detail_view_model.dart';
import 'package:logitracker/features/profile/presentation/profile/view_model/user_view_model.dart';

final locator = GetIt.instance;

Future<void> setupDependencies() async {
  /// Services
  locator.registerSingletonAsync<PreferenceService>(
    () => PreferenceService.getInstance(),
  );

  final preferenceService = await locator.getAsync<PreferenceService>();
  locator.registerSingleton<HttpService>(HttpService(preferenceService));

  // Register Location Service as singleton
  locator.registerSingleton<LocationService>(LocationService.instance);

  /// Layers
  _dataSource();
  _repository();
  _useCase(preferenceService);
  _viewModel();
  _services();
}

void _dataSource() {
  locator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(locator<HttpService>()),
  );

  locator.registerFactory<UserRemoteDatasource>(
    () => UserRemoteDatasource(locator<HttpService>()),
  );

  locator.registerFactory<JobRemoteDatasource>(
    () => JobRemoteDatasource(locator<HttpService>()),
  );

  locator.registerFactory<CoordinateRemoteDatasource>(
    () => CoordinateRemoteDatasource(locator<HttpService>()),
  );
}

void _repository() {
  locator.registerFactory<IAuthRepository>(
    () => AuthRemoteRepository(locator<AuthRemoteDatasource>()),
  );

  locator.registerFactory<IUserRepository>(
    () => UserRemoteRepository(locator<UserRemoteDatasource>()),
  );

  locator.registerFactory<IJobRepository>(
    () => JobRemoteRepository(locator<JobRemoteDatasource>()),
  );

  locator.registerFactory<ICoordinateRepository>(
    () => CoordinateRemoteRepository(locator<CoordinateRemoteDatasource>()),
  );
}

void _useCase(PreferenceService preferenceService) {
  locator.registerFactory(
    () => LoginUsecase(locator<IAuthRepository>(), preferenceService),
  );

  locator.registerFactory(
    () => RegisterUsecase(authRepository: locator<IAuthRepository>()),
  );

  locator.registerFactory(() => GetUserUseCase(locator<IUserRepository>()));

  locator.registerFactory(() => UpdateUserUseCase(locator<IUserRepository>()));

  locator.registerFactory(
    () => LogoutUserUseCase(locator<PreferenceService>()),
  );
  locator.registerFactory(() => ShakeNavigationUseCase(preferenceService));

  locator.registerFactory(() => GetAllJobsUseCase(locator<IJobRepository>()));

  locator.registerFactory(() => GetJobByIdUseCase(locator<IJobRepository>()));

  locator.registerFactory(
    () => ChangePasswordUseCase(locator<IAuthRepository>()),
  );

  locator.registerFactory(
    () => GetAllCoordinatesUseCase(locator<ICoordinateRepository>()),
  );

  locator.registerFactory(
    () => GetPickupDropoffCoordinatesUseCase(locator<ICoordinateRepository>()),
  );

  locator.registerFactory(
    () => UpdateLiveCoordinateUseCase(locator<ICoordinateRepository>()),
  );
}

void _viewModel() {
  locator.registerFactory(() => LoginViewModel(locator<LoginUsecase>()));

  locator.registerFactory(() => SignupViewModel(locator<RegisterUsecase>()));

  locator.registerFactoryParam<HomeViewModel, String?, void>(
    (driverId, _) => HomeViewModel(locator<GetAllJobsUseCase>(), driverId),
  );

  locator.registerFactoryParam<JobDetailViewModel, String, void>(
    (jobId, _) => JobDetailViewModel(locator<GetJobByIdUseCase>(), jobId),
  );

  locator.registerFactory(
    () => UserViewModel(
      locator<GetUserUseCase>(),
      locator<UpdateUserUseCase>(),
      locator<LogoutUserUseCase>(),
      locator<ShakeNavigationUseCase>(),
    ),
  );
  locator.registerFactory(
    () => EditProfileViewModel(locator<IUserRepository>()),
  );
  locator.registerFactory(
    () => ChangePasswordViewModel(locator<ChangePasswordUseCase>()),
  );

  locator.registerFactory(() => MapViewModel(locator<ICoordinateRepository>()));
}

void _services() {
  // Register Live Tracking Service as singleton
  locator.registerSingleton<LiveTrackingService>(
    LiveTrackingService.create(locator<ICoordinateRepository>()),
  );
}
