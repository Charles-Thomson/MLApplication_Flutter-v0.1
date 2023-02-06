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
  late List xPathData;
  late List yPathData;

  double holderT = 0.0;
  double holderL = 0.0;

  int index = 0;

  // Issue with this - have a nother look at it ?
  Iterable<List> returnNewPosition() sync* {
    for (var pair in IterableZip([xPathData, yPathData])) {
      yield pair;
    }
  }

  // New approach just to see if it works
  List returnNewPositionB() {
    List returnList = [];
    returnList.add(xPathData[index]);
    returnList.add(yPathData[index]);
    index++;
    if (index >= xPathData.length) {
      index = 0;
    }
    return returnList;
  }

  void changePosition(Timer t) {
    // Iterable<List<dynamic>> newLocation = returnNewPosition();
    // for (var i in newLocation) {
    //   holderT = i[0];
    //   holderL = i[1];
    // }
    List newLocation = returnNewPositionB();
    holderT = newLocation.elementAt(0);
    holderL = newLocation.elementAt(1);

    setState(() {
      xLocation = holderT;
      yLocation = holderL;
    });
  }

  @override
  void initState() {
    super.initState();
    List startLocation = widget.agentData[0]; // Location at index 0
    yLocation = startLocation.elementAt(0);
    xLocation = startLocation.elementAt(1);

    xPathData = widget.agentData[1];
    yPathData = widget.agentData[2];

    Timer.periodic(const Duration(seconds: 5),
        changePosition); // Essentially the tick rate
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
