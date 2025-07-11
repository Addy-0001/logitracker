abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String company;
  final String password;
  final String? role;

  RegisterButtonPressed({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.company,
    required this.password,
    this.role,
  });
}
