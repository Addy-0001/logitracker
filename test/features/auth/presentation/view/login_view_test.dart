import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:logitracker/app/service_locator/navigation_service.dart';
import 'package:logitracker/app/service_locator/service_locator.dart';
import 'package:logitracker/features/auth/presentation/view/login_view.dart';
import 'package:logitracker/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:logitracker/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:logitracker/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:logitracker/features/auth/domain/use_case/user_login_use_case.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockLoginViewModel extends Mock implements LoginViewModel {}

class MockNavigationService extends Mock implements NavigationService {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('LoginView Tests', () {
    late MockLoginViewModel mockLoginViewModel;
    late MockNavigationService mockNavigationService;
    late MockSharedPreferences mockSharedPreferences;

    setUpAll(() async {
      // Initialize the service locator
      await setupServiceLocator();

      // Mock SharedPreferences
      mockSharedPreferences = MockSharedPreferences();
      mockLoginViewModel = MockLoginViewModel();
      mockNavigationService = MockNavigationService();

      // Register the mocked SharedPreferences in the service locator
      getIt.registerSingleton<SharedPreferences>(mockSharedPreferences);

      // Mock the behavior of SharedPreferences
      when(
        () => mockSharedPreferences.getString(any()),
      ).thenReturn(null); // Mock getString to return null
    });

    testWidgets('should navigate to home screen on successful login', (
      tester,
    ) async {
      // Mock the behavior of LoginViewModel when LoginSubmitted event is added
      when(() => mockLoginViewModel.state).thenReturn(LoginState());
      when(
        () => mockLoginViewModel.stream,
      ).thenAnswer((_) => Stream.value(LoginState()));

      // Build the widget
      await tester.pumpWidget(MaterialApp(home: LoginView()));

      // Simulate entering email and password
      await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');

      // Trigger login
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify that the navigation to '/home' happens
      verify(
        () => mockNavigationService.pushReplacementNamed('/home'),
      ).called(1);
    });

    testWidgets('should show error message on failed login', (tester) async {
      // Mock the behavior of LoginViewModel for failed login
      when(
        () => mockLoginViewModel.state,
      ).thenReturn(LoginState(errorMessage: 'Login failed'));
      when(() => mockLoginViewModel.stream).thenAnswer(
        (_) => Stream.value(LoginState(errorMessage: 'Login failed')),
      );

      // Build the widget
      await tester.pumpWidget(MaterialApp(home: LoginView()));

      // Simulate entering email and password
      await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');

      // Trigger login
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify that the error message is shown
      expect(find.text('Login failed'), findsOneWidget);
    });
  });
}
