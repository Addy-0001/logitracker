import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker_mobile_app/core/common/snackbar/snackbar.dart';
import 'package:logitracker_mobile_app/features/auth/domain/use_case/user_logout_usecase.dart';
import 'package:logitracker_mobile_app/app/service_locator/navigation_service.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final logoutUseCase = context.read<UserLogoutUseCase>();
            final result = await logoutUseCase();
            result.fold(
              (failure) => showSnackBar(context, failure.message),
              (_) => context.read<NavigationService>().navigateTo('/login'),
            );
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
