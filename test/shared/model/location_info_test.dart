import 'package:flutter_test/flutter_test.dart';
import 'package:logitracker/shared/model/location_info.dart';

void main() {
  group('LocationInfo', () {
    test('should create LocationInfo with correct values', () {
      final locationInfo = LocationInfo(
        name: 'John Pickup',
        phone: '1234567890',
        email: 'john@example.com',
        longitude: '85.324',
        latitude: '27.717',
      );

      expect(locationInfo.name, 'John Pickup');
      expect(locationInfo.phone, '1234567890');
      expect(locationInfo.email, 'john@example.com');
      expect(locationInfo.longitude, '85.324');
      expect(locationInfo.latitude, '27.717');
    });

    test('should handle optional email field', () {
      final locationInfo = LocationInfo(
        name: 'John Pickup',
        phone: '1234567890',
        longitude: '85.324',
        latitude: '27.717',
      );

      expect(locationInfo.email, null);
    });

    test('should convert to map correctly', () {
      final locationInfo = LocationInfo(
        name: 'John Pickup',
        phone: '1234567890',
        email: 'john@example.com',
        longitude: '85.324',
        latitude: '27.717',
      );

      final map = locationInfo.toMap();

      expect(map['name'], 'John Pickup');
      expect(map['phone'], '1234567890');
      expect(map['email'], 'john@example.com');
      expect(map['longitude'], '85.324');
      expect(map['latitude'], '27.717');
    });

    test('should create from map with missing fields', () {
      final map = {
        'name': 'John Pickup',
        'phone': '1234567890',
        'longitude': '85.324',
        'latitude': '27.717',
      };
      final locationInfo = LocationInfo.fromMap(map);

      expect(locationInfo.name, 'John Pickup');
      expect(locationInfo.phone, '1234567890');
      expect(locationInfo.email, null);
      expect(locationInfo.longitude, '85.324');
      expect(locationInfo.latitude, '27.717');
    });

    test('should implement equality correctly', () {
      final location1 = LocationInfo(
        name: 'John Pickup',
        phone: '1234567890',
        longitude: '85.324',
        latitude: '27.717',
      );
      final location2 = LocationInfo(
        name: 'John Pickup',
        phone: '1234567890',
        longitude: '85.324',
        latitude: '27.717',
      );

      expect(location1, equals(location2));
    });

    test('should support copyWith', () {
      final original = LocationInfo(
        name: 'John Pickup',
        phone: '1234567890',
        longitude: '85.324',
        latitude: '27.717',
      );

      final copied = original.copyWith(name: 'Jane Pickup');

      expect(copied.name, 'Jane Pickup');
      expect(copied.phone, '1234567890');
    });
  });
}
