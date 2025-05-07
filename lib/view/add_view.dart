import 'package:flutter/material.dart';
import 'package:logitracker/model/add_model.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final TextEditingController firstController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  final myKey = GlobalKey<FormState>();

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
      body: Form(
        key: myKey,
        child: Column(
          children: [
            SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter first number",
              ),
              controller: firstController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter First Number";
                }
                return null;
              },
            ),
            SizedBox(height: 8),
            SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Second number",
              ),
              controller: secondController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Second Number";
                }
                return null;
              },
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (myKey.currentState!.validate()) {
                    // int first = int.parse(firstController);

                    setState(() {});
                  }
                },
                child: Text("Add"),
              ),
            ),
            SizedBox(height: 8),
            Container(
              color: Colors.blue,
              width: double.infinity,
              child: RichText(
                text: TextSpan(
                  text: "Result",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                  children: <TextSpan>[
                    TextSpan(
                      text: "=",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),

                    TextSpan(
                      text: '$result',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
