class Question {
  final int id;
  final String pergunta;
  final List<String> alternativas;
  final int correta;

  Question({
    required this.id,
    required this.pergunta,
    required this.alternativas,
    required this.correta,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as int,
      pergunta: json['pergunta'] as String,
      alternativas: List<String>.from(json['alternativas'] ?? []),
      correta: json['correta'] as int,
    );
  }
}
