import 'package:flutter/material.dart';
import 'package:logitracker/features/auth/presentation/view/login_view.dart';
import 'package:logitracker/features/auth/presentation/view/register_view.dart';
import 'package:logitracker/features/auth/presentation/view/splash_view.dart';
import 'package:logitracker/features/delivery/presentation/view/home_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashView());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginView());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeView());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
