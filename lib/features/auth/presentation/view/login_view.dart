import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/core/constant/app_defaults.dart';
import 'package:logitracker/core/helper/ui_helpers.dart';
import 'package:logitracker/core/routes/routes.dart';
import 'package:logitracker/features/auth/domain/entity/login_entity.dart';
import 'package:logitracker/services/core/preference_service.dart';
import 'package:progress_dialog2/progress_dialog2.dart';
import 'package:logitracker/dependency_inject.dart';
import '../view_model/login_view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  var userId = PreferenceService.keyUsername;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginViewModel>(
      create: (_) => locator<LoginViewModel>(),
      child: Scaffold(
        backgroundColor: Colors.white, // Changed to white for a cleaner base
        body: Builder(
          builder: (context) {
            return BlocListener<LoginViewModel, LoginState>(
              listener: (context, state) async {
                if (state is LoginLoading) {
                  ProgressDialog pr = ProgressDialog(context);
                  pr.show();
                } else {
                  Navigator.pop(context);
                  if (state is LoginSuccess) {
                    displayToastSuccess("Logged in Successfully");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.homePage,
                      arguments: userId,
                      (route) =>
                          false, // Changed to false to remove all previous routes
                    );
                  } else if (state is LoginError) {
                    displayToastFailure(state.message);
                  }
                }
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    height:
                        MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        kToolbarHeight, // Adjust height for full screen minus appbar/status bar
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white, // Start with white
                          Colors.grey[50]!, // Transition to light grey
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: AppDefaults.kPageSidePadding.copyWith(
                        top: 0,
                      ), // Adjust top padding
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40), // Reduced top spacing
                            // Logo/Icon Section
                            Center(
                              child: Container(
                                width: 100, // Slightly larger
                                height: 100, // Slightly larger
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.red[600]!, // Darker red
                                      Colors.red[800]!, // Even darker red
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    25,
                                  ), // More rounded
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(
                                        0.4,
                                      ), // Stronger shadow
                                      blurRadius: 25, // More blur
                                      offset: const Offset(
                                        0,
                                        10,
                                      ), // More offset
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.local_shipping,
                                  color: Colors.white,
                                  size: 50, // Larger icon
                                ),
                              ),
                            ),
                            const SizedBox(height: 50), // Increased spacing
                            // Welcome Text
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Welcome Back!', // More inviting text
                                    style: TextStyle(
                                      fontSize: 36, // Larger font
                                      fontWeight: FontWeight.w800, // Bolder
                                      color: Colors.grey[900], // Darker text
                                      letterSpacing: -0.8, // Tighter spacing
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ), // Increased spacing
                                  Text(
                                    'Log in to manage your deliveries and track your progress.', // More descriptive
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
                            const SizedBox(height: 60), // Increased spacing
                            // Email Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email Address',
                                  style: TextStyle(
                                    fontSize: 15, // Slightly larger
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 10), // Increased spacing
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      18,
                                    ), // More rounded
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(
                                        0.3,
                                      ), // Slightly stronger border
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(
                                          0.03,
                                        ), // Lighter shadow
                                        blurRadius: 8, // Less blur
                                        offset: const Offset(
                                          0,
                                          3,
                                        ), // Less offset
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    // Changed to TextFormField for validation
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Enter your email',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                      ),
                                      prefixIcon: Padding(
                                        // Use Padding for icon alignment
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Icon(
                                          Icons.email_outlined,
                                          color: Colors.red[600],
                                          size: 22,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 18,
                                          ), // Adjusted padding
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      if (!RegExp(
                                        r'^[^@]+@[^@]+\.[^@]+',
                                      ).hasMatch(value)) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            // Password Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Password',
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
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.03),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    // Changed to TextFormField for validation
                                    controller: passwordController,
                                    obscureText: _obscurePassword,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Enter your password',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                      ),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Icon(
                                          Icons.lock_outline,
                                          color: Colors.red[600],
                                          size: 22,
                                        ),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.grey[500],
                                        ),
                                        onPressed:
                                            () => setState(
                                              () =>
                                                  _obscurePassword =
                                                      !_obscurePassword,
                                            ),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 18,
                                          ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Forgot Password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // Handle forgot password
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red[600],
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50, 30),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Forgot your password?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red[600],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40), // Increased spacing
                            // Login Button
                            Container(
                              width: double.infinity,
                              height: 58, // Slightly taller
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.red[600]!, // Darker red
                                    Colors.red[800]!, // Even darker red
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(
                                  18,
                                ), // More rounded
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
                                  if (formKey.currentState!.validate()) {
                                    // Validate form
                                    BlocProvider.of<LoginViewModel>(
                                      context,
                                    ).add(
                                      LoginRequested(
                                        LoginEntity(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      ),
                                    );
                                  }
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
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700, // Bolder
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Spacer to push content up if needed
                            const Spacer(),
                            // Optional: Sign up prompt
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.signupPage,
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.red[600],
                                      padding: EdgeInsets.zero,
                                      minimumSize: const Size(50, 30),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      'Sign Up',
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
              ),
            );
          },
        ),
      ),
    );
  }
}
