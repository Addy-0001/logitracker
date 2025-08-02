import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/features/profile/domain/use_case/change_password_use_case.dart';
import 'package:logitracker/features/profile/presentation/change_password/view_model/change_password_event.dart';
import 'package:logitracker/features/profile/presentation/change_password/view_model/change_password_state.dart';

class ChangePasswordViewModel extends Bloc<ChangePwEvent, ChangePasswordState> {
  final ChangePasswordUseCase _useCase;
  ChangePasswordViewModel(this._useCase) : super(ChangePasswordInitial()) {
    on<ChangePasswordEvent>(_onChangePassword);
  }

  Future<void> _onChangePassword(
    ChangePasswordEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(ChangePasswordLoading());
    final response = await _useCase.call(event.data);
    response.fold(
      (e) {
        emit(ChangePasswordError(e.toString()));
        return true;
      },
      (x) {
        emit(ChangePasswordLoaded());
        return true;
      },
    );
  }
}
