import 'package:flutter/material.dart';
import 'package:ann_app/Widgets/maze_agent.dart';
import 'package:ann_app/Widgets/maze_obstical.dart';
import 'package:ann_app/Widgets/maze_board.dart';
import 'package:ann_app/location_conversions.dart';

class PopulatedMaze extends StatelessWidget {
  final List obsticalLocations;
  final List<List<double>> mazeAgentData;
  PopulatedMaze(
      {super.key,
      required this.obsticalLocations,
      required this.mazeAgentData});

  // Maze size in pixel
  double mazeSizeX = 350.0;
  double mazeSizeY = 350.0;

  // board size in states
  double statesXHolder = 10.0;
  double statesYHolder = 10.0;

  // The size of each state on board in pixle
  double stateSizeX = 0.0;
  double stateSizeY = 0.0;

  @override
  Widget build(BuildContext context) {
    sizeOfStates(statesXHolder, statesYHolder, mazeSizeX, mazeSizeY);
    return Stack(children: [
      MazeBoard(mazeSizeX: mazeSizeX, mazeSizeY: mazeSizeY),
      MazeAgent(agentData: mazeAgentData),
      ..._getObsticals()
    ]);
  }

  // _getAgents() {
  //   var agents = mazeAgentData.map((data) => MazeAgent(agentData: data));
  //   return agents;
  //}

  // convert the obstical locations from state to (x,y) for board
  Iterable<List<double>> _convertObsticalLocations() {
    // Get the size of each state(x,y) pixel
    List<double> stateSizes =
        sizeOfStates(statesXHolder, statesYHolder, mazeSizeX, mazeSizeY);

    stateSizeX = stateSizes.elementAt(0);
    stateSizeY = stateSizes.elementAt(1);

    // Map all the obstical states to board locations(x,y)
    var obsticalBoardLocations = obsticalLocations.map((state) =>
        stateToBoardLocation(stateSizeX, stateSizeY, statesYHolder, state));

    return obsticalBoardLocations;
  }

  _getObsticals() {
    Iterable<List<double>> obsticalBoardLocations = _convertObsticalLocations();
    var obsticals = obsticalBoardLocations.map((location) => MazeObject(
        location: location, stateSizeX: stateSizeX, stateSizeY: stateSizeY));

    return obsticals;
  }
}
