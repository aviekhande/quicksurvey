/// Application-wide string constants and route names.
class AppStrings {
  static const String kAppTitle = 'Questionnaire';
  static const String kTagline = 'Insights at your fingertips';
  static const String kRegister = 'Register';
  static const String kLogin = 'Login';
  static const String kLogout = 'Logout';
  static const String kPhone = 'Phone Number';
  static const String kPassword = 'Password';
  static const String kConfirmPassword = 'Confirm Password';
  static const String kCreateAccount = 'Create Account';
  static const String kHome = 'Surveys';
  static const String kProfile = 'Profile';
  static const String kSubmit = 'Submit Survey';
  static const String kSubmitSuccess = 'Survey submitted successfully!';
  static const String kAnswerAll = 'Please answer all questions to continue.';
}

/// Named route constants used by GetX navigation.
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String questionnaire = '/questionnaire';
  static const String profile = '/profile';
}

/// Hive box and key names for local storage.
class StorageKeys {
  static const String userBox = 'user_box_v2';
  static const String submissionsBox = 'submissions_box_v2';
  static const String userKey = 'current_user';
  static const String usersListKey = 'registered_users';
}
