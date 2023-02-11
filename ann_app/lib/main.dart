import 'package:flutter/material.dart';
import 'package:ann_app/Widgets/populated_maze.dart';

//  **** TO DO ****
// Clean up the functions to get the Size data
// Pass the size data to the agnet widget
// - Work out the boundries of the maze
// - Set up the API to pass the data

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
    // Will come from the API
    List<double> obsticalLocations = [1.0, 2.0];
    List<double> goalLocations = [10.0, 20.0];
    List<List<double>> mazeAgentData = <List<double>>[
      [1.0, 2.0, 3.0, 4.0],
      [10.0, 11.0, 12.0, 13.0]
    ];
    List<double> mazeSizeAsStates = [10.0, 10.0];
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("ANN - APP_V2")),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                PopulatedMaze(
                  obsticalLocations: obsticalLocations,
                  goalLocations: goalLocations,
                  mazeAgentData: mazeAgentData,
                  mazeSizeAsStates: mazeSizeAsStates,
                )
              ]),
        ));
  }
}
