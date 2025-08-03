import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logitracker/core/constant/app_defaults.dart';
import 'package:logitracker/core/routes/routes.dart';
import 'package:logitracker/core/theme/themes.dart';
import 'package:logitracker/dependency_inject.dart';
import 'package:logitracker/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:logitracker/features/job/presentation/view/home/home_view.dart';
import 'package:logitracker/features/job/presentation/view_model/home/home_view_model.dart';
import 'package:logitracker/features/profile/presentation/profile/view_model/user_view_model.dart';
import 'package:logitracker/services/core/http_service.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:toastification/toastification.dart';
import 'package:logitracker/core/routes/route_manager.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await setupDependencies();
  HttpOverrides.global = MyHttpOVerrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        AppDefaults.deviceType =
            MediaQuery.sizeOf(context).width > 600
                ? DeviceType.tablet
                : DeviceType.mobile;
        return ToastificationWrapper(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<LoginViewModel>(
                create: (_) => locator<LoginViewModel>(),
              ),
              BlocProvider<UserViewModel>(
                create: (_) => locator<UserViewModel>(),
              ),
            ],
            child: MaterialApp(
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.splash,
              themeMode: ThemeMode.dark,
              title: AppDefaults.appName,
              builder: (context, child) {
                return ResponsiveWrapper.builder(
                  child,
                  defaultScale: true,
                  breakpoints: [
                    ResponsiveBreakpoint.resize(100, name: MOBILE),
                    ResponsiveBreakpoint.resize(480, name: MOBILE),
                    ResponsiveBreakpoint.resize(800, name: TABLET),
                    ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                    ResponsiveBreakpoint.autoScale(2460, name: '4K'),
                  ],
                  background: Container(color: Color(0xFFF5F5F5)),
                );
              },
              theme: getApplicationTheme(),
              onGenerateRoute: onGenerateRoute,
            ),
          ),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = ((
        X509Certificate cert,
        String host,
        int port,
      ) {
        return true;
      });
  }
}
