import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker_mobile_app/app/service_locator/navigation_service.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';
import 'package:logitracker_mobile_app/features/auth/domain/use_case/user_register_use_case.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:logitracker_mobile_app/features/auth/presentation/view_model/register_view_model/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRegisterUseCase registerUseCase;
  final NavigationService navigationService;

  RegisterBloc(this.registerUseCase, this.navigationService)
    : super(RegisterInitial()) {
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  Future<void> _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    final result = await registerUseCase(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      company: event.company,
      password: event.password,
      role: event.role,
    );
    result.fold((failure) => emit(RegisterFailure(failure.message)), (user) {
      emit(RegisterSuccess(user));
      navigationService.navigateTo('/dashboard');
    });
  }
}
