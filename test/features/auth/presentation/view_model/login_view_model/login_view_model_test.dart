import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:logitracker/core/error/failure.dart';
import 'package:logitracker/features/auth/domain/entity/user_entity.dart';
import 'package:logitracker/features/auth/domain/use_case/user_login_use_case.dart';
import 'package:logitracker/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:logitracker/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:logitracker/features/auth/presentation/view_model/login_view_model/login_view_model.dart';

class MockUserLoginUseCase extends Mock implements UserLoginUseCase {}

void main() {
  late MockUserLoginUseCase mockUserLoginUseCase;
  late LoginViewModel loginViewModel;

  setUp(() {
    mockUserLoginUseCase = MockUserLoginUseCase();
    loginViewModel = LoginViewModel(mockUserLoginUseCase);
  });

  group('LoginViewModel', () {
    const email = 'test@example.com';
    const password = 'password123';
    final userEntity = UserEntity(
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

    blocTest<LoginViewModel, LoginState>(
      'emits [isLoading: true, isLoading: false] when login succeeds',
      build: () {
        when(
          () => mockUserLoginUseCase(email, password),
        ).thenAnswer((_) async => Right(userEntity));
        return loginViewModel;
      },
      act: (bloc) => bloc.add(LoginSubmitted(email, password)),
      expect: () => [LoginState(isLoading: true), LoginState(isLoading: false)],
      verify: (_) {
        verify(() => mockUserLoginUseCase(email, password)).called(1);
      },
    );

    blocTest<LoginViewModel, LoginState>(
      'emits [isLoading: true, isLoading: false with errorMessage] when login fails',
      build: () {
        when(
          () => mockUserLoginUseCase(email, password),
        ).thenAnswer((_) async => Left(Failure('Invalid credentials')));
        return loginViewModel;
      },
      act: (bloc) => bloc.add(LoginSubmitted(email, password)),
      expect:
          () => [
            LoginState(isLoading: true),
            LoginState(isLoading: false, errorMessage: 'Login failed'),
          ],
      verify: (_) {
        verify(() => mockUserLoginUseCase(email, password)).called(1);
      },
    );

    blocTest<LoginViewModel, LoginState>(
      'emits [isLoading: true, isLoading: false with errorMessage] when an exception is thrown',
      build: () {
        when(
          () => mockUserLoginUseCase(email, password),
        ).thenThrow(Exception('Unexpected error'));
        return loginViewModel;
      },
      act: (bloc) => bloc.add(LoginSubmitted(email, password)),
      expect:
          () => [
            LoginState(isLoading: true),
            isA<LoginState>().having(
              (state) => state.errorMessage,
              'errorMessage',
              contains('Exception: Unexpected error'),
            ),
          ],
    );
  });
}
