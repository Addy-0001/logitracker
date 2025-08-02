import 'package:logitracker/core/helper/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormTitleWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final String? subtitle;
  final bool isRequiredField;
  final double fontSize;
  const FormTitleWidget({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.fontSize = 14,
    this.isRequiredField = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: fontSize.sp,
            ),
            children: [
              TextSpan(text: title),
              if (isRequiredField)
                const TextSpan(
                  text: " * ",
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        if (subtitle != null)
          Text(subtitle!, style: TextStyle(fontSize: 12.sp, color: Colors.red)),
        adaptableHeight(height: 10),
        child,
      ],
    );
  }
}
