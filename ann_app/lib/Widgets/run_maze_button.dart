import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class runMazeButton extends StatefulWidget {
  const runMazeButton({super.key});

  @override
  State<runMazeButton> createState() => _runMazeButton();
}

class _runMazeButton extends State<runMazeButton> {
  String url = "";

  passData(String url) async {
    http.Response responce = await http.get(Uri.parse(url));
    return responce.body;
  }

  // Convert dynamic data type to List<double>
  List<double> formatData(dynamic data) {
    var dataList = data as List;
    return (dataList.map((e) => double.parse(e))).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 60,
      decoration: BoxDecoration(
          border:
              Border.all(width: 3, color: Colors.blueAccent.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(6)),
      child: TextButton(
          style: TextButton.styleFrom(
              foregroundColor: Colors.black.withOpacity(0.6),
              padding: const EdgeInsets.all(10.0),
              textStyle: const TextStyle(fontSize: 20)),
          onPressed: () async {
            try {
              print("Run maze button Pressed");
              url = 'http://10.0.2.2:5000/RunMaze';
              await passData(url);
            } catch (e) {
              Null;
            }
          },
          child: const Text(
            "Learn Maze",
            style: TextStyle(fontSize: 14),
          )),
    );
  }
}
