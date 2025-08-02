// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CloseButtonWidget extends StatelessWidget {
  final String? iconButtonPath;
  final Function()? onClose;
  const CloseButtonWidget({
    super.key,
    this.iconButtonPath,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onClose ??
            () {
              Navigator.of(context).pop();
            },
        icon: iconButtonPath == null
            ? Icon(
                MdiIcons.close,
                size: 20.sp,
                color: Colors.white,
              )
            : SvgPicture.asset(
                iconButtonPath!,
              ));
  }
}
