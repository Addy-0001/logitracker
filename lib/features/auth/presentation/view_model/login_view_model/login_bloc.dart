import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';
import 'package:logitracker_mobile_app/features/auth/domain/use_case/user_login_use_case.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view_model/login_view_model/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserLoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final result = await loginUseCase(event.email, event.password);
    result.fold((failure) {
      print(failure);
      emit(LoginFailure(failure.message));
    }, (user) => emit(LoginSuccess(user)));
  }
}
