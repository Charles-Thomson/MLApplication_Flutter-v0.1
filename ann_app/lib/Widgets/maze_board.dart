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
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            border: Border.all(width: 7, color: Colors.red),
            borderRadius: BorderRadius.circular(10)));
  }
}
