import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RatingWidget extends StatelessWidget {
  final double? rating;
  final double size;
  final Function(double)? onUpdate;
  const RatingWidget({super.key, this.rating, this.onUpdate, this.size = 12});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: onUpdate == null,
      child: RatingBar.builder(
        initialRating: rating ?? 0,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        unratedColor: Colors.grey.withOpacity(0.3),
        itemSize: size.sp,
        itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
        itemBuilder: (context, _) => Icon(MdiIcons.star, color: Colors.amber),
        onRatingUpdate: (rating) {
          if (onUpdate != null) {
            onUpdate!(rating);
          }
        },
      ),
    );
  }
}
