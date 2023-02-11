import 'package:flutter/material.dart';
import 'package:ann_app/Widgets/maze_agent.dart';
import 'package:ann_app/Widgets/maze_obstical.dart';
import 'package:ann_app/Widgets/maze_board.dart';
import 'package:ann_app/location_conversions.dart';
import 'package:ann_app/Widgets/maze_goal.dart';

class PopulatedMaze extends StatefulWidget {
  final List<double> obsticalLocations;
  final List<double> goalLocations;
  final List<List<double>> mazeAgentData;
  final List<double> mazeSizeAsStates;
  const PopulatedMaze(
      {super.key,
      required this.obsticalLocations,
      required this.goalLocations,
      required this.mazeAgentData,
      required this.mazeSizeAsStates});

  @override
  State<PopulatedMaze> createState() => _PopulatedMaze();
}

class _PopulatedMaze extends State<PopulatedMaze> {
  // Board size in pixel
  double mazeSizeX = 350.0;
  double mazeSizeY = 350.0;

  // board size in states
  late double totalStatesX;
  late double totalStatesY;

  // The size of each state on board
  late double stateSizeX;
  late double stateSizeY;

  late Iterable<List<double>> obsticalLocations;
  late Iterable<List<double>> goalLocations;
  late Iterable<Iterable<List<double>>> mazeAgentData;

  @override
  void initState() {
    super.initState();
    totalStatesX = widget.mazeSizeAsStates.elementAt(0);
    totalStatesY = widget.mazeSizeAsStates.elementAt(1);

    List<double> stateSizes =
        sizeOfStates(totalStatesX, totalStatesY, mazeSizeX, mazeSizeY);

    stateSizeX = stateSizes.elementAt(0);
    stateSizeY = stateSizes.elementAt(1);

    obsticalLocations = _stateToCoord(widget.obsticalLocations);
    goalLocations = _stateToCoord(widget.goalLocations);
    mazeAgentData = widget.mazeAgentData.map((data) => _stateToCoord(data));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      MazeBoard(mazeSizeX: mazeSizeX, mazeSizeY: mazeSizeY),
      ..._getAgents(),
      ..._getObsticals(),
      ..._getGoals(),
    ]);
  }

  Iterable<List<double>> _stateToCoord(List<double> data) => data.map((state) =>
      stateToBoardLocation(stateSizeX, stateSizeY, totalStatesY, state));

  _getObsticals() => obsticalLocations.map((location) => MazeObject(
      location: location, stateSizeX: stateSizeX, stateSizeY: stateSizeY));

  _getGoals() => goalLocations.map((location) => MazeGoal(
      location: location, stateSizeX: stateSizeX, stateSizeY: stateSizeY));

  _getAgents() => mazeAgentData.map((data) => MazeAgent(
      agentData: data, stateSizeX: stateSizeX, stateSizeY: stateSizeY));
}
