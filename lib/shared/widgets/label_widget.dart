// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logitracker/core/helper/ui_helpers.dart';

class LabelWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? iconColor;
  const LabelWidget({
    Key? key,
    required this.icon,
    required this.label,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor ?? Color(0xff92929D),
          size: 16.sp,
        ),
        adaptableWidth(
          width: 4,
        ),
        Text(
          label,
          style: TextStyle(
            color: Color(0xff92929D),
            fontSize: 12.sp,
          ),
        )
      ],
    );
  }
}
