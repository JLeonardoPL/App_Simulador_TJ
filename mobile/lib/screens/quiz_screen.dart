import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../services/api_service.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  int _current = 0;
  List<int> _answers = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final questions = await ApiService.getQuestions();
    setState(() {
      _questions = questions;
      _loading = false;
    });
  }

  void _answer(int index) {
    _answers.add(index);
    if (_current + 1 < _questions.length) {
      setState(() {
        _current++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(questions: _questions, answers: _answers),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final question = _questions[_current];
    return Scaffold(
      appBar: AppBar(title: Text('Question ${_current + 1}/${_questions.length}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(question.pergunta, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ...List.generate(
              question.alternativas.length,
              (i) => ElevatedButton(
                onPressed: () => _answer(i),
                child: Text(question.alternativas[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
