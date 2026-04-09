/// A single selectable option within a question.
class QuestionOption {
  final String text;
  const QuestionOption({required this.text});
}

/// A single MCQ question with its list of options.
class Question {
  final String text;
  final List<QuestionOption> options;
  const Question({required this.text, required this.options});
}

/// Top-level model representing a full questionnaire with metadata and questions.
class QuestionnaireModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final List<Question> questions;

  const QuestionnaireModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.questions,
  });
}
