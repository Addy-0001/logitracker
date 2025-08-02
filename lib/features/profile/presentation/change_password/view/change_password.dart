import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/core/bloc/view/bloc_provider_view.dart';
import 'package:logitracker/core/constant/app_defaults.dart';
import 'package:logitracker/core/helper/ui_helpers.dart';
import 'package:logitracker/core/utility/validator.dart';
import 'package:logitracker/features/profile/domain/entity/change_password_entity.dart';
import 'package:logitracker/features/profile/presentation/change_password/view_model/change_password_event.dart';
import 'package:logitracker/features/profile/presentation/change_password/view_model/change_password_state.dart';
import 'package:logitracker/features/profile/presentation/change_password/view_model/change_password_view_model.dart';
import 'package:logitracker/shared/widgets/custom_ink_well.dart';
import 'package:logitracker/shared/widgets/form_seperator_box.dart';
import 'package:logitracker/shared/widgets/form_title_widget.dart';
import 'package:logitracker/shared/widgets/visibility_widget.dart';
import 'package:progress_dialog2/progress_dialog2.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  bool obscurePassword = true;
  bool obscureNewPassword = true;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
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
                Navigator.pop(context);
                if (state is ChangePasswordLoaded) {
                  displayToastSuccess("Password changed successfully");
                  Navigator.pop(context);
                } else if (state is ChangePasswordError) {
                  displayToastFailure(state.message);
                }
              }
            },
            child: Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: AppDefaults.kPageSidePadding,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Change Password",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Enter your new password",
                          style: TextStyle(color: Color(0xff92929D)),
                        ),
                        adaptableHeight(height: 40),
                        FormTitleWidget(
                          title: "Old Password",
                          child: TextFormField(
                            obscureText: obscurePassword,
                            controller: passwordController,
                            decoration: InputDecoration(
                              suffixIcon: CustomInkWell(
                                onTap: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                                child: VisibilityWidget(
                                  isVisibile: !obscurePassword,
                                ),
                              ),
                            ),
                            validator: Validators.emptyFieldValidator,
                          ),
                        ),
                        FormSeperatorBox(),
                        FormTitleWidget(
                          title: "New Password",
                          child: TextFormField(
                            obscureText: obscurePassword,
                            controller: newPasswordController,
                            decoration: InputDecoration(
                              suffixIcon: CustomInkWell(
                                onTap: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                                child: VisibilityWidget(
                                  isVisibile: !obscurePassword,
                                ),
                              ),
                            ),
                            validator: Validators.emptyFieldValidator,
                          ),
                        ),
                        FormSeperatorBox(),
                        TextButton(
                          onPressed: () {
                            hideKeyboard(context);
                            if (formKey.currentState!.validate() == false) {
                              return;
                            }
                            context.read<ChangePasswordViewModel>().add(
                              ChangePasswordEvent(
                                ChangePasswordEntity(
                                  oldPassword: passwordController.text,
                                  newPassword: newPasswordController.text,
                                ),
                              ),
                            );
                          },
                          child: Text("Change Password"),
                        ),
                        FormSeperatorBox(),
                      ],
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
}
