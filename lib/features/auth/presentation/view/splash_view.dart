import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker_mobile_app/features/auth/domain/use_case/user_get_current_use_case.dart';
import 'package:logitracker_mobile_app/app/service_locator/navigation_service.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate loading
    final useCase = context.read<UserGetCurrentUseCase>();
    final result = await useCase();
    result.fold(
      (failure) => context.read<NavigationService>().navigateTo('/login'),
      (user) => context.read<NavigationService>().navigateTo('/dashboard'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logitracker_logo.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
