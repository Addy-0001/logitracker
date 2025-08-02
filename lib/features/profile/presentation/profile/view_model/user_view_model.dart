import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/core/bloc/state/bloc_state.dart';
import 'package:logitracker/core/domain/use_case/shake_navigation_use_case.dart';
import 'package:logitracker/features/profile/domain/entity/user_entity.dart';
import 'package:logitracker/features/profile/domain/use_case/get_user_use_case.dart';
import 'package:logitracker/features/profile/domain/use_case/logout_user_use_case.dart';
import 'package:logitracker/features/profile/domain/use_case/update_user_use_case.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserViewModel extends Bloc<UserEvent, UserState> {
  final GetUserUseCase _useCase;
  final UpdateUserUseCase _updateUserUseCase;
  final LogoutUserUseCase _logoutUseCase;
  final ShakeNavigationUseCase _shakeNavigationUseCase;

  UserViewModel(
    this._useCase,
    this._updateUserUseCase,
    this._logoutUseCase,
    this._shakeNavigationUseCase,
  ) : super(UserInitial()) {
    on<FetchUserEvent>(_onFetch);
    on<UpdateUserEvent>(_onUpdateEvent);
    on<LogoutUserEvent>(_onLogoutEvent);
    on<ShakePhoneEvent>(_onShakeEvent);
  }

  Future<void> _onFetch(FetchUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final response = await _useCase.call();
    response.fold(
      (e) {
        emit(UserError(e.toString()));
        return true;
      },
      (x) {
        emit(UserLoaded(x));
        return true;
      },
    );
  }

  Future<void> _onUpdateEvent(
    UpdateUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UpdateUserLoading());
    final response = await _updateUserUseCase.call(event.userEntity);
    if (!response.isRight()) {
    } else {
      emit(UserError("Error Uploading User"));
    }
    add(FetchUserEvent());
  }

  Future<void> _onLogoutEvent(
    LogoutUserEvent event,
    Emitter<UserState> emit,
  ) async {
    await _logoutUseCase.call();
  }

  Future<void> _onShakeEvent(
    ShakePhoneEvent event,
    Emitter<UserState> emit,
  ) async {
    await _shakeNavigationUseCase.call();
  }
}
