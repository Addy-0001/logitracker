import 'package:flutter/material.dart';

class Circle extends StatefulWidget {
  const Circle({super.key});

  @override
  State<Circle> createState() => _CircleState();
}

class _CircleState extends State<Circle> {
  double result = 0.0;
  int r = 0;
  void calculateArea(value) {
    setState(() {
      result = r * r * 3.14;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Area of A Circle"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter the radius of the circle",
            ),
            onChanged: (value) => {r = int.parse(value)},
          ),

          ElevatedButton(
            onPressed: () {
              calculateArea(r);
            },
            child: Text("Calculate"),
          ),

          Text("Result : $result"),
        ],
      ),
    );
  }
}
