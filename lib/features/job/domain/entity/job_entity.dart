import 'dart:convert';

class DriverInfo {
  final String id;
  final String name;
  final String phone;

  DriverInfo({required this.id, required this.name, required this.phone});

  factory DriverInfo.fromMap(Map<String, dynamic> map) {
    return DriverInfo(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'phone': phone};
  }
}

class LocationInfo {
  final String name;
  final String phone;
  final String email;
  final String longitude;
  final String latitude;

  LocationInfo({
    required this.name,
    required this.phone,
    required this.email,
    required this.longitude,
    required this.latitude,
  });

  factory LocationInfo.fromMap(Map<String, dynamic> map) {
    return LocationInfo(
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      longitude: map['longitude'] as String,
      latitude: map['latitude'] as String,
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
}

class Coordinates {
  final double? longitude;
  final double? latitude;

  Coordinates({this.longitude, this.latitude});

  factory Coordinates.fromMap(Map<String, dynamic> map) {
    return Coordinates(
      longitude: (map['longitude'] as num?)?.toDouble(),
      latitude: (map['latitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'longitude': longitude, 'latitude': latitude};
  }
}

class AddOns {
  final bool fragileItems;
  final bool heavyItem;

  AddOns({required this.fragileItems, required this.heavyItem});

  factory AddOns.fromMap(Map<String, dynamic> map) {
    return AddOns(
      fragileItems: map['fragileItems'] as bool,
      heavyItem: map['heavyItem'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {'fragileItems': fragileItems, 'heavyItem': heavyItem};
  }
}

class JobEntity {
  final String id;
  final DriverInfo driverInfo;
  final LocationInfo pickupInfo;
  final LocationInfo dropoffInfo;
  final Coordinates currentCoords;
  final String status;
  final String note;
  final AddOns addOns;
  final bool isUrgent; // Changed to bool
  final String createdAt;
  final String updatedAt;

  JobEntity({
    required this.id,
    required this.driverInfo,
    required this.pickupInfo,
    required this.dropoffInfo,
    required this.currentCoords,
    required this.status,
    required this.note,
    required this.addOns,
    required this.isUrgent,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobEntity.fromMap(Map<String, dynamic> map) {
    try {
      return JobEntity(
        id: map['_id'] as String,
        driverInfo: DriverInfo.fromMap(
          map['driverInfo'] as Map<String, dynamic>,
        ),
        pickupInfo: LocationInfo.fromMap(
          map['pickupInfo'] as Map<String, dynamic>,
        ),
        dropoffInfo: LocationInfo.fromMap(
          map['dropoffInfo'] as Map<String, dynamic>,
        ),
        currentCoords: Coordinates.fromMap(
          map['currentCoords'] as Map<String, dynamic>,
        ),
        status: map['status'] as String,
        note: map['note'] as String,
        addOns: AddOns.fromMap(map['addOns'] as Map<String, dynamic>),
        isUrgent: map['isUrgent'] as bool, // Changed to bool
        createdAt: map['createdAt'] as String,
        updatedAt: map['updatedAt'] as String,
      );
    } catch (e) {
      rethrow;
    }
  }

  factory JobEntity.fromJson(String source) =>
      JobEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'driverInfo': driverInfo.toMap(),
      'pickupInfo': pickupInfo.toMap(),
      'dropoffInfo': dropoffInfo.toMap(),
      'currentCoords': currentCoords.toMap(),
      'status': status,
      'note': note,
      'addOns': addOns.toMap(),
      'isUrgent': isUrgent,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  String toString() {
    return 'JobEntity(id: $id, driverInfo: $driverInfo, pickupInfo: $pickupInfo, dropoffInfo: $dropoffInfo, currentCoords: $currentCoords, status: $status, note: $note, addOns: $addOns, isUrgent: $isUrgent, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant JobEntity other) {
    if (identical(this, other)) return true;
    return other.id == id &&
        other.driverInfo == driverInfo &&
        other.pickupInfo == pickupInfo &&
        other.dropoffInfo == dropoffInfo &&
        other.currentCoords == currentCoords &&
        other.status == status &&
        other.note == note &&
        other.addOns == addOns &&
        other.isUrgent == isUrgent &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        driverInfo.hashCode ^
        pickupInfo.hashCode ^
        dropoffInfo.hashCode ^
        currentCoords.hashCode ^
        status.hashCode ^
        note.hashCode ^
        addOns.hashCode ^
        isUrgent.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
