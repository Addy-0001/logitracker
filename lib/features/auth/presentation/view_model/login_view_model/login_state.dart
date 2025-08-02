part of 'login_view_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  LoginSuccess();
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
