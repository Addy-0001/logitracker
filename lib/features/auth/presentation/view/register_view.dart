import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider(
      create: (_) => getIt<RegisterViewModel>(),
      child: BlocConsumer<RegisterViewModel, RegisterState>(
        listener: (context, state) {
          if (!state.isLoading && state.errorMessage == null) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Sign up to track your shipments.',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      const SizedBox(height: 40),
                      _buildTextField(
                        context,
                        _firstNameController,
                        'Your first name',
                        TextInputType.name,
                        state.errorMessage,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _lastNameController,
                        'Your last name',
                        TextInputType.name,
                        state.errorMessage,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _emailController,
                        'Your email address',
                        TextInputType.emailAddress,
                        state.errorMessage,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _passwordController,
                        'Create a password',
                        TextInputType.text,
                        state.errorMessage,
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
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _phoneController,
                        'Phone number',
                        TextInputType.phone,
                        state.errorMessage,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _positionController,
                        'Position',
                        TextInputType.text,
                        state.errorMessage,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _avatarController,
                        'Avatar URL',
                        TextInputType.url,
                        state.errorMessage,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _industryController,
                        'Industry',
                        TextInputType.text,
                        state.errorMessage,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _sizeController,
                        'Company size',
                        TextInputType.text,
                        state.errorMessage,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _websiteController,
                        'Website',
                        TextInputType.url,
                        state.errorMessage,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _addressController,
                        'Address',
                        TextInputType.text,
                        state.errorMessage,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        _preferencesController,
                        'Preferences',
                        TextInputType.text,
                        state.errorMessage,
                      ),
                      if (state.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            state.errorMessage!,
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          const Text(
                            'By signing up, you agree to our ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Terms & Conditions',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF8B1E1E),
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
                            backgroundColor: const Color(0xFF8B1E1E),
                            foregroundColor: Colors.white,
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
                                  : const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                            TextButton(
                              onPressed:
                                  () => Navigator.pushNamed(context, '/login'),
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF8B1E1E),
                                padding: const EdgeInsets.only(left: 4),
                                minimumSize: const Size(50, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
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
    String? errorMessage, {
    bool obscureText = false,
    VoidCallback? toggleObscure,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        border:
            errorMessage != null
                ? Border.all(color: Colors.red.shade300, width: 1)
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
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
          suffixIcon:
              obscureText
                  ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
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
