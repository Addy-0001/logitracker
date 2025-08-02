import 'package:logitracker/features/profile/domain/entity/change_password_entity.dart';

abstract class ChangePwEvent {}

class ChangePasswordEvent extends ChangePwEvent {
  final ChangePasswordEntity data;
  ChangePasswordEvent(this.data);
}
