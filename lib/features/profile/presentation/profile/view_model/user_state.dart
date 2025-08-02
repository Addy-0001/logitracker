part of 'user_view_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState implements LoadingState {}

class UserLoaded extends UserState implements LoadedState {
  final UserEntity data;
  UserLoaded(this.data);
}

class UserError extends UserState implements ErrorState {
  @override
  final String message;
  UserError(this.message);
}

class UpdateUserLoading extends UserState {}
