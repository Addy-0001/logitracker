import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_case/user_register_use_case.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterViewModel extends Bloc<RegisterEvent, RegisterState> {
  final UserRegisterUseCase registerUseCase;

  RegisterViewModel(this.registerUseCase) : super(RegisterState()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      final result = await registerUseCase(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
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
        (failure) => emit(
          state.copyWith(isLoading: false, errorMessage: failure.message),
        ),
        (_) => emit(state.copyWith(isLoading: false)),
      );
    });
  }
}
