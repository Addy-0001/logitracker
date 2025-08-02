import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/core/bloc/state/bloc_state.dart';

part 'edit_profile_event.dart';
part "edit_profile_state.dart";

class EditProfileViewModel extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileViewModel() : super(EditProfileLoaded());
}
