import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question_model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000/api';

  static Future<List<Question>> getQuestions() async {
    final response = await http.get(Uri.parse('$baseUrl/questions'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Question.fromJson(e)).toList();
    }
    return [];
  }

  static Future<Map<String, dynamic>> submitAnswers(List<Question> questions, List<int> answers) async {
    final payload = {
      'answers': List.generate(questions.length, (i) => {
            'questionId': questions[i].id,
            'selectedIndex': answers[i],
          })
    };
    final response = await http.post(
      Uri.parse('$baseUrl/submit'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to submit answers');
  }
}
