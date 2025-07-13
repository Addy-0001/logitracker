import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/features/auth/domain/use_case/user_login_use_case.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final UserLoginUseCase _userLoginUseCase;

  LoginViewModel(this._userLoginUseCase) : super(LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final success = await _userLoginUseCase(event.email, event.password);
      if (success.isRight()) {
        emit(state.copyWith(isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false, errorMessage: 'Login failed'));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
