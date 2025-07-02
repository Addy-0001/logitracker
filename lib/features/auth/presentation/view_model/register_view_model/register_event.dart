part of 'register_view_model.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
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
  final String? role;

  const RegisterSubmitted({
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
    this.role,
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    email,
    password,
    company,
    phone,
    position,
    avatar,
    industry,
    size,
    website,
    address,
    preferences,
    role,
  ];
}
