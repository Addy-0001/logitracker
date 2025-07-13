import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker_mobile_app/core/common/snackbar/snackbar.dart';
import 'package:logitracker_mobile_app/features/auth/domain/use_case/user_register_use_case.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view_model/register_view_model/register_bloc.dart';
import 'package:logitracker_mobile_app/app/service_locator/navigation_service.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view_model/register_view_model/register_state.dart';

class RegisterView extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        context.read<UserRegisterUseCase>(),
        context.read<NavigationService>(),
      ),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            context.read<NavigationService>().navigateTo('/dashboard');
          } else if (state is RegisterFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text('Register')),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(labelText: 'First Name'),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(labelText: 'Last Name'),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _companyController,
                      decoration: InputDecoration(labelText: 'Company'),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    state is RegisterLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              context.read<RegisterBloc>().add(
                                RegisterButtonPressed(
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  email: _emailController.text,
                                  company: _companyController.text,
                                  password: _passwordController.text,
                                  role: 'admin',
                                ),
                              );
                            },
                            child: Text('Register'),
                          ),
                    TextButton(
                      onPressed: () {
                        context.read<NavigationService>().navigateTo('/login');
                      },
                      child: Text('Already have an account? Login'),
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
