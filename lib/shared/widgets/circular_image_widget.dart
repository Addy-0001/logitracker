import 'package:logitracker/shared/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final BoxFit fit;
  const CircularImageWidget({
    super.key,
    this.imageUrl,
    this.radius = 12,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2000),
      child: ImageWidget(
        fit: fit,
        height: (radius * 2).sp,
        width: (radius * 2).sp,
        imageUrl: imageUrl,
      ),
    );
  }
}
