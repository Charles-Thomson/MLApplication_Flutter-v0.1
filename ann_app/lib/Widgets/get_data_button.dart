import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class DataPullButton extends StatefulWidget {
  final Function onClicked;
  const DataPullButton({super.key, required this.onClicked});

  @override
  State<DataPullButton> createState() => _DataPullButton();
}

class _DataPullButton extends State<DataPullButton> {
  String url = '';
  String data = '';
  List tagsJson = [];
  String finalData = "";
  List<double> mapSizeAsStates = [];
  List<double> obsticalLocations = [];
  List<double> goalLocations = [];
  List<double> agentPathHoler = [];
  List<List<double>> fullData = [];

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
              url = 'http://10.0.2.2:5000/BuildData';
              data = await passData(url);

              List<double> mapSizeAsStates =
                  formatData(jsonDecode(data)['map_size_as_states']);

              List<double> obsticalLocations =
                  formatData(jsonDecode(data)['obstical_locations']);

              List<double> goalLocations =
                  formatData(jsonDecode(data)['goal_locations']);

              // This can be refactored down
              List<List<double>> buildData = [
                mapSizeAsStates,
                obsticalLocations,
                goalLocations,
              ];
              widget.onClicked(buildData);
            } catch (e) {
              Null;
            }
          },
          child: const Text("Build Maze", style: TextStyle(fontSize: 14))),
    );
  }
}
