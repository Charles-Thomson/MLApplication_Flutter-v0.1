import 'package:flutter/material.dart';
import 'dart:async';
import 'package:collection/collection.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: CustomScaffold());
  }
}

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    List obsticalLocationsA = [
      [10.0, 10.0],
      [30.0, 30.0],
      [100.0, 100.0]
    ];
    List<List<double>> mazeAgentData = <List<double>>[
      [50.0, 50.0],
      [20.0, 40.0, 60.0, 200.0, 100.0],
      [20.0, 40.0, 60.0, 200.0, 100.0]
    ];
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("ANN - APP_V2")),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                StackedBoard(
                  obsticalLocationsA: obsticalLocationsA,
                  mazeAgentData: mazeAgentData,
                )
              ]),
        ));
  }
}

class MazeObject extends StatelessWidget {
  final List location;
  const MazeObject({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    double yLocation = location.elementAt(0);
    double xLocation = location.elementAt(1);
    return Positioned(
        top: yLocation,
        left: xLocation,
        child: Container(height: 30, width: 30, color: Colors.red));
  }
}

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

class StackedBoard extends StatelessWidget {
  final List obsticalLocationsA;
  final List<List<double>> mazeAgentData;
  StackedBoard(
      {super.key,
      required this.obsticalLocationsA,
      required this.mazeAgentData});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const MazeBoard(),
      MazeAgent(agentData: mazeAgentData),
      ..._getObsticals()
    ]);
  }

  // _getAgents() {
  //   var agents = mazeAgentData.map((data) => MazeAgent(agentData: data));
  //   return agents;
  //}

  _getObsticals() {
    var obsticals =
        obsticalLocationsA.map((location) => MazeObject(location: location));

    return obsticals;
  }
}

class MazeBoard extends StatelessWidget {
  const MazeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
        width: 350,
        decoration:
            BoxDecoration(border: Border.all(width: 5, color: Colors.black)));
  }
}
