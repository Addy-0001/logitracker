import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//Spacing Between Form Fields
class FormSeperatorBox extends StatelessWidget {
  final double height;
  const FormSeperatorBox({
    super.key,
    this.height = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
    );
  }
}
