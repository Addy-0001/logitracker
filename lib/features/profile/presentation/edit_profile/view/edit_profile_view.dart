import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logitracker/core/constant/app_defaults.dart';
import 'package:logitracker/core/utility/validator.dart';
import 'package:logitracker/features/profile/domain/entity/user_entity.dart';
import 'package:logitracker/features/profile/presentation/edit_profile/view_model/edit_profile_view_model.dart';
import 'package:logitracker/dependency_inject.dart'; 
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<EditProfileViewModel>()..add(LoadEditProfile()),
      child: const _EditProfileForm(),
    );
  }
}

class _EditProfileForm extends StatefulWidget {
  const _EditProfileForm();

  @override
  State<_EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<_EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  File? _pickedImage;
  String? _uploadedImageUrl;
  UserEntity? _currentUser;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
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
              colors: [Colors.red[700]!, Colors.red[800]!, Colors.red[900]!],
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
        child: BlocConsumer<EditProfileViewModel, EditProfileState>(
          listener: (context, state) {
            if (state is EditProfileSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Profile updated successfully"),
                  backgroundColor: Colors.green[700],
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(16),
                ),
              );
              Navigator.pop(context);
            } else if (state is EditProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red[700],
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(16),
                ),
              );
            } else if (state is EditProfileLoaded) {
              _currentUser = state.user;
              firstNameController.text = _currentUser!.firstName;
              lastNameController.text = _currentUser!.lastName;
              phoneController.text = _currentUser!.phone;
              _uploadedImageUrl = _currentUser!.profileImage;
            }
          },
          builder: (context, state) {
            if (state is EditProfileLoading || state is EditProfileInitial) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red[700]!),
                  strokeWidth: 4,
                ),
              );
            } else if (_currentUser != null) {
              return SingleChildScrollView(
                padding: AppDefaults.kPageSidePadding.copyWith(
                  top: 24,
                  bottom: 24,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: _buildProfileImageSection(context)),
                      SizedBox(height: 40.h),

                      _buildTextField(
                        context,
                        controller: firstNameController,
                        label: "First Name",
                        hintText: "Enter your first name",
                        icon: Icons.person_outline,
                        validator: Validators.emptyFieldValidator,
                      ),
                      SizedBox(height: 24.h),

                      _buildTextField(
                        context,
                        controller: lastNameController,
                        label: "Last Name",
                        hintText: "Enter your last name",
                        icon: Icons.person_outline,
                        validator: Validators.emptyFieldValidator,
                      ),
                      SizedBox(height: 24.h),

                      _buildTextField(
                        context,
                        controller: phoneController,
                        label: "Phone Number",
                        hintText: "Enter your phone number",
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        validator: Validators.emptyFieldValidator,
                      ),
                      SizedBox(height: 40.h),

                      _buildSaveChangesButton(context, _currentUser!),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              );
            } else if (state is EditProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.red[700], size: 60),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load profile: ${state.message}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfileImageSection(BuildContext context) {
    final imageRadius = 60.0.sp;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red[400]!, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red[400]!.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: imageRadius,
                backgroundColor: Colors.grey[200],
                backgroundImage:
                    _pickedImage != null
                        ? FileImage(_pickedImage!)
                        : (_uploadedImageUrl != null &&
                                    _uploadedImageUrl!.isNotEmpty
                                ? NetworkImage(_uploadedImageUrl!)
                                : null)
                            as ImageProvider<Object>?,
                child:
                    (_pickedImage == null &&
                            (_uploadedImageUrl == null ||
                                _uploadedImageUrl!.isEmpty))
                        ? Icon(
                          Icons.account_circle_outlined,
                          size: imageRadius * 1.5,
                          color: Colors.red[600],
                        )
                        : null,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => _pickImageAndUpload(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          "Change Profile Photo",
          style: TextStyle(
            color: Colors.red[600],
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    BuildContext context, {
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
            keyboardType: keyboardType,
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
                child: Icon(icon, color: Colors.red[600], size: 20.sp),
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

  Widget _buildSaveChangesButton(BuildContext context, UserEntity currentUser) {
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
          if (_formKey.currentState?.validate() ?? false) {
            final updatedUser = currentUser.copyWith(
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              phone: phoneController.text,
              profileImage: _uploadedImageUrl ?? currentUser.profileImage,
            );
            context.read<EditProfileViewModel>().add(
              SubmitEditProfile(updatedUser),
            );
          }
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
          "Save Changes",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageAndUpload(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
      // Call uploadProfileImage in ViewModel
      final viewModel = context.read<EditProfileViewModel>();
      // Show loading indicator (if not already handled by BlocConsumer)
      // viewModel.emit(EditProfileLoading()); // This might cause issues if not handled carefully with BlocConsumer
      try {
        final imageUrl = await viewModel.userRepository.uploadProfileImage(
          pickedFile.path,
        );
        setState(() {
          _uploadedImageUrl = imageUrl;
        });
        // Update the user with new profileImage
        if (_currentUser != null) {
          _currentUser = _currentUser!.copyWith(profileImage: imageUrl);
          // This might trigger a re-render and potentially another LoadEditProfile if not careful
          // Consider if you need to explicitly emit EditProfileLoaded here or let the next state handle it
          // For now, we'll just update the local _currentUser and _uploadedImageUrl
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Profile image uploaded successfully!"),
            backgroundColor: Colors.green[700],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to upload image: $e"),
            backgroundColor: Colors.red[700],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    }
  }
}
