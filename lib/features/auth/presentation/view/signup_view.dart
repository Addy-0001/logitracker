import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logitracker/core/constant/app_defaults.dart';
import 'package:logitracker/core/helper/ui_helpers.dart';
import 'package:logitracker/core/utility/validator.dart';
import 'package:logitracker/dependency_inject.dart';
import 'package:logitracker/features/auth/domain/entity/signup_entity.dart';
import 'package:logitracker/features/auth/presentation/view_model/register_view_model/signup_view_model.dart';
import 'package:logitracker/shared/widgets/custom_ink_well.dart';
import 'package:logitracker/shared/widgets/form_seperator_box.dart';
import 'package:logitracker/shared/widgets/form_title_widget.dart';
import 'package:logitracker/shared/widgets/visibility_widget.dart';
import 'package:progress_dialog2/progress_dialog2.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  bool obsecurePassword = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<SignupViewModel>(),
      child: Scaffold(
        appBar: AppBar(title: Text("Signup")),
        body: Builder(
          builder: (context) {
            return BlocListener<SignupViewModel, SignupState>(
              listener: (context, state) async {
                if (state is SignupLoading) {
                  ProgressDialog pr = ProgressDialog(context);
                  pr.show();
                } else {
                  Navigator.pop(context);
                  if (state is SignupSuccess) {
                    displayToastSuccess("Registered Successfully");
                    Navigator.pop(context);
                  } else if (state is SignupError) {
                    displayToastFailure(state.message);
                  }
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: AppDefaults.kPageSidePadding,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        FormSeperatorBox(),
                        FormTitleWidget(
                          title: "First Name",
                          child: TextFormField(
                            controller: firstNameController,
                            validator: Validators.emptyFieldValidator,
                          ),
                        ),
                        FormSeperatorBox(),
                        FormTitleWidget(
                          title: "Last Name",
                          child: TextFormField(
                            controller: lastNameController,
                            validator: Validators.emptyFieldValidator,
                          ),
                        ),
                        FormSeperatorBox(),
                        FormTitleWidget(
                          title: "Email",
                          child: TextFormField(
                            controller: emailController,
                            validator: Validators.emailValidator,
                          ),
                        ),
                        FormSeperatorBox(),
                        FormTitleWidget(
                          title: "Phone Number",
                          child: TextFormField(
                            controller: phoneNumberController,
                            validator: Validators.emptyFieldValidator,
                          ),
                        ),
                        FormSeperatorBox(),
                        FormTitleWidget(
                          title: "Password",
                          child: TextFormField(
                            obscureText: obsecurePassword,
                            controller: passwordController,
                            decoration: InputDecoration(
                              suffixIcon: CustomInkWell(
                                onTap: () {
                                  setState(() {
                                    obsecurePassword = !obsecurePassword;
                                  });
                                },
                                child: VisibilityWidget(
                                  isVisibile: !obsecurePassword,
                                ),
                              ),
                            ),
                            validator: Validators.emptyFieldValidator,
                          ),
                        ),
                        FormSeperatorBox(height: 8),
                        Align(
                          alignment: Alignment.topRight,
                          child: CustomInkWell(
                            child: Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 12.sp,
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        FormSeperatorBox(),
                        TextButton(
                          onPressed: () {
                            hideKeyboard(context);
                            if (!formKey.currentState!.validate()) {
                              return;
                            }
                            BlocProvider.of<SignupViewModel>(context).add(
                              SignupRequested(
                                SignupEntity(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phoneNumber: phoneNumberController.text,
                                ),
                              ),
                            );
                          },
                          child: Text('Signup'),
                        ),
                        FormSeperatorBox(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
