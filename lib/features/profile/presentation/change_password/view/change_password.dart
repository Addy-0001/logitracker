import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logitracker/core/bloc/view/bloc_provider_view.dart';
import 'package:logitracker/core/constant/app_defaults.dart';
import 'package:logitracker/core/helper/ui_helpers.dart';
import 'package:logitracker/core/utility/validator.dart';
import 'package:logitracker/features/profile/domain/entity/change_password_entity.dart';
import 'package:logitracker/features/profile/presentation/change_password/view_model/change_password_event.dart';
import 'package:logitracker/features/profile/presentation/change_password/view_model/change_password_state.dart';
import 'package:logitracker/features/profile/presentation/change_password/view_model/change_password_view_model.dart';
import 'package:progress_dialog2/progress_dialog2.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProviderView<ChangePasswordViewModel>(
      child: Builder(
        builder: (context) {
          return BlocListener<ChangePasswordViewModel, ChangePasswordState>(
            listener: (context, state) async {
              ProgressDialog pr = ProgressDialog(context);
              if (state is ChangePasswordLoading) {
                await pr.show();
              } else if (state is ChangePasswordLoaded ||
                  state is ChangePasswordError) {
                Navigator.pop(context); // Close loading
                if (state is ChangePasswordLoaded) {
                  displayToastSuccess("Password changed successfully");
                  Navigator.pop(context); // Close view
                } else if (state is ChangePasswordError) {
                  displayToastFailure(state.message);
                }
              }
            },
            child: Scaffold(
              backgroundColor: Colors.grey[50],
              appBar: AppBar(
                title: const Text(
                  "Change Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.red[700]!,
                        Colors.red[800]!,
                        Colors.red[900]!,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red[800]!.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey[50]!, Colors.white],
                  ),
                ),
                child: Padding(
                  padding: AppDefaults.kPageSidePadding.copyWith(
                    top: 24,
                    bottom: 24,
                  ),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Center(
                            child: Icon(
                              Icons.lock_reset,
                              size: 80.sp,
                              color: Colors.red[600],
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Center(
                            child: Text(
                              "Update Your Password",
                              style: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Center(
                            child: Text(
                              "Enter your current and new password below.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          SizedBox(height: 40.h),

                          _buildPasswordField(
                            context,
                            controller: currentPasswordController,
                            label: "Current Password",
                            hintText: "Enter your current password",
                            obscureText: obscureCurrentPassword,
                            onVisibilityToggle: () {
                              setState(() {
                                obscureCurrentPassword =
                                    !obscureCurrentPassword;
                              });
                            },
                            validator: Validators.emptyFieldValidator,
                          ),
                          SizedBox(height: 24.h),

                          _buildPasswordField(
                            context,
                            controller: newPasswordController,
                            label: "New Password",
                            hintText: "Enter your new password",
                            obscureText: obscureNewPassword,
                            onVisibilityToggle: () {
                              setState(() {
                                obscureNewPassword = !obscureNewPassword;
                              });
                            },
                            validator: Validators.emptyFieldValidator,
                          ),
                          SizedBox(height: 24.h),

                          _buildPasswordField(
                            context,
                            controller: confirmPasswordController,
                            label: "Confirm New Password",
                            hintText: "Confirm your new password",
                            obscureText: obscureConfirmPassword,
                            onVisibilityToggle: () {
                              setState(() {
                                obscureConfirmPassword =
                                    !obscureConfirmPassword;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              }
                              if (value != newPasswordController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 40.h),

                          _buildChangePasswordButton(context),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPasswordField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String hintText,
    required bool obscureText,
    required VoidCallback onVisibilityToggle,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16.sp),
              prefixIcon: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.lock_outline,
                  color: Colors.red[600],
                  size: 20.sp,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[500],
                ),
                onPressed: onVisibilityToggle,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }

  Widget _buildChangePasswordButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.red[500]!, Colors.red[600]!]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          hideKeyboard(context);
          if (formKey.currentState!.validate() == false) {
            return;
          }
          context.read<ChangePasswordViewModel>().add(
            ChangePasswordEvent(
              ChangePasswordEntity(
                currentPassword: currentPasswordController.text,
                newPassword: newPasswordController.text,
                confirmNewPassword: confirmPasswordController.text,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: const Text(
          "Change Password",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
