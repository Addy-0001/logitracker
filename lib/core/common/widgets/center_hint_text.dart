import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CenterHintText extends StatelessWidget {
  final String text;
  const CenterHintText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 8,
        style: TextStyle(
          color: Theme.of(context).hintColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

class NoResultWidget extends StatelessWidget {
  final String? text;

  const NoResultWidget({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return CenterHintText(text: "No Data Found");
  }
}
