import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/app/service_locator/navigation_service.dart';
import 'package:logitracker/app/service_locator/service_locator.dart';
import '../view_model/login_view_model/login_event.dart';
import '../view_model/login_view_model/login_state.dart';
import '../view_model/login_view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<LoginViewModel>(),
      child: BlocConsumer<LoginViewModel, LoginState>(
        listener: (context, state) {
          if (!state.isLoading && state.errorMessage == null) {
            getIt<NavigationService>().pushReplacementNamed('/home');
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.colorScheme.background,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text('Access Account', style: theme.textTheme.displayLarge),
                    const SizedBox(height: 8),
                    Text(
                      'Log in to manage your deliveries.',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 40),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            state.errorMessage != null
                                ? Border.all(
                                  color: theme.colorScheme.error,
                                  width: 1,
                                )
                                : null,
                      ),
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Your email',
                          hintStyle: theme.textTheme.headlineSmall,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                        ),
                        onChanged: (_) {
                          if (state.errorMessage != null) {
                            context.read<LoginViewModel>().add(
                              LoginSubmitted('', ''),
                            ); // Reset error
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            state.errorMessage != null
                                ? Border.all(
                                  color: theme.colorScheme.error,
                                  width: 1,
                                )
                                : null,
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: theme.textTheme.headlineSmall,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            onPressed:
                                () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                        ),
                        onChanged: (_) {
                          if (state.errorMessage != null) {
                            context.read<LoginViewModel>().add(
                              LoginSubmitted('', ''),
                            ); // Reset error
                          }
                        },
                        onSubmitted:
                            (_) => context.read<LoginViewModel>().add(
                              LoginSubmitted(
                                _emailController.text.trim(),
                                _passwordController.text,
                              ),
                            ),
                      ),
                    ),
                    if (state.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          state.errorMessage!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: theme.colorScheme.primary,
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Forget your password?',
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed:
                            state.isLoading
                                ? null
                                : () => context.read<LoginViewModel>().add(
                                  LoginSubmitted(
                                    _emailController.text.trim(),
                                    _passwordController.text,
                                  ),
                                ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                          disabledBackgroundColor: theme.colorScheme.primary
                              .withOpacity(0.7),
                        ),
                        child:
                            state.isLoading
                                ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : Text(
                                  'Log In',
                                  style: theme.textTheme.labelMedium,
                                ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Need to create an account?',
                            style: theme.textTheme.bodySmall,
                          ),
                          TextButton(
                            onPressed:
                                () => getIt<NavigationService>().pushNamed(
                                  '/register',
                                ),
                            style: TextButton.styleFrom(
                              foregroundColor: theme.colorScheme.primary,
                              padding: const EdgeInsets.only(left: 4),
                              minimumSize: const Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Sign Up',
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
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
          );
        },
      ),
    );
  }
}
