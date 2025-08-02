import 'dart:convert';

class LocationInfo {
  final String name;
  final String phone;
  final String? email;
  final String longitude;
  final String latitude;

  LocationInfo({
    required this.name,
    required this.phone,
    this.email,
    required this.longitude,
    required this.latitude,
  });

  LocationInfo copyWith({
    String? name,
    String? phone,
    String? email,
    String? longitude,
    String? latitude,
  }) {
    return LocationInfo(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory LocationInfo.fromMap(Map<String, dynamic> map) {
    return LocationInfo(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'],
      longitude: map['longitude'] ?? '',
      latitude: map['latitude'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationInfo.fromJson(String source) =>
      LocationInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationInfo(name: $name, phone: $phone, email: $email, longitude: $longitude, latitude: $latitude)';
  }

  @override
  bool operator ==(covariant LocationInfo other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.longitude == longitude &&
        other.latitude == latitude;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        longitude.hashCode ^
        latitude.hashCode;
  }
}
