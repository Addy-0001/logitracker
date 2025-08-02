import 'dart:convert';

class DriverInfo {
  final String id;
  final String name;
  final String phone;

  DriverInfo({required this.id, required this.name, required this.phone});

  DriverInfo copyWith({String? id, String? name, String? phone}) {
    return DriverInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'phone': phone};
  }

  factory DriverInfo.fromMap(Map<String, dynamic> map) {
    return DriverInfo(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverInfo.fromJson(String source) =>
      DriverInfo.fromMap(json.decode(source));

  @override
  String toString() => 'DriverInfo(id: $id, name: $name, phone: $phone)';

  @override
  bool operator ==(covariant DriverInfo other) {
    return id == other.id && name == other.name && phone == other.phone;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ phone.hashCode;
}
