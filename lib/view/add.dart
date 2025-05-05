import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  int num1 = 0;
  int num2 = 0;
  int result = 0;

  void add(num1, num2) {
    setState(() {
      result = num1 + num2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Add Two Numbers App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter first number",
            ),
            onChanged: (value) => {num1 = int.parse(value)},
          ),
          SizedBox(height: 8),
          SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter Second number",
            ),
            onChanged: (value) => {num2 = int.parse(value)},
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                add(num1, num2);
              },
              child: Text("Add"),
            ),
          ),
          SizedBox(height: 8),
          Text("Result = $result"),
        ],
      ),
    );
  }
}
