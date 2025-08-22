import 'package:flutter/material.dart';
import '../models/question_model.dart';

class ResultScreen extends StatelessWidget {
  final List<Question> questions;
  final List<int> answers;

  const ResultScreen({Key? key, required this.questions, required this.answers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int correct = 0;
    for (int i = 0; i < questions.length; i++) {
      if (questions[i].correta == answers[i]) correct++;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Score: $correct/${questions.length}', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
