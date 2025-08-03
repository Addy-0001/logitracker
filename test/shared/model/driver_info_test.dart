import 'package:flutter_test/flutter_test.dart';
import 'package:logitracker/shared/model/driver_info.dart';

void main() {
  group('DriverInfo', () {
    test('should create DriverInfo with correct values', () {
      final driverInfo = DriverInfo(
        id: '1',
        name: 'John Driver',
        phone: '1234567890',
      );

      expect(driverInfo.id, '1');
      expect(driverInfo.name, 'John Driver');
      expect(driverInfo.phone, '1234567890');
    });

    test('should convert to map correctly', () {
      final driverInfo = DriverInfo(
        id: '1',
        name: 'John Driver',
        phone: '1234567890',
      );

      final map = driverInfo.toMap();

      expect(map['id'], '1');
      expect(map['name'], 'John Driver');
      expect(map['phone'], '1234567890');
    });

    test('should create from map correctly', () {
      final map = {'id': '1', 'name': 'John Driver', 'phone': '1234567890'};
      final driverInfo = DriverInfo.fromMap(map);

      expect(driverInfo.id, '1');
      expect(driverInfo.name, 'John Driver');
      expect(driverInfo.phone, '1234567890');
    });

    test('should handle JSON serialization', () {
      final driverInfo = DriverInfo(
        id: '1',
        name: 'John Driver',
        phone: '1234567890',
      );

      final json = driverInfo.toJson();
      final fromJson = DriverInfo.fromJson(json);

      expect(fromJson.id, driverInfo.id);
      expect(fromJson.name, driverInfo.name);
      expect(fromJson.phone, driverInfo.phone);
    });

    test('should implement equality correctly', () {
      final driverInfo1 = DriverInfo(
        id: '1',
        name: 'John Driver',
        phone: '1234567890',
      );
      final driverInfo2 = DriverInfo(
        id: '1',
        name: 'John Driver',
        phone: '1234567890',
      );

      expect(driverInfo1, equals(driverInfo2));
      expect(driverInfo1.hashCode, equals(driverInfo2.hashCode));
    });

    test('should support copyWith', () {
      final original = DriverInfo(
        id: '1',
        name: 'John Driver',
        phone: '1234567890',
      );

      final copied = original.copyWith(name: 'Jane Driver');

      expect(copied.id, '1');
      expect(copied.name, 'Jane Driver');
      expect(copied.phone, '1234567890');
    });
  });
}
