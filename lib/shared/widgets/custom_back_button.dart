import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: "Back",
      icon: Icon(
        Icons.arrow_back,
        size: 24.sp,
      ),
      onPressed: () {
        Navigator.of(context).maybePop();
      },
    );
  }
}
