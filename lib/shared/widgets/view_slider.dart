import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logitracker/core/theme/app_colors.dart';
import 'package:logitracker/shared/widgets/form_seperator_box.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ViewSlider extends StatefulWidget {
  final int length;
  final bool autoPlay;
  final bool showPageIndicator;
  final double? height;
  final double viewportFraction;
  final bool infiniteScroll;
  final Widget Function(BuildContext context, int index) builder;

  const ViewSlider({
    super.key,
    required this.length,
    this.autoPlay = true,
    this.viewportFraction = 1,
    this.showPageIndicator = true,
    this.height,
    this.infiniteScroll = true,
    required this.builder,
  });

  @override
  State<ViewSlider> createState() => _ViewSliderState();
}

class _ViewSliderState extends State<ViewSlider> {
  ValueNotifier<int> indexNotifier = ValueNotifier<int>(0);
  late final PageController controller;
  final imageController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: 1, keepPage: true, initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.length,
          carouselController: imageController,
          itemBuilder: (c, i, a) => widget.builder(c, i),
          options: CarouselOptions(
              height: widget.height,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlay: widget.length > 1 ? widget.autoPlay : false,
              enableInfiniteScroll: widget.length > 1 ? widget.infiniteScroll : false,
              viewportFraction: widget.viewportFraction,
              initialPage: 0,
              onPageChanged: widget.showPageIndicator
                  ? (i, r) {
                      indexNotifier.value = i;
                    }
                  : null),
        ),
        if (widget.showPageIndicator && widget.length > 1) ...[
          FormSeperatorBox(),
          pageIndicator(),
        ]
      ],
    );
  }

  Widget pageIndicator() {
    return Align(
      alignment: Alignment.center,
      child: ValueListenableBuilder<int>(
          valueListenable: indexNotifier,
          builder: (BuildContext context, int index, Widget? child) {
            return AnimatedSmoothIndicator(
              activeIndex: indexNotifier.value,
              count: widget.length,
              onDotClicked: (index) {
                imageController.animateToPage(index);
              },
              effect: ScrollingDotsEffect(
                spacing: 5.w,
                dotColor: AppColors.primaryBackgroundShade,
                activeDotColor: AppColors.primary,
                dotHeight: 8.sp,
                maxVisibleDots: 5,
                dotWidth: 8.sp,
              ),
            );
          }),
    );
  }
}
