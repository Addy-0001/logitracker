import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:logitracker/core/constant/app_defaults.dart';
import 'package:logitracker/core/constant/image_const.dart';
import 'package:logitracker/core/utility/extension.dart';
import 'package:logitracker/shared/widgets/image_loading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final double? loadingWidgetWidth;
  final double? loadingWidgetHeight;
  final String? secondaryImageUrl;
  final bool clipBorder;
  final double? borderRadius;
  final Function? onFullscreenTap;
  const ImageWidget({
    super.key,
    this.imageUrl,
    this.clipBorder = false,
    this.height,
    this.width,
    this.loadingWidgetWidth,
    this.loadingWidgetHeight,
    this.fit = BoxFit.cover,
    this.secondaryImageUrl,
    this.borderRadius,
    this.onFullscreenTap,
  });

  @override
  Widget build(BuildContext context) {
    final assetImage = Image.asset(
      ImageConst.placeholder,
      height: height,
      width: width,
      fit: fit,
    );
    final secondaryImageWidget = ImageWidget(
      fit: fit,
      height: height,
      width: width,
      borderRadius: borderRadius,
      clipBorder: clipBorder,
      imageUrl: secondaryImageUrl,
    );
    final loadingWidget = ImageLoadingWidget(
      height: loadingWidgetHeight ?? height ?? double.maxFinite,
      width: loadingWidgetWidth ?? width ?? double.maxFinite,
      borderRadius: borderRadius?.sp,
      clipBorder: clipBorder,
    );

    Widget childWidget;
    if ((imageUrl ?? '').isEmpty) {
      if ((secondaryImageUrl ?? '').isNotEmpty) {
        childWidget = secondaryImageWidget;
      } else {
        childWidget = assetImage;
      }
    } else if (imageUrl!.isNetworkFile) {
      if (imageUrl!.split('/').last.split('.').last.toLowerCase().contains('svg')) {
        childWidget = SvgPicture.network(
          imageUrl!,
          height: height,
          width: width,
          fit: fit,
          placeholderBuilder: (context) => loadingWidget,
        );
      } else {
        childWidget = CachedNetworkImage(
          imageUrl: imageUrl!,
          height: height,
          width: width,
          fit: fit,
          errorWidget: (context, url, error) => secondaryImageWidget,
          placeholder: (context, url) => loadingWidget,
        );
      }
    } else if (imageUrl!.isAssetFile) {
      childWidget = Image.asset(
        imageUrl!,
        height: height,
        width: width,
        fit: fit,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) => secondaryImageWidget,
      );
    } else {
      childWidget = Image.file(
        File(
          imageUrl!,
        ),
        height: height,
        width: width,
        fit: fit,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) => secondaryImageWidget,
      );
    }
    if (clipBorder) {
      childWidget = ClipRRect(borderRadius: BorderRadius.circular(borderRadius ?? AppDefaults.borderRadius), child: childWidget);
    }
    if (onFullscreenTap != null) {
      childWidget = Stack(
        children: [
          childWidget,
          Positioned(
            bottom: 12.h,
            right: 12.w,
            child: Container(
              padding: const EdgeInsets.all(3),
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
              child: GestureDetector(
                onTap: () {
                  onFullscreenTap!();
                },
                child: Icon(Icons.fullscreen),
              ),
            ),
          )
        ],
      );
    }
    return childWidget;
  }
}
