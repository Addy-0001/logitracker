// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:logitracker/core/theme/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BorderedDecorationContainer extends StatelessWidget {
  final Color? color;
  final String text;
  const BorderedDecorationContainer({Key? key, this.color, required this.text})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.sp),
      decoration: BoxDecoration(
        color: color ?? AppColors.kBorderColor,
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xff3F4254),
        ),
      ),
    );
  }
}
