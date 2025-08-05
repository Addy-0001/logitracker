import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/core/constant/app_defaults.dart';
import 'package:logitracker/core/helper/ui_helpers.dart';
import 'package:logitracker/core/utility/validator.dart';
import 'package:logitracker/dependency_inject.dart';
import 'package:logitracker/features/auth/domain/entity/signup_entity.dart';
import 'package:logitracker/features/auth/presentation/view_model/register_view_model/signup_view_model.dart';
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
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<SignupViewModel>(),
      child: Scaffold(
        backgroundColor: Colors.white,
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
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.grey[50]!],
                    ),
                  ),
                  child: Padding(
                    padding: AppDefaults.kPageSidePadding.copyWith(top: 0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          // Logo/Icon Section
                          Center(
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.red[600]!, Colors.red[800]!],
                                ),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.4),
                                    blurRadius: 25,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.local_shipping,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          // Welcome Text
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.grey[900],
                                    letterSpacing: -0.8,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Sign up to manage your deliveries and track your progress.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 60),

                          // First Name Field
                          _buildInputField(
                            controller: firstNameController,
                            label: "First Name",
                            hintText: "Enter your first name",
                            icon: Icons.person_outline,
                            validator: Validators.emptyFieldValidator,
                          ),
                          const SizedBox(height: 24),

                          // Last Name Field
                          _buildInputField(
                            controller: lastNameController,
                            label: "Last Name",
                            hintText: "Enter your last name",
                            icon: Icons.person_outline,
                            validator: Validators.emptyFieldValidator,
                          ),
                          const SizedBox(height: 24),

                          // Email Field
                          _buildInputField(
                            controller: emailController,
                            label: "Email Address",
                            hintText: "Enter your email",
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.emailValidator,
                          ),
                          const SizedBox(height: 24),

                          // Phone Number Field
                          _buildInputField(
                            controller: phoneController,
                            label: "Phone Number",
                            hintText: "Enter your phone number",
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                            validator: Validators.phoneValidator,
                          ),
                          const SizedBox(height: 24),

                          // Password Field
                          _buildPasswordField(
                            controller: passwordController,
                            label: "Password",
                            hintText: "Enter your password",
                            obscureText: _obscurePassword,
                            onToggleVisibility:
                                () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                            validator: Validators.passwordValidator,
                          ),
                          const SizedBox(height: 24),

                          // Confirm Password Field
                          _buildPasswordField(
                            controller: confirmPasswordController,
                            label: "Confirm Password",
                            hintText: "Confirm your password",
                            obscureText: _obscureConfirmPassword,
                            onToggleVisibility:
                                () => setState(
                                  () =>
                                      _obscureConfirmPassword =
                                          !_obscureConfirmPassword,
                                ),
                            validator:
                                (value) => Validators.confirmPasswordValidator(
                                  value,
                                  passwordController.text,
                                ),
                          ),
                          const SizedBox(height: 32),

                          // Signup Button
                          Container(
                            width: double.infinity,
                            height: 58,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.red[600]!, Colors.red[800]!],
                              ),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
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
                                      confirmPassword:
                                          confirmPasswordController.text,
                                      phone: phoneController.text,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Already have an account? Login prompt
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red[600],
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(50, 30),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  // Helper method to build consistent input fields
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(icon, color: Colors.red[600], size: 22),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }

  // Helper method to build password fields with visibility toggle
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  Icons.lock_outline,
                  color: Colors.red[600],
                  size: 22,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[500],
                ),
                onPressed: onToggleVisibility,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
