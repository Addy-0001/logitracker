import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logitracker/core/constant/app_defaults.dart';
import 'package:logitracker/core/constant/image_const.dart';
import 'package:logitracker/core/database/hive_service.dart';
import 'package:logitracker/core/routes/routes.dart';
import 'package:logitracker/core/theme/app_colors.dart';
import 'package:logitracker/dependency_inject.dart';
import 'package:logitracker/services/core/preference_service.dart';
import 'package:logitracker/shared/widgets/form_seperator_box.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    processNavigation();
  }

  processNavigation() async {
    await Future.delayed(Duration(seconds: 2));
    HiveService().init();
    final prefs = locator<PreferenceService>();
    late final String toPage;
    if (prefs.accessToken.isEmpty) {
      toPage = Routes.loginPage;
    } else {
      toPage = Routes.homePage;
    }
    Navigator.of(context).pushReplacementNamed(toPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 5,
              child: Image.asset(
                ImageConst.appLogo,
                height: 100.h,
                fit: BoxFit.contain,
                width: 100.w,
              ),
            ),
            FormSeperatorBox(),
            Text(
              AppDefaults.appName,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
