import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TJExamSimulator());
}

class TJExamSimulator extends StatelessWidget {
  const TJExamSimulator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TJ Exam Simulator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
