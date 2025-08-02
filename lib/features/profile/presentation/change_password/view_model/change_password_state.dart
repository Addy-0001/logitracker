import 'package:logitracker/core/bloc/state/bloc_state.dart';

abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState
    implements LoadingState {}

class ChangePasswordLoaded extends ChangePasswordState implements LoadedState {}

class ChangePasswordError extends ChangePasswordState implements ErrorState {
  @override
  final String message;
  ChangePasswordError(this.message);
}
