import 'package:flutter/material.dart';
import 'dart:async';

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

  static List obsticalLocations = <List<double>>[
    [10, 10],
    [50, 50],
    [100, 100]
  ];

  @override
  Widget build(BuildContext context) {
    List obsticalLocationsA = [
      [10.0, 10.0],
      [30.0, 30.0],
      [100.0, 100.0]
    ];
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("ANN - APP_V2")),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                StackedBoard(obsticalLocationsA: obsticalLocationsA)
              ]),
        ));
  }
}

class MazeAgent extends StatefulWidget {
  const MazeAgent({super.key});

  @override
  State<MazeAgent> createState() => _MazeAgent();
}

class _MazeAgent extends State<MazeAgent> {
  List growableListY = <double>[50, 300, 300, 50];
  List growableListX = <double>[50, 50, 300, 300];

  double topPosition = 50;
  double leftPosiion = 50;
  int listIndex = 0;

  void changePosition(Timer t) async {
    listIndex++;
    (listIndex >= growableListY.length) ? listIndex = 0 : listIndex;
    (listIndex >= growableListX.length) ? listIndex = 0 : listIndex;

    setState(() {
      topPosition = growableListY.elementAt(listIndex);
      leftPosiion = growableListX.elementAt(listIndex);
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5),
        changePosition); // Essentially the tick rate
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      width: 30,
      height: 30,
      top: topPosition,
      left: leftPosiion,
      duration: const Duration(seconds: 2), // Move time to new position
      curve: Curves.fastOutSlowIn,
      child: Container(color: Colors.blue),
    );
  }
}

class MazeObject extends StatelessWidget {
  const MazeObject({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 30, width: 30, color: Colors.red);
  }
}

class StackedBoard extends StatelessWidget {
  final List obsticalLocationsA;
  StackedBoard({super.key, required this.obsticalLocationsA});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [const MazeBoard(), const MazeAgent(), ..._getObsticals()]);
  }

  List _getObsticals() {
    // List obsticalLocationsA = [
    //   [10.0, 10.0],
    //   [30.0, 30.0],
    //   [100.0, 100.0]
    // ];
    int i = 0;
    List obsticals = <Widget>[];
    for (i = 0; i < obsticalLocationsA.length; i++) {
      List currentLocation = obsticalLocationsA.elementAt(i);
      double yPosition = currentLocation.elementAt(0);
      double xPosition = currentLocation.elementAt(1);

      Widget item = Positioned(
          top: yPosition, left: xPosition, child: const MazeObject());

      obsticals.add(item);
    }

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
