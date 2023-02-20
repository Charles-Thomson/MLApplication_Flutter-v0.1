import 'package:flutter/material.dart';
import 'dart:async';

class InfoDisplay extends StatefulWidget {
  //final List<List<double>> displayInfo;
  final List<List<double>> data;

  const InfoDisplay({super.key, required this.data});

  @override
  State<InfoDisplay> createState() => _InfoDisplay();
}

class _InfoDisplay extends State<InfoDisplay> {
  late List<double> pathData;
  late List<double> rewardData;

  late int totalMoves;

  late int episodes;
  late double score;
  late int move;

  int index = 0;

  void updateInfo(Timer t) {
    setState(() {
      score = score + rewardData.elementAt(index);
      move = index;
    });

    index++;
    if (index == rewardData.length - 1) {
      index = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    //List<List<double>> displayInfo = widget.displayInfo;
    pathData = widget.data.elementAt(0);
    rewardData = widget.data.elementAt(1);

    totalMoves = pathData.length;

    episodes = 0;
    score = 0;
    move = 0;

    Timer.periodic(const Duration(seconds: 2), updateInfo);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 350,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: Center(
                  child: Text("Episode: $episodes",
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16)))),
          Expanded(
              child: Center(
                  child: Text("Score: $score",
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16)))),
          Expanded(
              child: Center(
                  child: Text("Move: $move",
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16)))),
        ]));
  }
}
