import 'package:flutter/material.dart';
import 'package:logitracker/model/simple_interest_model.dart';

class SimpleInterest extends StatefulWidget {
  const SimpleInterest({super.key});

  @override
  State<SimpleInterest> createState() => _SimpleInterestState();
}

class _SimpleInterestState extends State<SimpleInterest> {
  int p = 0;
  int t = 0;
  int r = 0;

  double result = 0;

  late SimpleInterestModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Enter the Principal Amount",
            ),
            onChanged: (value) => {p = int.parse(value)},
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Enter the Time In Years"),
            onChanged: (value) => {t = int.parse(value)},
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Enter the Rate"),
            onChanged: (value) => {r = int.parse(value)},
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                model = SimpleInterestModel(p: p, t: t, r: r);
                result = model.calculateInterest();
              });
            },
            child: Text("Calculate SI"),
          ),
          Text("SI = $result"),
        ],
      ),
    );
  }
}
