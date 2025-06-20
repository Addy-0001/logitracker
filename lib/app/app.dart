import 'package:flutter/material.dart';
import 'package:logitracker/view/splash_screen.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logitracker',
      theme: getApplicationTheme(),
      home: SplashScreen(), // Placeholder
    );
  }
}
