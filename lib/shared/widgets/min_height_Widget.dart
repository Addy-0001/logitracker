// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MinHeightWidget extends StatelessWidget {
  final double minHeight = 300;
  final Widget child;
  const MinHeightWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight.h),
      child: child,
    );
  }
}
