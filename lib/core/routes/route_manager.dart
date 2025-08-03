import 'package:flutter/cupertino.dart';
import 'package:logitracker/core/routes/routes.dart';
import 'package:logitracker/features/auth/presentation/view/login_view.dart';
import 'package:logitracker/features/auth/presentation/view/signup_view.dart';
import 'package:logitracker/features/job/presentation/view/home/home_view.dart';
import 'package:logitracker/features/job/presentation/view/job/job_detail_view.dart';
import 'package:logitracker/features/profile/presentation/change_password/view/change_password.dart';
import 'package:logitracker/features/profile/presentation/edit_profile/view/edit_profile_view.dart';
import 'package:logitracker/features/profile/presentation/profile/view/profile.dart';
import 'package:logitracker/features/splash/view/splash_view.dart';
import 'package:logitracker/services/core/preference_service.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    // Auth Pages
    case Routes.loginPage:
      return buildRoute(LoginView());
    case Routes.signupPage:
      return buildRoute(SignupView());
    // User Management Pages
    case Routes.profilePage:
      return buildRoute(ProfileView());
    case Routes.editProfilePae:
      return buildRoute(EditProfileView());
    case Routes.changePasswordPage:
      return buildRoute(ChangePasswordView());
    case Routes.homePage:
      final userId = PreferenceService.keyUsername;
      return buildRoute(HomeView(id: userId));
    case Routes.jobDetailPage:
      final id = settings.arguments as String;
      if (id.isEmpty) {
        print("Id is empty");
      }
      return buildRoute(JobDetailView(id: id));
    case Routes.jobMapPage:
    // TODO: Make a map view that accepts job id as a parameter and renders a map using any lib. For now, homeview it is.
    // return buildRoute(HomeView());
    default:
      return buildRoute(SplashView());
  }
}

buildRoute(Widget child) {
  return CupertinoPageRoute(builder: (_) => child);
}
