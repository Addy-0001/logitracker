part of 'user_view_model.dart';


abstract class UserEvent {}

class FetchUserEvent extends UserEvent {
  FetchUserEvent();
}

class UpdateUserEvent extends UserEvent {
  final UserEntity userEntity;
  UpdateUserEvent(this.userEntity);
}

class LogoutUserEvent extends UserEvent {
  LogoutUserEvent();
}

class ShakePhoneEvent extends UserEvent {
  ShakePhoneEvent();
}
