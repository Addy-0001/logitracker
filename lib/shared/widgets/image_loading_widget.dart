import 'package:logitracker/shared/widgets/shrimmer.dart';
import 'package:flutter/material.dart';

class ImageLoadingWidget extends StatelessWidget {
  final double height;
  final double width;
  final bool clipBorder;
  final double? borderRadius;
  const ImageLoadingWidget({
    super.key,
    required this.height,
    required this.width,
    this.clipBorder = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return RectangularShrimmer(
      size: Size(width, height),
      borderRadius: clipBorder ? borderRadius : 0,
    );
  }
}
