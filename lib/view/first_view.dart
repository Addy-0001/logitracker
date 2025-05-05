import 'package:flutter/material.dart';

class FirstView extends StatelessWidget {
  const FirstView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("This is my app bar"), centerTitle: true),
      body: Text(
        "This is my first flutter app. \nThis is my second element. \n This is my third line.",
      ),
    );
  }
}
