import 'package:get_it/get_it.dart';
import 'package:logitracker/app/service_locator/navigation_service.dart';
import 'package:logitracker/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:logitracker/features/auth/data/repository/local_repository/user_local_repository.dart';
import 'package:logitracker/features/auth/domain/repository/user_repository.dart';
import 'package:logitracker/features/auth/domain/use_case/user_login_use_case.dart';
import 'package:logitracker/features/auth/domain/use_case/user_register_use_case.dart';
import 'package:logitracker/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:logitracker/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:logitracker/features/delivery/data/data_source/local_data_source/job_local_data_source.dart';
import 'package:logitracker/features/delivery/data/repository/local_repository/job_local_repository.dart';
import 'package:logitracker/features/delivery/domain/repository/job_repository.dart';
import 'package:logitracker/features/delivery/domain/use_case/get_ongoing_job_use_case.dart';
import 'package:logitracker/features/delivery/domain/use_case/get_upcoming_jobs_use_case.dart';
import 'package:logitracker/features/delivery/presentation/view_model/dashboard_view_model/dashboard_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Navigation Service
  getIt.registerSingleton<NavigationService>(NavigationService());

  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Data Sources
  getIt.registerSingleton<UserLocalDataSource>(UserLocalDataSource());
  getIt.registerSingleton<JobLocalDataSource>(JobLocalDataSource());

  // Repositories
  getIt.registerSingleton<UserRepository>(
    UserLocalRepository(getIt<UserLocalDataSource>()),
  );
  getIt.registerSingleton<JobRepository>(
    JobLocalRepository(getIt<JobLocalDataSource>()),
  );

  // Use Cases
  getIt.registerSingleton<UserLoginUseCase>(
    UserLoginUseCase(getIt<UserRepository>()),
  );
  getIt.registerSingleton<UserRegisterUseCase>(
    UserRegisterUseCase(getIt<UserRepository>()),
  );
  getIt.registerSingleton<GetOngoingJobUseCase>(
    GetOngoingJobUseCase(getIt<JobRepository>()),
  );
  getIt.registerSingleton<GetUpcomingJobsUseCase>(
    GetUpcomingJobsUseCase(getIt<JobRepository>()),
  );

  // View Models
  getIt.registerFactory(() => LoginViewModel(getIt<UserLoginUseCase>()));
  getIt.registerFactory(() => RegisterViewModel(getIt<UserRegisterUseCase>()));
  getIt.registerFactory(
    () => DashboardViewModel(
      getIt<GetOngoingJobUseCase>(),
      getIt<GetUpcomingJobsUseCase>(),
    ),
  );
}
