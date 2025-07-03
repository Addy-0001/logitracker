import 'package:flutter/material.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view/login_view.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view/register_view.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view/splash_view.dart';
import 'package:logitracker_mobile_app/features/delivery/presentation/view/dashboard_view.dart';
import 'package:logitracker_mobile_app/features/delivery/presentation/view/profile_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashView());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterView());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => DashboardView());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
