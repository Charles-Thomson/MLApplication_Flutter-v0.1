import 'package:flutter/material.dart';
import 'dart:async';

// Wrking on the passing of agent data to this i.e path and start location
class MazeAgent extends StatefulWidget {
  final Iterable<List<double>> agentData;
  const MazeAgent({super.key, required this.agentData});

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

    Timer.periodic(const Duration(seconds: 5),
        changePosition); // Essentially the tick rate
  }

  // refactored down
  void changePosition(Timer t) {
    setState(() {
      yLocation = agentPath.elementAt(index).elementAt(0);
      xLocation = agentPath.elementAt(index).elementAt(1);

      print([xLocation, yLocation]);
    });

    index++;
    if (index >= agentPath.length) {
      index = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      width: 30,
      height: 30,
      top: yLocation,
      left: xLocation,
      duration: const Duration(seconds: 2), // Move time to new position
      curve: Curves.fastOutSlowIn,
      child: Container(color: Colors.blue),
    );
  }
}
