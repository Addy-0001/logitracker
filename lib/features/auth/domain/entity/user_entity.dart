import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String company;
  final String role;

  UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.company,
    required this.role, String? token,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, email, company, role];
}
