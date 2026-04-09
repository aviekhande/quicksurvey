class QuestionOption {
  final String text;

  QuestionOption({required this.text});
}

class Question {
  final String text;
  final List<QuestionOption> options;

  Question({required this.text, required this.options});
}

class QuestionnaireModel {
  final String id;
  final String title;
  final String description;
  final List<Question> questions;

  QuestionnaireModel({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });
}
