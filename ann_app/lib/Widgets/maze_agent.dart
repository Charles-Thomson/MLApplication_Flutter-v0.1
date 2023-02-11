import 'package:flutter/material.dart';
import 'dart:async';

// Wrking on the passing of agent data to this i.e path and start location
class MazeAgent extends StatefulWidget {
  final Iterable<List<double>> agentData;
  final double stateSizeX;
  final double stateSizeY;
  const MazeAgent({
    super.key,
    required this.agentData,
    required this.stateSizeX,
    required this.stateSizeY,
  });

  @override
  State<MazeAgent> createState() => _MazeAgent();
}

class _MazeAgent extends State<MazeAgent> {
  late List<double> startLocation;
  late Iterable<List<double>> agentPath;

  late double xLocation;
  late double yLocation;

  int index = 0;

  @override
  void initState() {
    super.initState();
    Iterable<List<double>> agentData = widget.agentData;

    // Start is first list in list<List>
    List<double> startLocation = agentData.elementAt(0);

    // The path is all the List<List>
    agentPath = agentData;

    // Start location as x,y
    yLocation = startLocation.elementAt(0);
    xLocation = startLocation.elementAt(1);

    Timer.periodic(const Duration(seconds: 2),
        changePosition); // Essentially the tick rate
  }

  // refactored down
  void changePosition(Timer t) {
    setState(() {
      yLocation = agentPath.elementAt(index).elementAt(0);
      xLocation = agentPath.elementAt(index).elementAt(1);
    });

    index++;
    if (index >= agentPath.length) {
      index = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    double xSize = widget.stateSizeX;
    double ySize = widget.stateSizeY;
    return AnimatedPositioned(
      width: xSize,
      height: ySize,
      top: yLocation,
      left: xLocation,
      duration: const Duration(seconds: 1), // Move time to new position
      curve: Curves.fastOutSlowIn,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(width: 2, color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
