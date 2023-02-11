import 'package:flutter/material.dart';
import 'package:ann_app/Widgets/populated_maze.dart';
import 'package:ann_app/Widgets/get_data_button.dart';

//  **** TO DO ****
// API work
// Pull button for the API <- works
// Set the data from the pull to the needed vars - will need
// a lod of refactoring

// Working on -> getting nested lists out of the returned string, regex !!

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
    List<double> obsticalLocations = [12.0, 22.0, 32.0, 42.0, 60.0, 61.0, 62.0];
    List<double> goalLocations = [87.0];
    List<List<double>> mazeAgentData = <List<double>>[
      [11.0, 51.0, 57.0, 87.0]
    ];

    List<double> mazeSizeAsStates = [10.0, 10.0];
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Artificial Neural Network - Generational")),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [
              Colors.lightBlue.withOpacity(0.2),
              Colors.blue.withOpacity(0.8)
            ])),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                PopulatedMaze(
                  obsticalLocations: obsticalLocations,
                  goalLocations: goalLocations,
                  mazeAgentData: mazeAgentData,
                  mazeSizeAsStates: mazeSizeAsStates,
                ),
                const DataPullButton()
              ]),
        ),
      ),
    );
  }
}
