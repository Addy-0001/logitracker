import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:logitracker/features/auth/domain/repository/auth_repository.dart';
import 'package:logitracker/features/auth/domain/use_case/user_login_use_case.dart';
import 'package:logitracker/features/auth/domain/entity/user_entity.dart';
import 'package:logitracker/core/error/failure.dart';

import 'user_login_use_case_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockUserRepository;
  late UserLoginUseCase loginUseCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    loginUseCase = UserLoginUseCase(mockUserRepository);
  });

  group('UserLoginUseCase', () {
    const String email = 'test@example.com';
    const String password = 'password123';

    const testUser = UserEntity(
      userId: '1',
      firstName: 'Test',
      lastName: 'User',
      email: email,
      password: password,
      company: 'TestCompany',
      phone: '1234567890',
      position: 'Developer',
      avatar: '',
      industry: 'Tech',
      size: 'Medium',
      website: 'https://test.com',
      address: '123 Test Street',
      preferences: 'None',
      role: 'driver',
    );

    test('should return UserEntity on successful login', () async {
      // Arrange
      when(
        mockUserRepository.login(email, password),
      ).thenAnswer((_) async => Right(testUser));

      // Act
      final result = await loginUseCase(email, password);

      // Assert
      expect(result, Right(testUser));
      verify(mockUserRepository.login(email, password)).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('should return Failure on unsuccessful login', () async {
      // Arrange
      final failure = Failure('Invalid credentials');
      when(
        mockUserRepository.login(email, password),
      ).thenAnswer((_) async => Left(failure));

      // Act
      final result = await loginUseCase(email, password);

      // Assert
      expect(result, Left(failure));
      verify(mockUserRepository.login(email, password)).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}
