import 'package:flutter/material.dart';

class ProgressIdicator extends StatelessWidget {
  const ProgressIdicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(
      minHeight: 70,
      color: Colors.black,
    );
  }
}
