import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/core/bloc/state/bloc_state.dart';
import 'package:logitracker/features/profile/domain/entity/user_entity.dart';
import 'package:logitracker/features/profile/domain/repository/user_repository.dart';

part 'edit_profile_event.dart';
part "edit_profile_state.dart";

class EditProfileViewModel extends Bloc<EditProfileEvent, EditProfileState> {
  final IUserRepository userRepository;

  // Keep track of current loaded user to update local state
  UserEntity? _currentUser;

  EditProfileViewModel(this.userRepository) : super(EditProfileInitial()) {
    on<LoadEditProfile>(_onLoadProfile);
    on<SubmitEditProfile>(_onSubmitProfile);
    on<UploadProfileImage>(_onUploadProfileImage);
  }

  Future<void> _onLoadProfile(
    LoadEditProfile event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(EditProfileLoading());
    try {
      final user = await userRepository.getUserInformation();
      _currentUser = user;
      emit(EditProfileLoaded(user));
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }

  Future<void> _onSubmitProfile(
    SubmitEditProfile event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(EditProfileLoading());
    try {
      await userRepository.updateUser(event.updatedUser);
      // Update local user after successful submit
      _currentUser = event.updatedUser;
      emit(EditProfileSuccess());
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }

  Future<void> _onUploadProfileImage(
    UploadProfileImage event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(EditProfileLoading());
    try {
      final imageUrl = await userRepository.uploadProfileImage(event.imagePath);
      if (_currentUser != null) {
        _currentUser = _currentUser!.copyWith(profileImage: imageUrl);
        emit(EditProfileLoaded(_currentUser!));
      } else {
        // If no user loaded yet, just emit success with no user
        emit(EditProfileSuccess());
      }
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }
}
