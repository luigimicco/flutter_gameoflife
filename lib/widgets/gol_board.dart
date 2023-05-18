import 'package:flutter/material.dart';
import '../logic/gol_logic.dart';
import 'gol_cell.dart';

class GolBoard extends StatelessWidget {
  final GameOfLife gameOfLife;
  final double cellSize;

  const GolBoard({Key? key, required this.gameOfLife, required this.cellSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: _buildCells());
  }

  List<Widget> _buildCells() {
    final List<Widget> items = [];
    int size = gameOfLife.getSize();

    // cells
    for (int r = 0; r < size; ++r) {
      for (int c = 0; c < size; ++c) {
        final left = c * cellSize;
        final top = r * cellSize;

        items.add(
          CustomPaint(
            size: Size.square(cellSize),
            painter: CellPainter(
              cellIsAlive: (gameOfLife.isAlive(r, c)),
              left: left,
              top: top,
            ),
          ),
        );
      }
    }

    // border
    items.add(
      Container(
        width: cellSize * size,
        height: cellSize * size,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      ),
    );

    return items;
  }
}
