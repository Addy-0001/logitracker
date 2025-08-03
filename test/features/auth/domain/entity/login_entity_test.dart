// test/unit/features/auth/domain/entity/login_entity_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:logitracker/features/auth/domain/entity/login_entity.dart';

void main() {
  group('LoginEntity', () {
    test('should create LoginEntity with correct values', () {
      const email = 'test@example.com';
      const password = 'password123';

      final loginEntity = LoginEntity(email: email, password: password);

      expect(loginEntity.email, email);
      expect(loginEntity.password, password);
    });

    test('should convert to map correctly', () {
      final loginEntity = LoginEntity(
        email: 'test@example.com',
        password: 'password123',
      );

      final map = loginEntity.toMap();

      expect(map['email'], 'test@example.com');
      expect(map['password'], 'password123');
    });
  });
}
