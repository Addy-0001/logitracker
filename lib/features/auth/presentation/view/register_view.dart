import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/app/service_locator/navigation_service.dart';
import 'package:logitracker/app/service_locator/service_locator.dart';
import '../view_model/register_view_model/register_event.dart';
import '../view_model/register_view_model/register_state.dart';
import '../view_model/register_view_model/register_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _companyController = TextEditingController();
  final _phoneController = TextEditingController();
  final _positionController = TextEditingController();
  final _avatarController = TextEditingController();
  final _industryController = TextEditingController();
  final _sizeController = TextEditingController();
  final _websiteController = TextEditingController();
  final _addressController = TextEditingController();
  final _preferencesController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    _positionController.dispose();
    _avatarController.dispose();
    _industryController.dispose();
    _sizeController.dispose();
    _websiteController.dispose();
    _addressController.dispose();
    _preferencesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<RegisterViewModel>(),
      child: BlocConsumer<RegisterViewModel, RegisterState>(
        listener: (context, state) {
          if (!state.isLoading && state.errorMessage == null) {
            getIt<NavigationService>().pushReplacementNamed('/home');
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.colorScheme.background,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'Create Account',
                        style: theme.textTheme.displayLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign up to track your shipments.',
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 40),
                      _buildTextField(
                        context,
                        _firstNameController,
                        'Your first name',
                        TextInputType.name,
                        state.errorMessage,
                        theme,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _lastNameController,
                        'Your last name',
                        TextInputType.name,
                        state.errorMessage,
                        theme,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _emailController,
                        'Your email address',
                        TextInputType.emailAddress,
                        state.errorMessage,
                        theme,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _passwordController,
                        'Create a password',
                        TextInputType.text,
                        state.errorMessage,
                        theme,
                        obscureText: _obscurePassword,
                        toggleObscure:
                            () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _confirmPasswordController,
                        'Confirm your password',
                        TextInputType.text,
                        state.errorMessage,
                        theme,
                        obscureText: _obscureConfirmPassword,
                        toggleObscure:
                            () => setState(
                              () =>
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword,
                            ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _companyController,
                        'Company name',
                        TextInputType.text,
                        state.errorMessage,
                        theme,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _phoneController,
                        'Phone number',
                        TextInputType.phone,
                        state.errorMessage,
                        theme,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _positionController,
                        'Position',
                        TextInputType.text,
                        state.errorMessage,
                        theme,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _avatarController,
                        'Avatar URL',
                        TextInputType.url,
                        state.errorMessage,
                        theme,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _industryController,
                        'Industry',
                        TextInputType.text,
                        state.errorMessage,
                        theme,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _sizeController,
                        'Company size',
                        TextInputType.text,
                        state.errorMessage,
                        theme,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _websiteController,
                        'Website',
                        TextInputType.url,
                        state.errorMessage,
                        theme,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _addressController,
                        'Address',
                        TextInputType.text,
                        state.errorMessage,
                        theme,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _preferencesController,
                        'Preferences',
                        TextInputType.text,
                        state.errorMessage,
                        theme,
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
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Text(
                            'By signing up, you agree to our ',
                            style: theme.textTheme.bodySmall,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Terms & Conditions',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed:
                              state.isLoading
                                  ? null
                                  : () {
                                    if (_passwordController.text ==
                                        _confirmPasswordController.text) {
                                      context.read<RegisterViewModel>().add(
                                        RegisterSubmitted(
                                          firstName:
                                              _firstNameController.text.trim(),
                                          lastName:
                                              _lastNameController.text.trim(),
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text,
                                          company:
                                              _companyController.text.trim(),
                                          phone: _phoneController.text.trim(),
                                          position:
                                              _positionController.text.trim(),
                                          avatar: _avatarController.text.trim(),
                                          industry:
                                              _industryController.text.trim(),
                                          size: _sizeController.text.trim(),
                                          website:
                                              _websiteController.text.trim(),
                                          address:
                                              _addressController.text.trim(),
                                          preferences:
                                              _preferencesController.text
                                                  .trim(),
                                        ),
                                      );
                                    } else {
                                      context.read<RegisterViewModel>().add(
                                        RegisterSubmitted(
                                          firstName: '',
                                          lastName: '',
                                          email: '',
                                          password: '',
                                          company: '',
                                          phone: '',
                                          position: '',
                                          avatar: '',
                                          industry: '',
                                          size: '',
                                          website: '',
                                          address: '',
                                          preferences: '',
                                        ),
                                      );
                                    }
                                  },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
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
                                    'Sign Up',
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
                              'Already have an account?',
                              style: theme.textTheme.bodySmall,
                            ),
                            TextButton(
                              onPressed:
                                  () => getIt<NavigationService>().pushNamed(
                                    '/login',
                                  ),
                              style: TextButton.styleFrom(
                                foregroundColor: theme.colorScheme.primary,
                                padding: const EdgeInsets.only(left: 4),
                                minimumSize: const Size(50, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Log In',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    TextEditingController controller,
    String hintText,
    TextInputType keyboardType,
    String? errorMessage,
    ThemeData theme, {
    bool obscureText = false,
    VoidCallback? toggleObscure,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
        border:
            errorMessage != null
                ? Border.all(color: theme.colorScheme.error, width: 1)
                : null,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textCapitalization:
            keyboardType == TextInputType.name
                ? TextCapitalization.words
                : TextCapitalization.none,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.textTheme.headlineSmall,
          prefixIcon: Icon(
            Icons.person_outline,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          suffixIcon:
              obscureText
                  ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    onPressed: toggleObscure,
                  )
                  : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onChanged: (_) {
          if (errorMessage != null) {
            context.read<RegisterViewModel>().add(
              RegisterSubmitted(
                firstName: '',
                lastName: '',
                email: '',
                password: '',
                company: '',
                phone: '',
                position: '',
                avatar: '',
                industry: '',
                size: '',
                website: '',
                address: '',
                preferences: '',
              ),
            );
          }
        },
      ),
    );
  }
}
