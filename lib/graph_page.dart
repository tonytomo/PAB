import 'package:flutter/material.dart';

class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Icon(Icons.insert_chart_outlined_rounded ),
          title: Text("Graph"), backgroundColor: Colors.teal[700]),
      body: Center(
        child: Text("lululu"),
      ),
    );
  }
}
