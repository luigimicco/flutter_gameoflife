import 'package:flutter/material.dart';

void main() {
  runApp(MyGOL(title: 'Flutter Game of Life'));
}

class MyGOL extends StatefulWidget {
  final String title;
  const MyGOL({Key? key, required this.title}) : super(key: key);

  @override
  State<MyGOL> createState() => _MyGOLState();
}

class _MyGOLState extends State<MyGOL> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Container()),
    );
  }
}
