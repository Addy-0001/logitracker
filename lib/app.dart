import 'package:flutter/material.dart';
import 'package:logitracker/view/add_view.dart';
import 'package:logitracker/view/circle_view.dart';
import 'package:logitracker/view/first_view.dart';
import 'package:logitracker/view/flutter_layout_view.dart';
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
        '/add': (context) => const AddView(),
        '/circle': (context) => const CircleView(),
        '/interest': (context) => const SimpleInterest(),
        '/layout': (context) => const FlutterLayoutView(),
      },
    );
  }
}
