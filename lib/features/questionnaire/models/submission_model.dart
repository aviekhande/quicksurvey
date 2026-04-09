class SubmissionModel {
  final String questionnaireId;
  final String questionnaireName;
  final Map<int, int> answers; // questionIndex -> answerIndex
  final DateTime submittedAt;
  final double? latitude;
  final double? longitude;

  SubmissionModel({
    required this.questionnaireId,
    required this.questionnaireName,
    required this.answers,
    required this.submittedAt,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() => {
        'questionnaireId': questionnaireId,
        'questionnaireName': questionnaireName,
        'answers': answers.map((k, v) => MapEntry(k.toString(), v)),
        'submittedAt': submittedAt.toIso8601String(),
        'latitude': latitude,
        'longitude': longitude,
      };

  factory SubmissionModel.fromJson(Map<String, dynamic> json) => SubmissionModel(
        questionnaireId: json['questionnaireId'] as String,
        questionnaireName: json['questionnaireName'] as String,
        answers: (json['answers'] as Map<String, dynamic>)
            .map((k, v) => MapEntry(int.parse(k), v as int)),
        submittedAt: DateTime.parse(json['submittedAt'] as String),
        latitude: json['latitude'] as double?,
        longitude: json['longitude'] as double?,
      );

  String get formattedDate {
    final d = submittedAt;
    final month = _monthName(d.month);
    final hour = d.hour.toString().padLeft(2, '0');
    final min = d.minute.toString().padLeft(2, '0');
    return '${d.day} $month ${d.year} · $hour:$min';
  }

  String _monthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }
}
