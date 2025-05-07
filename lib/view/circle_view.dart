import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logitracker/model/circle_model.dart';

class CircleView extends StatefulWidget {
  const CircleView({super.key});

  @override
  State<CircleView> createState() => _CircleViewState();
}

class _CircleViewState extends State<CircleView> {
  double result = 0.0;
  int r = 0;

  late CircleModel model;
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
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter the radius of the circle",
            ),
            onChanged: (value) => {r = int.parse(value)},
          ),

          ElevatedButton(
            onPressed: () {
              setState(() {
                model = CircleModel(radius: r);
                result = model.calculateArea();
              });
            },
            child: Text("Calculate"),
          ),

          Container(
            color: Colors.blue,
            width: double.infinity,
            child: Text(
              "Result : $result",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
