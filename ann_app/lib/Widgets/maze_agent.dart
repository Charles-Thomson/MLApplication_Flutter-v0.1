import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'dart:async';

// Wrking on the passing of agent data to this i.e path and start location
class MazeAgent extends StatefulWidget {
  final List<List<double>> agentData;
  const MazeAgent({super.key, required this.agentData});

  @override
  State<MazeAgent> createState() => _MazeAgent();
}

class _MazeAgent extends State<MazeAgent> {
  late double xLocation;
  late double yLocation;
  late IterableZip<double> moveLocations;

  int index = 0;

  // Have another look at the data format being take in as agentData
  @override
  void initState() {
    super.initState();
    // Works for nested access of lists
    yLocation = widget.agentData.elementAt(0).elementAt(0);
    xLocation = widget.agentData.elementAt(0).elementAt(1);

    moveLocations = IterableZip([widget.agentData[1], widget.agentData[2]]);

    Timer.periodic(const Duration(seconds: 5),
        changePosition); // Essentially the tick rate
  }

  // refactored down
  void changePosition(Timer t) {
    setState(() {
      xLocation = moveLocations.elementAt(index).elementAt(0);
      yLocation = moveLocations.elementAt(index).elementAt(1);
    });

    index++;
    if (index >= moveLocations.length) {
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
