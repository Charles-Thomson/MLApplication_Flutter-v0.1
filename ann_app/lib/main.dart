import 'package:flutter/material.dart';
import 'package:ann_app/Widgets/populated_maze.dart';

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
    // This will come from the API

    // List<double> topRow = [for (double i = 0; i < 10; i++) i];
    // List<double> bottomRow = [for (double i = 90; i < 100; i++) i];
    // List<double> leftRow = [for (double i = 0; i <= 81; i + 9) i];
    // List<double> rightRow = [for (double i = 9; i <= 89; i + 10) i];

    List<double> obsticalLocations = [0.0, 1.0, 2.0];
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
                PopulatedMaze(
                  obsticalLocations: obsticalLocations,
                  mazeAgentData: mazeAgentData,
                )
              ]),
        ));
  }
}
