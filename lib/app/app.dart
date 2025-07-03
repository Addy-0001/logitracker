import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker_mobile_app/features/auth/domain/use_case/user_get_current_use_case.dart';
import 'package:logitracker_mobile_app/features/auth/domain/use_case/user_login_use_case.dart';
import 'package:logitracker_mobile_app/features/auth/domain/use_case/user_logout_usecase.dart';
import 'package:logitracker_mobile_app/features/auth/domain/use_case/user_register_use_case.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view_model/login_view_model/login_bloc.dart';
import 'package:logitracker_mobile_app/app/router/route_generator.dart';
import 'package:logitracker_mobile_app/app/service_locator/navigation_service.dart';
import 'package:logitracker_mobile_app/app/service_locator/service_locator.dart';
import 'package:logitracker_mobile_app/app/theme/app_theme.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view_model/register_view_model/register_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => sl<UserLoginUseCase>()),
        RepositoryProvider(create: (context) => sl<UserRegisterUseCase>()),
        RepositoryProvider(create: (context) => sl<UserLogoutUseCase>()),
        RepositoryProvider(create: (context) => sl<UserGetCurrentUseCase>()),
        RepositoryProvider(create: (context) => sl<NavigationService>()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<LoginBloc>()),
          BlocProvider(create: (context) => RegisterBloc(sl(), sl())),
        ],
        child: MaterialApp(
          title: 'LogiTracker',
          theme: AppTheme.lightTheme,
          navigatorKey: sl<NavigationService>().navigatorKey,
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
