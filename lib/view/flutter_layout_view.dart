import 'package:flutter/material.dart';

class FlutterLayoutView extends StatelessWidget {
  const FlutterLayoutView({super.key});

  Widget makeColumn(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [Icon(icon), Text(text)]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Layouting"), backgroundColor: Colors.amber),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          makeColumn(Icons.phone, "Phone"),
          makeColumn(Icons.map, "Map"),
          makeColumn(Icons.share, "Share"),
        ],
      ),
    );
  }
}
