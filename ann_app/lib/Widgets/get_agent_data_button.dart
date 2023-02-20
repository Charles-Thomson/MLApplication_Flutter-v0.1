import 'package:flutter/material.dart';
import 'dart:convert';
import "package:http/http.dart" as http;

class AgentDataPullButton extends StatefulWidget {
  final Function onClicked;
  const AgentDataPullButton({super.key, required this.onClicked});

  @override
  State<AgentDataPullButton> createState() => _AgentDataPullButton();
}

class _AgentDataPullButton extends State<AgentDataPullButton> {
  String url = '';
  String data = '';
  List tagsJson = [];
  String finalData = "";

  List<double> agentPath = [];
  List<double> agentPathRewards = [];

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
      width: 130,
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
              url = 'http://10.0.2.2:5000/AgentData';
              data = await passData(url);

              List<double> agentPath =
                  formatData(jsonDecode(data)['agent_path']);

              List<double> agentPathRewards =
                  formatData(jsonDecode(data)['agent_path_rewards']);

              // This can be refactored down
              List<List<double>> agentData = [
                agentPath,
                agentPathRewards,
              ];
              widget.onClicked(agentData);
            } catch (e) {
              Null;
            }
          },
          child: const Text("Start Agent", style: TextStyle(fontSize: 14))),
    );
  }
}
