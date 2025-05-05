import 'package:flutter/material.dart';

class PalindromeNumber extends StatefulWidget {
  const PalindromeNumber({super.key});

  @override
  State<PalindromeNumber> createState() => _PalindromeNumberState();
}

class _PalindromeNumberState extends State<PalindromeNumber> {
  bool result = false;
  int number = 0;
  void checkPalindrome(int number) {
    int original = number;
    int reversed = 0;

    while (number > 0) {
      int digit = number % 10;
      reversed = reversed * 10 + digit;
      number ~/= 10;
    }

    bool isPalindrome = (original == reversed);

    setState(() {
      // Store result in a variable to display in the UI
      result = isPalindrome;
    });
  }

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
              checkPalindrome(number);
            },
            child: Text("Calculate"),
          ),

          Text("Result : $result"),
        ],
      ),
    );
  }
}
