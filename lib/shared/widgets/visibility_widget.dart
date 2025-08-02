import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VisibilityWidget extends StatelessWidget {
  final bool isVisibile;
  const VisibilityWidget({
    super.key,
    required this.isVisibile,
  });

  @override
  Widget build(BuildContext context) {
    final size = 20.sp;
    final Color? color = Theme.of(context).inputDecorationTheme.iconColor;
    if (!isVisibile) {
      return Icon(
        Icons.remove_red_eye_outlined,
        color: color,
        size: size,
      );
    }
    return Icon(
      Icons.visibility_off_outlined,
      color: color,
      size: size,
    );
  }
}
