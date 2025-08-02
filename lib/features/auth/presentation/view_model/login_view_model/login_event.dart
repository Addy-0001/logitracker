part of 'login_view_model.dart';

abstract class LoginEvent {}

class LoginRequested extends LoginEvent{
  final LoginEntity loginModel; 
  LoginRequested(this.loginModel); 
}