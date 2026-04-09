import 'questionnaire_model.dart';

/// Provides a static list of mock questionnaires, simulating a remote API.
/// Replace with real HTTP calls when a backend is available.
class MockQuestionnaireService {
  /// Returns all available questionnaires. Each has exactly 5 MCQ questions.
  static List<QuestionnaireModel> getQuestionnaires() {
    return [
      QuestionnaireModel(
        id: 'q1',
        title: 'Customer Satisfaction',
        description: 'Help us improve our services by answering a few quick questions.',
        category: 'Service',
        questions: [
          const Question(text: 'How satisfied are you with our overall service?', options: [
            QuestionOption(text: 'Very Satisfied'),
            QuestionOption(text: 'Satisfied'),
            QuestionOption(text: 'Neutral'),
            QuestionOption(text: 'Dissatisfied'),
          ]),
          const Question(text: 'How would you rate the quality of our product?', options: [
            QuestionOption(text: 'Excellent'),
            QuestionOption(text: 'Good'),
            QuestionOption(text: 'Average'),
            QuestionOption(text: 'Poor'),
          ]),
          const Question(text: 'How likely are you to recommend us to a friend?', options: [
            QuestionOption(text: 'Very Likely'),
            QuestionOption(text: 'Likely'),
            QuestionOption(text: 'Unlikely'),
            QuestionOption(text: 'Very Unlikely'),
          ]),
          const Question(text: 'How was your experience with our support team?', options: [
            QuestionOption(text: 'Outstanding'),
            QuestionOption(text: 'Good'),
            QuestionOption(text: 'Needs Improvement'),
            QuestionOption(text: 'Poor'),
          ]),
          const Question(text: 'Would you use our services again?', options: [
            QuestionOption(text: 'Definitely Yes'),
            QuestionOption(text: 'Probably Yes'),
            QuestionOption(text: 'Probably No'),
            QuestionOption(text: 'Definitely No'),
          ]),
        ],
      ),
      QuestionnaireModel(
        id: 'q2',
        title: 'Employee Engagement',
        description: 'Share your thoughts on workplace culture and environment.',
        category: 'Workplace',
        questions: [
          const Question(text: 'How would you describe your work-life balance?', options: [
            QuestionOption(text: 'Excellent'),
            QuestionOption(text: 'Good'),
            QuestionOption(text: 'Fair'),
            QuestionOption(text: 'Poor'),
          ]),
          const Question(text: 'Do you feel your contributions are recognized?', options: [
            QuestionOption(text: 'Always'),
            QuestionOption(text: 'Often'),
            QuestionOption(text: 'Rarely'),
            QuestionOption(text: 'Never'),
          ]),
          const Question(text: 'How effective is communication within your team?', options: [
            QuestionOption(text: 'Very Effective'),
            QuestionOption(text: 'Effective'),
            QuestionOption(text: 'Somewhat Effective'),
            QuestionOption(text: 'Ineffective'),
          ]),
          const Question(text: 'Are you satisfied with growth opportunities offered?', options: [
            QuestionOption(text: 'Very Satisfied'),
            QuestionOption(text: 'Satisfied'),
            QuestionOption(text: 'Unsatisfied'),
            QuestionOption(text: 'Very Unsatisfied'),
          ]),
          const Question(text: 'Would you recommend this company as a great place to work?', options: [
            QuestionOption(text: 'Absolutely'),
            QuestionOption(text: 'Yes'),
            QuestionOption(text: 'Not Sure'),
            QuestionOption(text: 'No'),
          ]),
        ],
      ),
      QuestionnaireModel(
        id: 'q3',
        title: 'Product Feedback',
        description: 'Tell us how we can make our product better for you.',
        category: 'Product',
        questions: [
          const Question(text: 'How easy is it to use our app?', options: [
            QuestionOption(text: 'Very Easy'),
            QuestionOption(text: 'Easy'),
            QuestionOption(text: 'Difficult'),
            QuestionOption(text: 'Very Difficult'),
          ]),
          const Question(text: 'Which feature do you use the most?', options: [
            QuestionOption(text: 'Dashboard'),
            QuestionOption(text: 'Reports'),
            QuestionOption(text: 'Notifications'),
            QuestionOption(text: 'Settings'),
          ]),
          const Question(text: 'How would you rate the app performance?', options: [
            QuestionOption(text: 'Blazing Fast'),
            QuestionOption(text: 'Fast'),
            QuestionOption(text: 'Slow'),
            QuestionOption(text: 'Very Slow'),
          ]),
          const Question(text: 'How satisfied are you with the UI design?', options: [
            QuestionOption(text: 'Love It'),
            QuestionOption(text: "It's OK"),
            QuestionOption(text: 'Needs Work'),
            QuestionOption(text: 'Dislike It'),
          ]),
          const Question(text: 'How often do you use this app?', options: [
            QuestionOption(text: 'Daily'),
            QuestionOption(text: 'Weekly'),
            QuestionOption(text: 'Monthly'),
            QuestionOption(text: 'Rarely'),
          ]),
        ],
      ),
      QuestionnaireModel(
        id: 'q4',
        title: 'Health & Wellness',
        description: 'A quick assessment of your daily health habits and lifestyle.',
        category: 'Health',
        questions: [
          const Question(text: 'How many hours of sleep do you get on average?', options: [
            QuestionOption(text: '8+ hours'),
            QuestionOption(text: '6–8 hours'),
            QuestionOption(text: '4–6 hours'),
            QuestionOption(text: 'Less than 4'),
          ]),
          const Question(text: 'How often do you exercise per week?', options: [
            QuestionOption(text: '5+ times'),
            QuestionOption(text: '3–4 times'),
            QuestionOption(text: '1–2 times'),
            QuestionOption(text: 'Never'),
          ]),
          const Question(text: 'How would you rate your diet quality?', options: [
            QuestionOption(text: 'Excellent'),
            QuestionOption(text: 'Good'),
            QuestionOption(text: 'Average'),
            QuestionOption(text: 'Poor'),
          ]),
          const Question(text: 'How often do you experience stress at work?', options: [
            QuestionOption(text: 'Rarely'),
            QuestionOption(text: 'Sometimes'),
            QuestionOption(text: 'Often'),
            QuestionOption(text: 'Always'),
          ]),
          const Question(text: 'Do you take regular breaks during work hours?', options: [
            QuestionOption(text: 'Always'),
            QuestionOption(text: 'Usually'),
            QuestionOption(text: 'Rarely'),
            QuestionOption(text: 'Never'),
          ]),
        ],
      ),
      QuestionnaireModel(
        id: 'q5',
        title: 'Tech Adoption Survey',
        description: 'Help us understand how you interact with new technologies.',
        category: 'Technology',
        questions: [
          const Question(text: 'How comfortable are you with adopting new technology?', options: [
            QuestionOption(text: 'Very Comfortable'),
            QuestionOption(text: 'Comfortable'),
            QuestionOption(text: 'Uncomfortable'),
            QuestionOption(text: 'Very Uncomfortable'),
          ]),
          const Question(text: 'Which device do you primarily use for work?', options: [
            QuestionOption(text: 'Smartphone'),
            QuestionOption(text: 'Laptop'),
            QuestionOption(text: 'Tablet'),
            QuestionOption(text: 'Desktop'),
          ]),
          const Question(text: 'How often do you update your apps/software?', options: [
            QuestionOption(text: 'Immediately'),
            QuestionOption(text: 'Within a week'),
            QuestionOption(text: 'After a month'),
            QuestionOption(text: 'Never'),
          ]),
          const Question(text: 'How do you prefer to learn new tools?', options: [
            QuestionOption(text: 'Video tutorials'),
            QuestionOption(text: 'Documentation'),
            QuestionOption(text: 'Trial & error'),
            QuestionOption(text: 'Ask colleagues'),
          ]),
          const Question(text: 'How important is data privacy to you when using apps?', options: [
            QuestionOption(text: 'Extremely Important'),
            QuestionOption(text: 'Important'),
            QuestionOption(text: 'Somewhat Important'),
            QuestionOption(text: 'Not Important'),
          ]),
        ],
      ),
    ];
  }
}
