import 'package:flutter/material.dart';

void main() {
  runApp(const MyGOL());
}

class MyGOL extends StatelessWidget {
  const MyGOL({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Game of Life',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Container(),
    );
  }
}
