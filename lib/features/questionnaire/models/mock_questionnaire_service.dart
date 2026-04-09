import '../models/questionnaire_model.dart';

class MockQuestionnaireService {
  static List<QuestionnaireModel> getQuestionnaires() {
    return [
      QuestionnaireModel(
        id: 'q1',
        title: 'Customer Satisfaction Survey',
        description: 'Help us improve our services by answering a few quick questions.',
        questions: [
          Question(
            text: 'How satisfied are you with our overall service?',
            options: [
              QuestionOption(text: 'Very Satisfied'),
              QuestionOption(text: 'Satisfied'),
              QuestionOption(text: 'Neutral'),
              QuestionOption(text: 'Dissatisfied'),
            ],
          ),
          Question(
            text: 'How would you rate the quality of our product?',
            options: [
              QuestionOption(text: 'Excellent'),
              QuestionOption(text: 'Good'),
              QuestionOption(text: 'Average'),
              QuestionOption(text: 'Poor'),
            ],
          ),
          Question(
            text: 'How likely are you to recommend us to a friend?',
            options: [
              QuestionOption(text: 'Very Likely'),
              QuestionOption(text: 'Likely'),
              QuestionOption(text: 'Unlikely'),
              QuestionOption(text: 'Very Unlikely'),
            ],
          ),
          Question(
            text: 'How was your experience with our support team?',
            options: [
              QuestionOption(text: 'Outstanding'),
              QuestionOption(text: 'Good'),
              QuestionOption(text: 'Needs Improvement'),
            ],
          ),
          Question(
            text: 'Would you use our services again?',
            options: [
              QuestionOption(text: 'Definitely Yes'),
              QuestionOption(text: 'Probably Yes'),
              QuestionOption(text: 'Probably No'),
              QuestionOption(text: 'Definitely No'),
            ],
          ),
        ],
      ),
      QuestionnaireModel(
        id: 'q2',
        title: 'Employee Engagement Survey',
        description: 'Share your thoughts on workplace culture and environment.',
        questions: [
          Question(
            text: 'How would you describe your work-life balance?',
            options: [
              QuestionOption(text: 'Excellent'),
              QuestionOption(text: 'Good'),
              QuestionOption(text: 'Fair'),
              QuestionOption(text: 'Poor'),
            ],
          ),
          Question(
            text: 'Do you feel your contributions are recognized?',
            options: [
              QuestionOption(text: 'Always'),
              QuestionOption(text: 'Often'),
              QuestionOption(text: 'Rarely'),
              QuestionOption(text: 'Never'),
            ],
          ),
          Question(
            text: 'How effective is communication within your team?',
            options: [
              QuestionOption(text: 'Very Effective'),
              QuestionOption(text: 'Effective'),
              QuestionOption(text: 'Somewhat Effective'),
              QuestionOption(text: 'Ineffective'),
            ],
          ),
          Question(
            text: 'Are you satisfied with the growth opportunities offered?',
            options: [
              QuestionOption(text: 'Very Satisfied'),
              QuestionOption(text: 'Satisfied'),
              QuestionOption(text: 'Unsatisfied'),
            ],
          ),
          Question(
            text: 'Would you recommend this company as a great place to work?',
            options: [
              QuestionOption(text: 'Absolutely'),
              QuestionOption(text: 'Yes'),
              QuestionOption(text: 'Not Sure'),
              QuestionOption(text: 'No'),
            ],
          ),
        ],
      ),
      QuestionnaireModel(
        id: 'q3',
        title: 'Product Feedback Form',
        description: 'Tell us how we can make our product better for you.',
        questions: [
          Question(
            text: 'How easy is it to use our app?',
            options: [
              QuestionOption(text: 'Very Easy'),
              QuestionOption(text: 'Easy'),
              QuestionOption(text: 'Difficult'),
              QuestionOption(text: 'Very Difficult'),
            ],
          ),
          Question(
            text: 'Which feature do you use the most?',
            options: [
              QuestionOption(text: 'Dashboard'),
              QuestionOption(text: 'Reports'),
              QuestionOption(text: 'Notifications'),
              QuestionOption(text: 'Settings'),
            ],
          ),
          Question(
            text: 'How would you rate the app performance?',
            options: [
              QuestionOption(text: 'Blazing Fast'),
              QuestionOption(text: 'Fast'),
              QuestionOption(text: 'Slow'),
              QuestionOption(text: 'Very Slow'),
            ],
          ),
          Question(
            text: 'How satisfied are you with the UI design?',
            options: [
              QuestionOption(text: 'Love it'),
              QuestionOption(text: 'It\'s OK'),
              QuestionOption(text: 'Needs Work'),
            ],
          ),
          Question(
            text: 'How often do you use this app?',
            options: [
              QuestionOption(text: 'Daily'),
              QuestionOption(text: 'Weekly'),
              QuestionOption(text: 'Monthly'),
              QuestionOption(text: 'Rarely'),
            ],
          ),
        ],
      ),
      QuestionnaireModel(
        id: 'q4',
        title: 'Health & Wellness Check',
        description: 'A quick assessment of your daily health habits and lifestyle.',
        questions: [
          Question(
            text: 'How many hours of sleep do you get on average?',
            options: [
              QuestionOption(text: '8+ hours'),
              QuestionOption(text: '6–8 hours'),
              QuestionOption(text: '4–6 hours'),
              QuestionOption(text: 'Less than 4'),
            ],
          ),
          Question(
            text: 'How often do you exercise per week?',
            options: [
              QuestionOption(text: '5+ times'),
              QuestionOption(text: '3–4 times'),
              QuestionOption(text: '1–2 times'),
              QuestionOption(text: 'Never'),
            ],
          ),
          Question(
            text: 'How would you rate your diet quality?',
            options: [
              QuestionOption(text: 'Excellent'),
              QuestionOption(text: 'Good'),
              QuestionOption(text: 'Average'),
              QuestionOption(text: 'Poor'),
            ],
          ),
          Question(
            text: 'How often do you experience stress at work?',
            options: [
              QuestionOption(text: 'Rarely'),
              QuestionOption(text: 'Sometimes'),
              QuestionOption(text: 'Often'),
              QuestionOption(text: 'Always'),
            ],
          ),
          Question(
            text: 'Do you take regular breaks during work hours?',
            options: [
              QuestionOption(text: 'Always'),
              QuestionOption(text: 'Usually'),
              QuestionOption(text: 'Rarely'),
              QuestionOption(text: 'Never'),
            ],
          ),
        ],
      ),
      QuestionnaireModel(
        id: 'q5',
        title: 'Technology Adoption Survey',
        description: 'Help us understand how you interact with new technologies.',
        questions: [
          Question(
            text: 'How comfortable are you with adopting new technology?',
            options: [
              QuestionOption(text: 'Very Comfortable'),
              QuestionOption(text: 'Comfortable'),
              QuestionOption(text: 'Uncomfortable'),
              QuestionOption(text: 'Very Uncomfortable'),
            ],
          ),
          Question(
            text: 'Which device do you primarily use for work?',
            options: [
              QuestionOption(text: 'Smartphone'),
              QuestionOption(text: 'Laptop'),
              QuestionOption(text: 'Tablet'),
              QuestionOption(text: 'Desktop'),
            ],
          ),
          Question(
            text: 'How often do you update your apps/software?',
            options: [
              QuestionOption(text: 'Immediately'),
              QuestionOption(text: 'Within a week'),
              QuestionOption(text: 'After a month'),
              QuestionOption(text: 'Never'),
            ],
          ),
          Question(
            text: 'How do you prefer to learn new tools?',
            options: [
              QuestionOption(text: 'Video tutorials'),
              QuestionOption(text: 'Documentation'),
              QuestionOption(text: 'Trial & error'),
              QuestionOption(text: 'Ask colleagues'),
            ],
          ),
          Question(
            text: 'How important is data privacy to you when using apps?',
            options: [
              QuestionOption(text: 'Extremely Important'),
              QuestionOption(text: 'Important'),
              QuestionOption(text: 'Somewhat Important'),
              QuestionOption(text: 'Not Important'),
            ],
          ),
        ],
      ),
    ];
  }
}
