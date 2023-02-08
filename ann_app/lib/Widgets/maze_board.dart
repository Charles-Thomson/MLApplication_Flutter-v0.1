import 'package:flutter/material.dart';

class MazeBoard extends StatelessWidget {
  final double mazeSizeX;
  final double mazeSizeY;

  const MazeBoard(
      {super.key, required this.mazeSizeX, required this.mazeSizeY});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: mazeSizeY,
        width: mazeSizeX,
        decoration:
            BoxDecoration(border: Border.all(width: 5, color: Colors.black)));
  }
}
