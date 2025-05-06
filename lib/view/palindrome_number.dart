import 'package:flutter/material.dart';
import 'package:logitracker/model/palindrome_number_model.dart';

class PalindromeNumber extends StatefulWidget {
  const PalindromeNumber({super.key});

  @override
  State<PalindromeNumber> createState() => _PalindromeNumberState();
}

class _PalindromeNumberState extends State<PalindromeNumber> {
  bool result = false;
  int number = 0;
  late PalindromeNumberModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Palindrome Number"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter any number to check for Palindrome",
            ),
            onChanged: (value) => {number = int.parse(value)},
          ),

          ElevatedButton(
            onPressed: () {
              setState(() {
                model = PalindromeNumberModel(number: number);
                result = model.checkPalindrome();
              });
            },
            child: Text("Calculate"),
          ),

          Text("Result : $result"),
        ],
      ),
    );
  }
}
