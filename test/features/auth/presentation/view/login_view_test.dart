import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:logitracker/features/auth/presentation/view/login_view.dart';
import 'package:logitracker/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:logitracker/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:logitracker/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:logitracker/app/service_locator/navigation_service.dart';
import 'package:logitracker/app/service_locator/service_locator.dart';
import 'package:logitracker/app/router/route_generator.dart';

class MockLoginViewModel extends Mock implements LoginViewModel {}

class FakeLoginEvent extends Fake implements LoginEvent {}

class FakeLoginState extends Fake implements LoginState {}

void main() {
  late MockLoginViewModel mockLoginViewModel;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});

    registerFallbackValue(FakeLoginEvent());
    registerFallbackValue(FakeLoginState());

    await setupServiceLocator();
  });

  setUp(() {
    mockLoginViewModel = MockLoginViewModel();

    when(
      () => mockLoginViewModel.stream,
    ).thenAnswer((_) => const Stream.empty());
    when(() => mockLoginViewModel.state).thenReturn(LoginState());
  });

  Widget createApp() {
    return MaterialApp(
      navigatorKey: getIt<NavigationService>().navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: BlocProvider<LoginViewModel>.value(
        value: mockLoginViewModel,
        child: const LoginView(),
      ),
    );
  }

  testWidgets('Login flow success navigates to /home', (tester) async {
    await tester.pumpWidget(createApp());

    const testEmail = 'test@example.com';
    const testPassword = 'password123';

    // Enter email and password
    await tester.enterText(find.byType(TextField).at(0), testEmail);
    await tester.enterText(find.byType(TextField).at(1), testPassword);

    // Tap Login button
    await tester.tap(find.text('Log In'));
    await tester.pump();

    // Simulate bloc emits loading then success (no error)
    whenListen(
      mockLoginViewModel,
      Stream.fromIterable([
        LoginState(isLoading: true),
        LoginState(isLoading: false), // success
      ]),
    );
    when(
      () => mockLoginViewModel.state,
    ).thenReturn(LoginState(isLoading: false));

    // Let UI rebuild
    await tester.pumpAndSettle();

    // ✅ Adjust this check depending on what text is shown in HomeView
    expect(find.text('Logitracker'), findsOneWidget);
  });
}
