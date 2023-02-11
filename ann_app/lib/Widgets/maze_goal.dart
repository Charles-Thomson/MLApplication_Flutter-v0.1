import 'package:flutter/material.dart';

class MazeGoal extends StatelessWidget {
  final List<double> location;
  final double stateSizeX;
  final double stateSizeY;

  const MazeGoal(
      {super.key,
      required this.location,
      required this.stateSizeX,
      required this.stateSizeY});

  @override
  Widget build(BuildContext context) {
    double xLocation = location.elementAt(0);
    double yLocation = location.elementAt(1);

    return Positioned(
        top: yLocation,
        left: xLocation,
        child: Container(
            height: stateSizeX, width: stateSizeY, color: Colors.yellow));
  }
}
