import 'dart:convert';
import 'package:logitracker/features/profile/domain/entity/user_entity.dart';

class AuthResponseEntity extends UserEntity {
  final String token;
  AuthResponseEntity({
    required this.token,
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phone,
    required super.role,
  });

  factory AuthResponseEntity.fromMap(Map<String, dynamic> map) {
    final userMap = map['user'] as Map<String, dynamic>;
    var user = UserEntity.fromMap(userMap);

    return AuthResponseEntity(
      token: map['token'],
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      phone: user.phone.toString(),
      role: user.role,
    );
  }

  factory AuthResponseEntity.fromJson(String source) =>
      AuthResponseEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
