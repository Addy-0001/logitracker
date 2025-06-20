import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_case/user_login_use_case.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final UserLoginUseCase loginUseCase;

  LoginViewModel(this.loginUseCase) : super(LoginState()) {
    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      final result = await loginUseCase(event.email, event.password);
      result.fold(
        (failure) => emit(
          state.copyWith(isLoading: false, errorMessage: failure.message),
        ),
        (_) => emit(state.copyWith(isLoading: false)),
      );
    });
  }
}
