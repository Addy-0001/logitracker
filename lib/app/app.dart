import 'package:flutter/material.dart';
import 'package:logitracker/app/service_locator/navigation_service.dart';
import 'package:logitracker/app/service_locator/service_locator.dart';
import 'package:logitracker/app/router/route_generator.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationService = getIt<NavigationService>();
    return MaterialApp(
      title: 'Logitracker',
      theme: getApplicationTheme(),
      navigatorKey: navigationService.navigatorKey,
      initialRoute: '/splash',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

// Simplify this. 