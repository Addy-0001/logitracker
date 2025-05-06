import 'package:flutter/material.dart';
import 'package:logitracker/model/add_model.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  int first = 0;
  int second = 0;
  int result = 0;

  late AddModel model;

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
            onChanged: (value) => {first = int.parse(value)},
          ),
          SizedBox(height: 8),
          SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter Second number",
            ),
            onChanged: (value) => {second = int.parse(value)},
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  model = AddModel(first: first, second: second);
                  result = model.add();
                });
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
