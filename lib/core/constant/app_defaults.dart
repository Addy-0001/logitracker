import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logitracker/core/helper/ui_helpers.dart';
import 'package:logitracker/core/theme/app_colors.dart';

class AppDefaults {
  //default to mobile, can be changed based on the platform
  static DeviceType deviceType = DeviceType.mobile;
  static String appName = "MovieHUB";
  static EdgeInsets kPageSidePadding = EdgeInsets.symmetric(horizontal: 16.w);
  static TextStyle headerTitleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 48.sp,
    color: AppColors.secondary,
    height: 1.1,
  );
  static double get buttonHeight => (isMobile ? 46 : 56).h;
  static const String fontFamily = "Aeonik";
  static double get borderRadius => 8.sp;

  static double get featuredMovieHeight => isMobile ? 200.h : 300.h;
  static double get appBarheight => (isMobile ? kToolbarHeight : 64).sp;
}
