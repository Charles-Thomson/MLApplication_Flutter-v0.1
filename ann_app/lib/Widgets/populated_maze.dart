// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:ann_app/Widgets/maze_agent.dart';
import 'package:ann_app/Widgets/maze_obstical.dart';
import 'package:ann_app/Widgets/maze_board.dart';
import 'package:ann_app/location_conversions.dart';
import 'package:ann_app/Widgets/maze_goal.dart';
import 'package:ann_app/Widgets/get_data_button.dart';
import 'package:ann_app/Widgets/get_agent_data_button.dart';
import 'package:ann_app/Widgets/maze_info_display.dart';
import 'package:ann_app/Widgets/run_maze_button.dart';

class PopulatedMaze extends StatefulWidget {
  // final List<double> obsticalLocations;
  // final List<double> goalLocations;
  // final List<List<double>> mazeAgentData;
  // final List<double> mazeSizeAsStates;
  const PopulatedMaze({
    super.key,
    // required this.obsticalLocations,
    // required this.goalLocations,
    // required this.mazeAgentData,
    // required this.mazeSizeAsStates
  });

  @override
  State<PopulatedMaze> createState() => _PopulatedMaze();
}

// Full rework
// Build after the button is pressed
// Init all the others as empty to start
//
class _PopulatedMaze extends State<PopulatedMaze> {
  // Board size in pixel
  double mazeSizeX = 350.0;
  double mazeSizeY = 350.0;

  // board size in states
  double totalStatesX = 0;
  double totalStatesY = 0;

  // Need a setter for this
  // The size of each state on board
  double stateSizeX = 0;
  double stateSizeY = 0;

  List<Widget> agent = [];
  Iterable<MazeObject> obsticals = [];
  Iterable<MazeGoal> goals = [];
  List<Widget> infoDisply = [];

  List<Widget> indicator = [];

  // Empty to start
  late Iterable<List<double>> obsticalLocations;
  late Iterable<List<double>> goalLocations;
  late Iterable<List<double>> mazeAgentData;
  //late Iterable<Iterable<List<double>>> mazeAgentData; multiple agents

  @override
  void initState() {
    super.initState();
  }

  void setStateSize(data) {
    List mazeSizeAsStates = data.elementAt(0);
    totalStatesX = mazeSizeAsStates.elementAt(0);
    totalStatesY = mazeSizeAsStates.elementAt(1);

    List<double> stateSizes =
        sizeOfStates(totalStatesX, totalStatesY, mazeSizeX, mazeSizeY);

    stateSizeX = stateSizes.elementAt(0);
    stateSizeY = stateSizes.elementAt(1);
  }

  Iterable<MazeObject> buildObsticals(List<List<double>> data) {
    List<double> obsticalLocationsHolder = data.elementAt(1);
    obsticalLocations = _stateToCoord(obsticalLocationsHolder);
    Iterable<MazeObject> newObsticals = _getObsticals();
    return newObsticals;
  }

  Iterable<MazeGoal> buildGoals(List<List<double>> data) {
    List<double> goalLocationsHolder = data.elementAt(2);
    goalLocations = _stateToCoord(goalLocationsHolder);
    Iterable<MazeGoal> newGoals = _getGoals();
    return newGoals;
  }

  List<Widget> buildAgents(List<List<double>> data) {
    List<double> mazeAgentDataHolder = data.elementAt(0);
    mazeAgentData = _stateToCoord(mazeAgentDataHolder);
    Widget newAgnets = _getAgent();
    List<Widget> rtn = [];
    rtn.add(newAgnets);

    return rtn;
    // multiple agents
    //mazeAgentData = mazeAgentDataHolder.map((x) => _stateToCoord(x));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: [
        MazeBoard(mazeSizeX: mazeSizeX, mazeSizeY: mazeSizeY),
        ...obsticals,
        ...goals,
        ...agent,
      ]),
      Stack(children: [...infoDisply]),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const runMazeButton(),
          DataPullButton(onClicked: (List<List<double>> buildData) {
            setStateSize(buildData);
            setState(() {
              obsticals = buildObsticals(buildData);
              goals = buildGoals(buildData);
              //agent = buildAgents(buildData);
            });
          }),
          AgentDataPullButton(onClicked: (List<List<double>> agentData) {
            setState(() {
              agent = buildAgents(agentData);
              Widget newInfoDisply = InfoDisplay(data: agentData);
              infoDisply.add(newInfoDisply);
            });
          })
        ],
      ),

      //const InfoDisplay(),
    ]);
  }

  Iterable<List<double>> _stateToCoord(List<double> data) => data.map((state) =>
      stateToBoardLocation(stateSizeX, stateSizeY, totalStatesY, state));

  Iterable<MazeObject> _getObsticals() =>
      obsticalLocations.map((location) => MazeObject(
          location: location, stateSizeX: stateSizeX, stateSizeY: stateSizeY));

  Iterable<MazeGoal> _getGoals() => goalLocations.map((location) => MazeGoal(
      location: location, stateSizeX: stateSizeX, stateSizeY: stateSizeY));

  // multiple agents
  // _getAgents() => mazeAgentData.map((data) => MazeAgent(
  //     agentData: data, stateSizeX: stateSizeX, stateSizeY: stateSizeY));

  Widget _getAgent() => MazeAgent(
      agentData: mazeAgentData, stateSizeX: stateSizeX, stateSizeY: stateSizeY);
}
