import 'package:flutter/material.dart';

class CellPainter extends CustomPainter {
  bool cellIsAlive = false;
  double left;
  double top;
  final Paint paintSetting = Paint();

  CellPainter(
      {required this.cellIsAlive, required this.left, required this.top});

  @override
  void paint(Canvas canvas, Size size) {
    paintSetting.color = cellIsAlive ? Colors.green : Colors.white;
    canvas.drawRect(
        Rect.fromLTWH(left, top, size.width, size.height), paintSetting);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    var cellPainter = (oldDelegate as CellPainter);
    return cellPainter.cellIsAlive != cellIsAlive ||
        cellPainter.left != left ||
        cellPainter.top != top;
  }
}
