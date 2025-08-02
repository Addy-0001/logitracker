import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:logitracker/core/error/failure.dart';
import 'package:logitracker/features/auth/domain/entity/user_entity.dart';
import 'package:logitracker/features/auth/domain/use_case/user_register_use_case.dart';
import 'package:logitracker/features/auth/presentation/view_model/register_view_model/signup_view_model.dart';
import 'package:logitracker/features/auth/presentation/view_model/register_view_model/signup_event.dart';
import 'package:logitracker/features/auth/presentation/view_model/register_view_model/signup_state.dart';

class MockUserRegisterUseCase extends Mock implements UserRegisterUseCase {}

void main() {
  late MockUserRegisterUseCase mockUserRegisterUseCase;
  late RegisterViewModel registerViewModel;

  setUp(() {
    mockUserRegisterUseCase = MockUserRegisterUseCase();
    registerViewModel = RegisterViewModel(mockUserRegisterUseCase);
  });

  group('RegisterViewModel', () {
    const firstName = 'John';
    const lastName = 'Doe';
    const email = 'john.doe@example.com';
    const password = 'password123';
    const company = 'Company Inc';
    const phone = '1234567890';
    const position = 'Developer';
    const avatar = '';
    const industry = 'Tech';
    const size = 'Medium';
    const website = 'https://example.com';
    const address = '123 Main St';
    const preferences = 'None';

    final userEntity = UserEntity(
      userId: '1',
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      company: company,
      phone: phone,
      position: position,
      avatar: avatar,
      industry: industry,
      size: size,
      website: website,
      address: address,
      preferences: preferences,
      role: 'driver',
    );

    blocTest<RegisterViewModel, RegisterState>(
      'emits [isLoading: true, isLoading: false] when register succeeds',
      build: () {
        when(
          () => mockUserRegisterUseCase(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            company: company,
            phone: phone,
            position: position,
            avatar: avatar,
            industry: industry,
            size: size,
            website: website,
            address: address,
            preferences: preferences,
          ),
        ).thenAnswer((_) async => Right(userEntity));

        return registerViewModel;
      },
      act:
          (bloc) => bloc.add(
            RegisterSubmitted(
              firstName: firstName,
              lastName: lastName,
              email: email,
              password: password,
              company: company,
              phone: phone,
              position: position,
              avatar: avatar,
              industry: industry,
              size: size,
              website: website,
              address: address,
              preferences: preferences,
            ),
          ),
      expect:
          () => [
            RegisterState(isLoading: true, errorMessage: null),
            RegisterState(isLoading: false, errorMessage: null),
          ],
      verify: (_) {
        verify(
          () => mockUserRegisterUseCase(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            company: company,
            phone: phone,
            position: position,
            avatar: avatar,
            industry: industry,
            size: size,
            website: website,
            address: address,
            preferences: preferences,
          ),
        ).called(1);
      },
    );

    blocTest<RegisterViewModel, RegisterState>(
      'emits [isLoading: true, isLoading: false with errorMessage] when register fails',
      build: () {
        when(
          () => mockUserRegisterUseCase(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            company: company,
            phone: phone,
            position: position,
            avatar: avatar,
            industry: industry,
            size: size,
            website: website,
            address: address,
            preferences: preferences,
          ),
        ).thenAnswer((_) async => Left(Failure('Registration failed')));

        return registerViewModel;
      },
      act:
          (bloc) => bloc.add(
            RegisterSubmitted(
              firstName: firstName,
              lastName: lastName,
              email: email,
              password: password,
              company: company,
              phone: phone,
              position: position,
              avatar: avatar,
              industry: industry,
              size: size,
              website: website,
              address: address,
              preferences: preferences,
            ),
          ),
      expect:
          () => [
            RegisterState(isLoading: true, errorMessage: null),
            RegisterState(
              isLoading: false,
              errorMessage: 'Registration failed',
            ),
          ],
    );
  });
}
