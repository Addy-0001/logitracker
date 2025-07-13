import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:logitracker/features/auth/domain/repository/user_repository.dart';
import 'package:logitracker/features/auth/domain/use_case/user_register_use_case.dart';
import 'package:logitracker/features/auth/domain/entity/user_entity.dart';
import 'package:logitracker/core/error/failure.dart';

import 'user_register_use_case_test.mocks.dart';

// Generate mock
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockUserRepository;
  late UserRegisterUseCase registerUseCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    registerUseCase = UserRegisterUseCase(mockUserRepository);
  });

  group('UserRegisterUseCase', () {
    const params = {
      'firstName': 'John',
      'lastName': 'Doe',
      'email': 'john.doe@example.com',
      'password': 'password123',
      'company': 'Acme Inc.',
      'phone': '1234567890',
      'position': 'Manager',
      'avatar': '',
      'industry': 'Tech',
      'size': 'Medium',
      'website': 'https://example.com',
      'address': '123 Main St',
      'preferences': 'None',
    };

    const testUser = UserEntity(
      userId: '1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      password: 'password123',
      company: 'Acme Inc.',
      phone: '1234567890',
      position: 'Manager',
      avatar: '',
      industry: 'Tech',
      size: 'Medium',
      website: 'https://example.com',
      address: '123 Main St',
      preferences: 'None',
      role: 'driver',
    );

    test('should return UserEntity when registration is successful', () async {
      // Arrange
      when(
        mockUserRepository.register(
          firstName: params['firstName']!,
          lastName: params['lastName']!,
          email: params['email']!,
          password: params['password']!,
          company: params['company']!,
          phone: params['phone']!,
          position: params['position']!,
          avatar: params['avatar']!,
          industry: params['industry']!,
          size: params['size']!,
          website: params['website']!,
          address: params['address']!,
          preferences: params['preferences']!,
        ),
      ).thenAnswer((_) async => const Right(testUser));

      // Act
      final result = await registerUseCase.call(
        firstName: params['firstName']!,
        lastName: params['lastName']!,
        email: params['email']!,
        password: params['password']!,
        company: params['company']!,
        phone: params['phone']!,
        position: params['position']!,
        avatar: params['avatar']!,
        industry: params['industry']!,
        size: params['size']!,
        website: params['website']!,
        address: params['address']!,
        preferences: params['preferences']!,
      );

      // Assert
      expect(result, const Right(testUser));
      verify(
        mockUserRepository.register(
          firstName: params['firstName']!,
          lastName: params['lastName']!,
          email: params['email']!,
          password: params['password']!,
          company: params['company']!,
          phone: params['phone']!,
          position: params['position']!,
          avatar: params['avatar']!,
          industry: params['industry']!,
          size: params['size']!,
          website: params['website']!,
          address: params['address']!,
          preferences: params['preferences']!,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('should return Failure when registration fails', () async {
      // Arrange
      final failure = Failure('Registration failed');
      when(
        mockUserRepository.register(
          firstName: params['firstName']!,
          lastName: params['lastName']!,
          email: params['email']!,
          password: params['password']!,
          company: params['company']!,
          phone: params['phone']!,
          position: params['position']!,
          avatar: params['avatar']!,
          industry: params['industry']!,
          size: params['size']!,
          website: params['website']!,
          address: params['address']!,
          preferences: params['preferences']!,
        ),
      ).thenAnswer((_) async => Left(failure));

      // Act
      final result = await registerUseCase.call(
        firstName: params['firstName']!,
        lastName: params['lastName']!,
        email: params['email']!,
        password: params['password']!,
        company: params['company']!,
        phone: params['phone']!,
        position: params['position']!,
        avatar: params['avatar']!,
        industry: params['industry']!,
        size: params['size']!,
        website: params['website']!,
        address: params['address']!,
        preferences: params['preferences']!,
      );

      // Assert
      expect(result, Left(failure));
      verify(
        mockUserRepository.register(
          firstName: params['firstName']!,
          lastName: params['lastName']!,
          email: params['email']!,
          password: params['password']!,
          company: params['company']!,
          phone: params['phone']!,
          position: params['position']!,
          avatar: params['avatar']!,
          industry: params['industry']!,
          size: params['size']!,
          website: params['website']!,
          address: params['address']!,
          preferences: params['preferences']!,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}
