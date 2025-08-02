import 'dart:convert';

import 'driver_info.dart';
import 'location_info.dart';

class Job {
  final DriverInfo driverInfo;
  final LocationInfo pickupInfo;
  final LocationInfo dropoffInfo;
  final String? currentLongitude;
  final String? currentLatitude;
  final String status;
  final String? note;
  final bool? fragileItems;
  final bool? heavyItem;
  final bool isUrgent;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Job({
    required this.driverInfo,
    required this.pickupInfo,
    required this.dropoffInfo,
    this.currentLongitude,
    this.currentLatitude,
    required this.status,
    this.note,
    this.fragileItems,
    this.heavyItem,
    this.isUrgent = false,
    this.createdAt,
    this.updatedAt,
  });

  Job copyWith({
    DriverInfo? driverInfo,
    LocationInfo? pickupInfo,
    LocationInfo? dropoffInfo,
    String? currentLongitude,
    String? currentLatitude,
    String? status,
    String? note,
    bool? fragileItems,
    bool? heavyItem,
    bool? isUrgent,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Job(
      driverInfo: driverInfo ?? this.driverInfo,
      pickupInfo: pickupInfo ?? this.pickupInfo,
      dropoffInfo: dropoffInfo ?? this.dropoffInfo,
      currentLongitude: currentLongitude ?? this.currentLongitude,
      currentLatitude: currentLatitude ?? this.currentLatitude,
      status: status ?? this.status,
      note: note ?? this.note,
      fragileItems: fragileItems ?? this.fragileItems,
      heavyItem: heavyItem ?? this.heavyItem,
      isUrgent: isUrgent ?? this.isUrgent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'driverInfo': driverInfo.toMap(),
      'pickupInfo': pickupInfo.toMap(),
      'dropoffInfo': dropoffInfo.toMap(),
      'currentCoords': {
        'longitude': currentLongitude,
        'latitude': currentLatitude,
      },
      'status': status,
      'note': note,
      'addOns': {'fragileItems': fragileItems, 'heavyItem': heavyItem},
      'isUrgent': isUrgent,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    final coords = map['currentCoords'] ?? {};
    final addOns = map['addOns'] ?? {};

    return Job(
      driverInfo: DriverInfo.fromMap(map['driverInfo']),
      pickupInfo: LocationInfo.fromMap(map['pickupInfo']),
      dropoffInfo: LocationInfo.fromMap(map['dropoffInfo']),
      currentLongitude: coords['longitude'],
      currentLatitude: coords['latitude'],
      status: map['status'] ?? 'pending',
      note: map['note'],
      fragileItems: addOns['fragileItems'],
      heavyItem: addOns['heavyItem'],
      isUrgent: map['isUrgent'] ?? false,
      createdAt:
          map['createdAt'] != null ? DateTime.tryParse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.tryParse(map['updatedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Job.fromJson(String source) => Job.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Job(driverInfo: $driverInfo, pickupInfo: $pickupInfo, dropoffInfo: $dropoffInfo, currentLongitude: $currentLongitude, currentLatitude: $currentLatitude, status: $status, note: $note, fragileItems: $fragileItems, heavyItem: $heavyItem, isUrgent: $isUrgent, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Job other) {
    return driverInfo == other.driverInfo &&
        pickupInfo == other.pickupInfo &&
        dropoffInfo == other.dropoffInfo &&
        currentLongitude == other.currentLongitude &&
        currentLatitude == other.currentLatitude &&
        status == other.status &&
        note == other.note &&
        fragileItems == other.fragileItems &&
        heavyItem == other.heavyItem &&
        isUrgent == other.isUrgent &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    return driverInfo.hashCode ^
        pickupInfo.hashCode ^
        dropoffInfo.hashCode ^
        currentLongitude.hashCode ^
        currentLatitude.hashCode ^
        status.hashCode ^
        note.hashCode ^
        fragileItems.hashCode ^
        heavyItem.hashCode ^
        isUrgent.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
