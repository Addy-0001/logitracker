import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/core/error/failure.dart';
import 'package:logitracker/features/auth/domain/use_case/user_register_use_case.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterViewModel extends Bloc<RegisterEvent, RegisterState> {
  final UserRegisterUseCase registerUseCase;

  RegisterViewModel(this.registerUseCase) : super(const RegisterState()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await registerUseCase(
      email: event.email,
      password: event.password,
      firstName: event.firstName,
      lastName: event.lastName,
      company: event.company,
      phone: event.phone,
      position: event.position,
      avatar: event.avatar,
      industry: event.industry,
      size: event.size,
      website: event.website,
      address: event.address,
      preferences: event.preferences,
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (user) => emit(state.copyWith(isLoading: false, errorMessage: null)),
    );
  }
}
