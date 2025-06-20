import 'package:flutter/material.dart';
import 'package:logitracker/features/auth/presentation/view/login_view.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logitracker',
      theme: getApplicationTheme(),
      home: LoginView(), // Placeholder
    );
  }
}
