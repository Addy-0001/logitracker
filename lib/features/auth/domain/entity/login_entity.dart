class LoginEntity {
  final String email;
  final String password;

  LoginEntity({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email, 'password': password};
  }
}
