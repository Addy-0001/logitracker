import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logitracker/core/bloc/view/bloc_builder_view.dart';
import 'package:logitracker/core/constant/app_defaults.dart';
import 'package:logitracker/core/helper/ui_helpers.dart';
import 'package:logitracker/core/routes/routes.dart';
import 'package:logitracker/core/theme/app_colors.dart';
import 'package:logitracker/features/profile/presentation/profile/view_model/user_view_model.dart';
import 'package:logitracker/shared/widgets/circular_image_widget.dart';
import 'package:logitracker/shared/widgets/form_seperator_box.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: AppDefaults.kPageSidePadding,
        child: Column(
          children: [
            userHeading(),
            FormSeperatorBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account",
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontSize: 18.sp),
                ),
                FormSeperatorBox(height: 8),
                // TODO: add update profile route to routes and update here.
                tileWidget("Edit Profile", Icons.account_circle_sharp, () {
                  Navigator.of(context).pushNamed(Routes.profilePage);
                }),
                Divider(),
                tileWidget("Change Password", Icons.lock, () {
                  // TODO: add change password route to routes and update here.
                  Navigator.of(context).pushNamed(Routes.profilePage);
                }),
              ],
            ),
            Spacer(),
            OutlinedButton(
              onPressed: () {
                showAlertDialog(
                  context,
                  "Confirm Logout?",
                  "Are you sure you want to logout?",
                  onConfirmPress: () {
                    context.read<UserViewModel>().add(LogoutUserEvent());
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.loginPage,
                      (route) => false,
                    );
                  },
                );
              },
              child: Text("Logout"),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget tileWidget(String title, IconData leading, VoidCallback onTap) {
    return ListTile(
      tileColor: Colors.transparent,
      leading: Icon(leading, color: AppColors.primary),
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppColors.primary,
        size: 18.sp,
      ),
      onTap: onTap,
    );
  }

  Widget userHeading() {
    return Container(
      padding: EdgeInsets.all(AppDefaults.kPageSidePadding.left),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDefaults.borderRadius),
        border: Border.all(color: AppColors.kBorderColor),
      ),
      child: BlocBuilderView<UserViewModel, UserState, UserLoaded>(
        child:
            (x, state) => Row(
              children: [
                CircularImageWidget(
                  radius: 20.sp,
                  fit: BoxFit.fill,
                  imageUrl: state.data.profileImage,
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${state.data.firstName} ${state.data.lastName}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      state.data.email,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}
