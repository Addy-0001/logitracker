import 'dart:convert';

class ChangePasswordEntity {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  ChangePasswordEntity({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  ChangePasswordEntity copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmNewPassword,
  }) {
    return ChangePasswordEntity(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentPassword': currentPassword,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    };
  }

  factory ChangePasswordEntity.fromMap(Map<String, dynamic> map) {
    return ChangePasswordEntity(
      currentPassword: map['currentPassword'] as String,
      newPassword: map['newPassword'] as String,
      confirmNewPassword: map['confirmNewPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangePasswordEntity.fromJson(String source) =>
      ChangePasswordEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChangePasswordEntity(currentPassword: $currentPassword, newPassword: $newPassword, confirmNewPassword: $confirmNewPassword)';

  @override
  bool operator ==(covariant ChangePasswordEntity other) {
    if (identical(this, other)) return true;

    return other.currentPassword == currentPassword &&
        other.newPassword == newPassword &&
        other.confirmNewPassword == confirmNewPassword;
  }

  @override
  int get hashCode =>
      currentPassword.hashCode ^
      newPassword.hashCode ^
      confirmNewPassword.hashCode;
}
