import 'package:flutter/cupertino.dart';
import 'package:logitracker/core/routes/routes.dart';
import 'package:logitracker/features/auth/presentation/view/login_view.dart';
import 'package:logitracker/features/auth/presentation/view/register_view.dart';
import 'package:logitracker/features/job/presentation/view/home_view.dart';
import 'package:logitracker/features/job/presentation/view/profile_view.dart';
import 'package:logitracker/features/job/presentation/view/splash_view.dart';

Route<dynamic> onGeneratedRoute(RouteSettings settings) {
  switch (settings.name) {
    // Auth Pages
    case Routes.loginPage:
      return buildRoute(LoginView());
    case Routes.signupPage:
      return buildRoute(RegisterView());
    // User Management Pages
    case Routes.profilePage:
      return buildRoute(ProfileView());
    case Routes.homePage:
      return buildRoute(HomeView());
    case Routes.jobDetailPage:
      // TODO: Make a job detail page that accepts job id as a parameter and sends request to that page.For now, homeView it is.
      return buildRoute(HomeView());
    case Routes.jobMapPage:
      // TODO: Make a map view that accepts job id as a parameter and renders a map using any lib. For now, homeview it is.
      return buildRoute(HomeView());
    default:
      return buildRoute(SplashView());
  }
}

buildRoute(Widget child) {
  return CupertinoPageRoute(builder: (_) => child);
}
