import 'package:flutter/material.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';
import 'package:logitracker_mobile_app/features/auth/domain/entity/user_entity.dart';
import 'package:logitracker_mobile_app/features/auth/domain/use_case/user_login_use_case.dart';
import 'package:logitracker_mobile_app/app/service_locator/navigation_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginViewModel extends ChangeNotifier {
  final UserLoginUseCase loginUseCase;
  final NavigationService navigationService;
  LoginState _state = LoginInitial();

  LoginViewModel(this.loginUseCase, this.navigationService);

  LoginState get state => _state;

  Future<void> handleEvent(LoginEvent event) async {
    if (event is LoginButtonPressed) {
      _state = LoginLoading();
      notifyListeners();

      final result = await loginUseCase(event.email, event.password);
      result.fold(
        (failure) {
          _state = LoginFailure(failure.message);
          notifyListeners();
        },
        (user) {
          _state = LoginSuccess(user);
          notifyListeners();
          navigationService.navigateTo('/dashboard');
        },
      );
    }
  }
}
