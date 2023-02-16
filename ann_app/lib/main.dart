import 'package:flutter/material.dart';
import 'package:ann_app/Widgets/populated_maze.dart';

//  **** TO DO ****
// Type is coming out as string in the populated maze
// - this needs to be of type List<double>
// All comes down to sorting out List types
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
              children: const <Widget>[PopulatedMaze()]),
        ),
      ),
    );
  }
}
