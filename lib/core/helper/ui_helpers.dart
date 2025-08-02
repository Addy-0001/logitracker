import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logitracker/core/constant/app_defaults.dart';
import 'package:logitracker/core/theme/app_colors.dart';
import 'package:logitracker/main.dart';
import 'package:logitracker/shared/widgets/error_dialog_widget.dart';
import 'package:logitracker/shared/widgets/form_seperator_box.dart';
import 'package:progress_dialog2/progress_dialog2.dart';
import 'package:toastification/toastification.dart';

bool get isMobile {
  return AppDefaults.deviceType == DeviceType.mobile;
}

Future<dynamic> showBottomSheetCustom(
  BuildContext context,
  Widget widget, {
  String? title,
  bool? isDismiss,
  bool? dragEnable,
}) async {
  return await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    isDismissible: isDismiss ?? true,
    enableDrag: dragEnable ?? true,
    builder:
        (context) => Container(
          decoration: const BoxDecoration(
            color: AppColors.cardBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          padding: MediaQuery.viewInsetsOf(context)
              .add(AppDefaults.kPageSidePadding)
              .add(const EdgeInsets.symmetric(vertical: 12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child:
                        (title != null)
                            ? Text(
                              title,
                              style: Theme.of(
                                context,
                              ).textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                                color: Colors.white,
                              ),
                            )
                            : const SizedBox.shrink(),
                  ),
                  CloseButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              widget,
              SizedBox(height: 8.h),
            ],
          ),
        ),
  );
}

_overlaySupprt(String message, ToastificationType type) {
  toastification.show(
    title: Text(
      message,
      maxLines: 3,
      style: Theme.of(
        navigatorKey.currentContext!,
      ).textTheme.headlineSmall?.copyWith(color: Colors.white),
    ),
    style: ToastificationStyle.fillColored,
    showIcon: false,
    type: type,
    closeButton: ToastCloseButton(
      showType: CloseButtonShowType.always,
      buttonBuilder:
          (context, onClose) =>
              Icon(Icons.close, color: Colors.white, size: 14.sp),
    ),
    autoCloseDuration: const Duration(seconds: 3),
    closeOnClick: true,
    alignment: Alignment.bottomCenter,
  );
}

displayToastFailure(String message) {
  _overlaySupprt(message, ToastificationType.error);
}

displayToastSuccess(String message) {
  _overlaySupprt(message, ToastificationType.success);
}

SizedBox adaptableHeight({double height = 15}) => SizedBox(height: height.h);
SizedBox adaptableWidth({double width = 15}) => SizedBox(width: width.w);

Widget homeSeperatorBox() => const FormSeperatorBox(height: 35);
Widget homeTitleContentSeperatorBox() => const FormSeperatorBox(height: 20);

Future<dynamic> showAlertDialog(
  BuildContext context,
  String title,
  String content, {
  Function()? onConfirmPress,
  Function()? onCancelPress,
}) async {
  return await showDialog(
    context: context,
    builder: (x) {
      return Dialog(
        // backgroundColor: Colors.white,
        // surfaceTintColor: Colors.white,
        insetPadding: AppDefaults.kPageSidePadding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: ErrorDialogWidget(
          content: content,
          title: title,
          onCancelPress: onCancelPress,
          onConfirmPress: onConfirmPress,
        ),
      );
    },
  );
}

void asyncCallHelperWithLoadingBar(
  BuildContext context, {
  required Future<dynamic> Function() processCall,
  required Function onSuccess,
  Function(Object)? onError,
}) async {
  ProgressDialog pr = ProgressDialog(context);
  pr.style(
    progressWidget: Padding(
      padding: EdgeInsets.all(14.sp),
      child: CircularProgressIndicator(strokeWidth: 2.sp),
    ),
    messageTextStyle: TextStyle(color: Colors.black, fontSize: 18.sp),
  );

  await pr.show();
  try {
    var response = await processCall();
    await pr.hide();
    if (response == null) {
      onSuccess();
    } else {
      onSuccess(response);
    }
  } catch (ex) {
    await pr.hide();
    try {} catch (ex) {
      debugPrint("object");
      //
    }

    if (onError == null) {
      displayToastFailure(ex.toString());
    } else {
      onError(ex);
    }
  }
}

Widget movieReleaseOrNotChip(DateTime releaseDate) {
  var isReleased = releaseDate.isBefore(DateTime.now());
  return Chip(
    label: Text(isReleased ? "Released" : "Comming Soon"),
    backgroundColor: isReleased ? AppColors.primary : AppColors.secondary,
    labelStyle: TextStyle(color: Colors.white, fontSize: 12.sp),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
  );
}

hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
