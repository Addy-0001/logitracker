import 'package:flutter_test/flutter_test.dart';
import 'package:logitracker/features/auth/domain/entity/signup_entity.dart';

void main() {
  group('SignupEntity', () {
    test('should create SignupEntity with correct values', () {
      final signupEntity = SignupEntity(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        phone: '1234567890',
        password: 'password123',
        confirmPassword: 'password123',
      );

      expect(signupEntity.firstName, 'John');
      expect(signupEntity.lastName, 'Doe');
      expect(signupEntity.email, 'john@example.com');
      expect(signupEntity.phone, '1234567890');
      expect(signupEntity.password, 'password123');
    });

    test('should convert to map correctly', () {
      final signupEntity = SignupEntity(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        phone: '1234567890',
        password: 'password123',
        confirmPassword: 'password123',
      );

      final map = signupEntity.toMap();

      expect(map['firstName'], 'John');
      expect(map['lastName'], 'Doe');
      expect(map['email'], 'john@example.com');
      expect(map['phone'], '1234567890');
      expect(map['password'], 'password123');
    });
  });
}
