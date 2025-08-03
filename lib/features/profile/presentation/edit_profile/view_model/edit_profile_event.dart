part of 'edit_profile_view_model.dart';

abstract class EditProfileEvent {}

class LoadEditProfile extends EditProfileEvent {}

class SubmitEditProfile extends EditProfileEvent {
  final UserEntity updatedUser;

  SubmitEditProfile(this.updatedUser);
}

class UploadProfileImage extends EditProfileEvent {
  final String imagePath;
  UploadProfileImage(this.imagePath);
}

