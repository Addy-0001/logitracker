import 'package:flutter/material.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';
import 'package:logitracker_mobile_app/features/auth/domain/entity/user_entity.dart';
import 'package:logitracker_mobile_app/features/auth/domain/use_case/user_register_use_case.dart';
import 'package:logitracker_mobile_app/app/service_locator/navigation_service.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterViewModel extends ChangeNotifier {
  final UserRegisterUseCase registerUseCase;
  final NavigationService navigationService;
  RegisterState _state = RegisterInitial();

  RegisterViewModel(this.registerUseCase, this.navigationService);

  RegisterState get state => _state;

  Future<void> handleEvent(RegisterEvent event) async {
    if (event is RegisterButtonPressed) {
      _state = RegisterLoading();
      notifyListeners();

      final result = await registerUseCase(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        company: event.company,
        password: event.password,
        role: event.role,
      );
      result.fold(
        (failure) {
          _state = RegisterFailure(failure.message);
          notifyListeners();
        },
        (user) {
          _state = RegisterSuccess(user);
          notifyListeners();
          navigationService.navigateTo('/dashboard');
        },
      );
    }
  }
}
