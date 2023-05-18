import 'dart:async';

import 'package:flutter/material.dart';

import 'logic/gol_logic.dart';
import 'widgets/gol_board.dart';

void main() {
  runApp(const MyGOL(title: 'Flutter Game of Life'));
}

class MyGOL extends StatefulWidget {
  final String title;
  const MyGOL({Key? key, required this.title}) : super(key: key);

  @override
  State<MyGOL> createState() => _MyGOLState();
}

class _MyGOLState extends State<MyGOL> {
  GameOfLife gameOfLife = GameOfLife();
  bool gameIsRunning = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    gameOfLife.randomWorld();
    timer =
        Timer.periodic(const Duration(milliseconds: 500), (Timer t) => next());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void next() {
    if (gameIsRunning) {
      setState(() {
        gameOfLife.nextWorld();
      });
    }
  }

  void playStop() {
    setState(() {
      gameIsRunning = !gameIsRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double paddingSize = 8;
    final screenSize = MediaQuery.of(context).size;

    double cellWidth = (screenSize.width - paddingSize * 2) / GameOfLife.size;
    double cellHeight = (screenSize.height - kToolbarHeight - paddingSize * 2) /
        GameOfLife.size;

    if (cellWidth > cellHeight) {
      cellWidth = cellHeight;
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(paddingSize),
          child: Column(
            children: [
              GolBoard(
                gameOfLife: gameOfLife,
                cellSize: cellWidth,
              ),
              Text("Generazione: ${gameOfLife.generation}"),
              Text("Popolazione: ${gameOfLife.population}"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: playStop,
          tooltip: 'Start/Stop',
          child: gameIsRunning
              ? const Icon(Icons.pause)
              : const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
