import 'package:flutter/material.dart';
import 'package:logitracker/themes/app_theme.dart';
import 'package:logitracker/view/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
      title: "My First Assignment",
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const SplashScreen(),
      //   '/login': (context) => const LoginScreen(),
      //   '/register': (context) => const RegisterScreen(),
      // },
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
