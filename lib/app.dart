import 'package:flutter/material.dart';
import 'package:logitracker/view/add.dart';
import 'package:logitracker/view/circle.dart';
import 'package:logitracker/view/first_view.dart';
import 'package:logitracker/view/palindrome_number.dart';
import 'package:logitracker/view/simple_interest.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My First Assignment",
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstView(),
        '/palindrome': (context) => const PalindromeNumber(),
        '/add': (context) => const Add(),
        '/circle': (context) => const Circle(),
        '/interest': (context) => const SimpleInterest(),
      },
    );
  }
}
