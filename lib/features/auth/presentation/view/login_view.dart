import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker_mobile_app/core/common/snackbar/snackbar.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view_model/login_view_model/login_bloc.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:logitracker_mobile_app/app/service_locator/navigation_service.dart';
import 'package:logitracker_mobile_app/app/service_locator/service_locator.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>(), // Use GetIt to create LoginBloc
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            context.read<NavigationService>().navigateTo('/dashboard');
          } else if (state is LoginFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Login')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  state is LoginLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(
                              LoginButtonPressed(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          },
                          child: const Text('Login'),
                        ),
                  TextButton(
                    onPressed: () {
                      context.read<NavigationService>().navigateTo('/register');
                    },
                    child: const Text('Don’t have an account? Register'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
