import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/features/auth/domain/use_case/register_usecase.dart';
import 'package:logitracker/features/auth/domain/entity/signup_entity.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupViewModel extends Bloc<SignupEvent, SignupState> {
  final RegisterUsecase registerUsecase;
  SignupViewModel(this.registerUsecase) : super(SignupInitial()) {
    on<SignupRequested>(_onSignupRequested);
  }

  Future<void> _onSignupRequested(
    SignupRequested event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoading());

    var response = await registerUsecase.call(event.signupModel);
    response.fold(
      (Exception e) {
        emit(SignupError(e.toString()));
        return true;
      },
      (x) {
        emit(SignupSuccess());
        return true;
      },
    );
  }
}
