import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class DataPullButton extends StatefulWidget {
  const DataPullButton({super.key});

  @override
  State<DataPullButton> createState() => _DataPullButton();
}

class _DataPullButton extends State<DataPullButton> {
  String url = '';
  String data = '';
  List tagsJson = [];
  String finalData = "";

  passData(String url) async {
    http.Response responce = await http.get(Uri.parse(url));
    return responce.body;
  }

  dataFormatting() {
    List<String> formattedData = finalData.split(',');
    print(formattedData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
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
              url = 'http://10.0.2.2:5000/RunData';
              data = await passData(url);
              tagsJson = jsonDecode(data)['output'];
              finalData = tagsJson.toString();
              print(finalData);
              dataFormatting();
            } catch (e) {
              Null;
            }
          },
          child: const Text("Pull Data")),
    );
  }
}
