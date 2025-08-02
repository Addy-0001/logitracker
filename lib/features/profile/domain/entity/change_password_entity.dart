import 'dart:convert';

class ChangePasswordEntity {
  final String oldPassword;
  final String newPassword;
  ChangePasswordEntity({required this.oldPassword, required this.newPassword});

  ChangePasswordEntity copyWith({String? oldPassword, String? newPassword}) {
    return ChangePasswordEntity(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }

  factory ChangePasswordEntity.fromMap(Map<String, dynamic> map) {
    return ChangePasswordEntity(
      oldPassword: map['oldPassword'] as String,
      newPassword: map['newPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangePasswordEntity.fromJson(String source) =>
      ChangePasswordEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChangePasswordEntity(oldPassword: $oldPassword, newPassword: $newPassword)';

  @override
  bool operator ==(covariant ChangePasswordEntity other) {
    if (identical(this, other)) return true;

    return other.oldPassword == oldPassword && other.newPassword == newPassword;
  }

  @override
  int get hashCode => oldPassword.hashCode ^ newPassword.hashCode;
}
