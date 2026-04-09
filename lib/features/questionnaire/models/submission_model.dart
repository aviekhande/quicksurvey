/// Stores a completed questionnaire response with location and timestamp.
class SubmissionModel {
  final String questionnaireId;
  final String questionnaireName;
  final Map<int, int> answers; // questionIndex → selectedOptionIndex
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

  factory SubmissionModel.fromJson(Map<String, dynamic> json) =>
      SubmissionModel(
        questionnaireId: json['questionnaireId'] as String,
        questionnaireName: json['questionnaireName'] as String,
        answers: (json['answers'] as Map<String, dynamic>)
            .map((k, v) => MapEntry(int.parse(k), v as int)),
        submittedAt: DateTime.parse(json['submittedAt'] as String),
        latitude: json['latitude'] as double?,
        longitude: json['longitude'] as double?,
      );

  /// Returns a human-readable date-time string, e.g. "7 Apr 2025 · 14:30".
  String get formattedDate {
    final d = submittedAt;
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final h = d.hour.toString().padLeft(2, '0');
    final m = d.minute.toString().padLeft(2, '0');
    return '${d.day} ${months[d.month]} ${d.year} · $h:$m';
  }

  /// Returns a formatted lat/long string, or null if unavailable.
  String? get locationString {
    if (latitude == null || longitude == null) return null;
    return '${latitude!.toStringAsFixed(5)}, ${longitude!.toStringAsFixed(5)}';
  }

  /// True if location data is available for this submission.
  bool get hasLocation => latitude != null && longitude != null;
}
