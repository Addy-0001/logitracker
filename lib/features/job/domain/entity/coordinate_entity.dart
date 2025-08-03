class CoordinateEntity {
  final double latitude;
  final double longitude;

  CoordinateEntity({required this.latitude, required this.longitude});

  factory CoordinateEntity.fromMap(Map<String, dynamic> map) {
    return CoordinateEntity(
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'latitude': latitude, 'longitude': longitude};
  }

  CoordinateEntity copyWith({double? latitude, double? longitude}) {
    return CoordinateEntity(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  String toString() => 'CoordinateEntity(lat: $latitude, long: $longitude)';
}
