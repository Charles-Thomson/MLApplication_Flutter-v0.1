import 'package:flutter/material.dart';

class MazeObject extends StatelessWidget {
  final List location;
  final double stateSizeX;
  final double stateSizeY;

  const MazeObject(
      {super.key,
      required this.location,
      required this.stateSizeX,
      required this.stateSizeY});

  @override
  Widget build(BuildContext context) {
    double yLocation = location.elementAt(0);
    double xLocation = location.elementAt(1);

    return Positioned(
        top: yLocation,
        left: xLocation,
        child: Container(
            height: stateSizeY, width: stateSizeX, color: Colors.red));
  }
}
