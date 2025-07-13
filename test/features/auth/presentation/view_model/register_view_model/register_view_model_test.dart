import 'package:flutter_test/flutter_test.dart';
import 'package:logitracker/core/error/failure.dart';
import 'package:logitracker/features/auth/domain/entity/user_entity.dart';
import 'package:logitracker/features/auth/domain/use_case/user_register_use_case.dart';
import 'package:logitracker/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:logitracker/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:logitracker/features/auth/presentation/view_model/register_view_model/register_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockUserRegisterUseCase extends Mock implements UserRegisterUseCase {}

void main() {
  late MockUserRegisterUseCase mockUserRegisterUseCase;
  late RegisterViewModel registerViewModel;

  setUp(() {
    mockUserRegisterUseCase = MockUserRegisterUseCase();
    registerViewModel = RegisterViewModel(mockUserRegisterUseCase);
  });

  group('RegisterViewModel Tests', () {
    test(
      'should emit [isLoading: true, isLoading: false] when registration is successful',
      () async {
        // Arrange: Mock the UserRegisterUseCase to return a successful result
        when(
          () => mockUserRegisterUseCase(
            firstName: any(named: 'firstName'),
            lastName: any(named: 'lastName'),
            email: any(named: 'email'),
            password: any(named: 'password'),
            company: any(named: 'company'),
            phone: any(named: 'phone'),
            position: any(named: 'position'),
            avatar: any(named: 'avatar'),
            industry: any(named: 'industry'),
            size: any(named: 'size'),
            website: any(named: 'website'),
            address: any(named: 'address'),
            preferences: any(named: 'preferences'),
          ),
        ).thenAnswer(
          (_) async => Right(
            UserEntity(
              userId: '123',
              firstName: 'John',
              lastName: 'Doe',
              email: 'john@example.com',
              company: 'Company',
              phone: '1234567890',
              position: 'Manager',
              avatar: 'avatar.png',
              industry: 'Tech',
              size: 'Medium',
              website: 'example.com',
              address: '123 Street',
              preferences: 'None',
              password: 'password123',
            ),
          ),
        ); // Simulate successful registration

        // Act: Trigger the RegisterSubmitted event
        registerViewModel.add(
          RegisterSubmitted(
            firstName: 'John',
            lastName: 'Doe',
            email: 'john@example.com',
            password: 'password123',
            company: 'Company',
            phone: '1234567890',
            position: 'Manager',
            avatar: 'avatar.png',
            industry: 'Tech',
            size: 'Medium',
            website: 'example.com',
            address: '123 Street',
            preferences: 'None',
          ),
        );

        // Assert: Check if the state emits the correct states
        expectLater(
          registerViewModel.stream,
          emitsInOrder([
            isA<RegisterState>().having(
              (state) => state.isLoading,
              'isLoading',
              true,
            ),
            isA<RegisterState>().having(
              (state) => state.isLoading,
              'isLoading',
              false,
            ),
            isA<RegisterState>().having(
              (state) => state.errorMessage,
              'errorMessage',
              isNull,
            ),
          ]),
        );
      },
    );

    test(
      'should emit [isLoading: true, isLoading: false, errorMessage] when registration fails',
      () async {
        // Arrange: Mock the UserRegisterUseCase to return a failure result
        when(
          () => mockUserRegisterUseCase(
            firstName: any(named: 'firstName'),
            lastName: any(named: 'lastName'),
            email: any(named: 'email'),
            password: any(named: 'password'),
            company: any(named: 'company'),
            phone: any(named: 'phone'),
            position: any(named: 'position'),
            avatar: any(named: 'avatar'),
            industry: any(named: 'industry'),
            size: any(named: 'size'),
            website: any(named: 'website'),
            address: any(named: 'address'),
            preferences: any(named: 'preferences'),
          ),
        ).thenAnswer(
          (_) async => Left(Failure('Registration failed')),
        ); // Simulate failure

        // Act: Trigger the RegisterSubmitted event
        registerViewModel.add(
          RegisterSubmitted(
            firstName: 'John',
            lastName: 'Doe',
            email: 'john@example.com',
            password: 'password123',
            company: 'Company',
            phone: '1234567890',
            position: 'Manager',
            avatar: 'avatar.png',
            industry: 'Tech',
            size: 'Medium',
            website: 'example.com',
            address: '123 Street',
            preferences: 'None',
          ),
        );

        // Assert: Check if the state emits the correct states
        expectLater(
          registerViewModel.stream,
          emitsInOrder([
            isA<RegisterState>().having(
              (state) => state.isLoading,
              'isLoading',
              true,
            ),
            isA<RegisterState>().having(
              (state) => state.isLoading,
              'isLoading',
              false,
            ),
            isA<RegisterState>().having(
              (state) => state.errorMessage,
              'errorMessage',
              'Registration failed',
            ),
          ]),
        );
      },
    );
  });
}
