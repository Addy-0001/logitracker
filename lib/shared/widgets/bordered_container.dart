// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:logitracker/core/constant/app_defaults.dart';
import 'package:logitracker/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BorderedContainer extends StatelessWidget {
  final Color? borderColor;
  final Color? backgroundColor;
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  const BorderedContainer({
    super.key,
    this.borderColor,
    this.backgroundColor,
    required this.child,
    this.borderRadius = 12,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? AppDefaults.kPageSidePadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.sp),
        border: Border.all(
          color: borderColor ?? AppColors.kBorderColor,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        color: backgroundColor ?? Colors.white,
      ),
      child: child,
    );
  }
}
