import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrefixIconWidget extends StatelessWidget {
  final String iconPath;
  final double size;
  const PrefixIconWidget({
    super.key,
    required this.iconPath,
    this.size = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: SvgPicture.asset(
        iconPath,
        height: size,
        width: size,
      ),
    );
  }
}
