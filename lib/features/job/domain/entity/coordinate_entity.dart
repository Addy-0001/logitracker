class CoordinateEntity {
  final double latitude;
  final double longitude;

  CoordinateEntity({required this.latitude, required this.longitude});

  factory CoordinateEntity.fromMap(Map<String, dynamic> map) {
    final lat = map['latitude'];
    final lng = map['longitude'];

    if (lat == null || lng == null) {
      throw ArgumentError('Latitude and longitude cannot be null');
    }

    return CoordinateEntity(
      latitude: double.parse(lat.toString()),
      longitude: double.parse(lng.toString()),
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

class JobCoordinates {
  final CoordinateEntity pickupCoordinates;
  final CoordinateEntity dropoffCoordinates;
  final CoordinateEntity? currentCoordinates;

  JobCoordinates({
    required this.pickupCoordinates,
    required this.dropoffCoordinates,
    this.currentCoordinates,
  });

  factory JobCoordinates.fromMap(Map<String, dynamic> map) {
    final current = map['currentCoords'];
    CoordinateEntity? currentCoords;

    if (current != null &&
        current['latitude'] != null &&
        current['longitude'] != null) {
      currentCoords = CoordinateEntity.fromMap(current);
    }

    return JobCoordinates(
      pickupCoordinates: CoordinateEntity.fromMap(map['pickupInfo']),
      dropoffCoordinates: CoordinateEntity.fromMap(map['dropoffInfo']),
      currentCoordinates: currentCoords,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pickupCoordinates': pickupCoordinates.toMap(),
      'dropoffCoordinates': dropoffCoordinates.toMap(),
      'currentCoordinates': currentCoordinates?.toMap(),
    };
  }

  @override
  String toString() {
    return 'JobCoordinates(pickup: $pickupCoordinates, dropoff: $dropoffCoordinates, current: $currentCoordinates)';
  }
}
