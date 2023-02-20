import 'package:flutter/material.dart';
import 'package:ann_app/Widgets/populated_maze.dart';

//  **** TO DO ****
// Goals for the day
// Implement the remainder of the score board from the pulled data
// Clean up the UI elements
// General refactoring and clean up of APP
// Clean up of back end - split out the building and running elements ?
// The info board needs work on the updating side of things to keep it in time
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: CustomScaffold());
  }
}

class CustomScaffold extends StatelessWidget {
  CustomScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Artificial Neural Network - Generational")),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
              children: const <Widget>[
                PopulatedMaze(),
              ]),
        ),
      ),
    );
  }
}
