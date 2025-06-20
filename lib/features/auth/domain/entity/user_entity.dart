import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String company;
  final String phone;
  final String position;
  final String avatar;
  final String industry;
  final String size;
  final String website;
  final String address;
  final String preferences;
  final String role = "driver";

  const UserEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.company,
    required this.phone,
    required this.position,
    required this.avatar,
    required this.industry,
    required this.size,
    required this.website,
    required this.address,
    required this.preferences,
  });

  @override
  // implement props
  List<Object?> get props => throw UnimplementedError();
}
