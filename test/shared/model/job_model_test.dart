import 'package:flutter_test/flutter_test.dart';
import 'package:logitracker/shared/model/driver_info.dart';
import 'package:logitracker/shared/model/job_model.dart';
import 'package:logitracker/shared/model/location_info.dart';

void main() {
  group('Job', () {
    late DriverInfo driverInfo;
    late LocationInfo pickupInfo;
    late LocationInfo dropoffInfo;

    setUp(() {
      driverInfo = DriverInfo(id: '1', name: 'Driver', phone: '123');
      pickupInfo = LocationInfo(
        name: 'Pickup',
        phone: '123',
        longitude: '85.324',
        latitude: '27.717',
      );
      dropoffInfo = LocationInfo(
        name: 'Dropoff',
        phone: '456',
        longitude: '85.325',
        latitude: '27.718',
      );
    });

    test('should create Job with required fields', () {
      final job = Job(
        driverInfo: driverInfo,
        pickupInfo: pickupInfo,
        dropoffInfo: dropoffInfo,
        status: 'pending',
      );

      expect(job.driverInfo, driverInfo);
      expect(job.pickupInfo, pickupInfo);
      expect(job.dropoffInfo, dropoffInfo);
      expect(job.status, 'pending');
      expect(job.isUrgent, false);
    });

    test('should create Job with all fields', () {
      final now = DateTime.now();
      final job = Job(
        driverInfo: driverInfo,
        pickupInfo: pickupInfo,
        dropoffInfo: dropoffInfo,
        currentLongitude: '85.326',
        currentLatitude: '27.719',
        status: 'in_progress',
        note: 'Handle with care',
        fragileItems: true,
        heavyItem: false,
        isUrgent: true,
        createdAt: now,
        updatedAt: now,
      );

      expect(job.currentLongitude, '85.326');
      expect(job.currentLatitude, '27.719');
      expect(job.note, 'Handle with care');
      expect(job.fragileItems, true);
      expect(job.heavyItem, false);
      expect(job.isUrgent, true);
      expect(job.createdAt, now);
      expect(job.updatedAt, now);
    });

    test('should convert to map correctly', () {
      final job = Job(
        driverInfo: driverInfo,
        pickupInfo: pickupInfo,
        dropoffInfo: dropoffInfo,
        status: 'pending',
        isUrgent: true,
      );

      final map = job.toMap();

      expect(map['status'], 'pending');
      expect(map['isUrgent'], true);
      expect(map['driverInfo'], isA<Map<String, dynamic>>());
    });

    test('should create from map correctly', () {
      final map = {
        'driverInfo': driverInfo.toMap(),
        'pickupInfo': pickupInfo.toMap(),
        'dropoffInfo': dropoffInfo.toMap(),
        'status': 'pending',
        'isUrgent': true,
      };

      final job = Job.fromMap(map);

      expect(job.status, 'pending');
      expect(job.isUrgent, true);
      expect(job.driverInfo.id, driverInfo.id);
    });

    test('should support copyWith', () {
      final job = Job(
        driverInfo: driverInfo,
        pickupInfo: pickupInfo,
        dropoffInfo: dropoffInfo,
        status: 'pending',
      );

      final copied = job.copyWith(status: 'completed');

      expect(copied.status, 'completed');
      expect(copied.driverInfo, driverInfo);
    });
  });
}
