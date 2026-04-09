import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/auth/models/user_model.dart';
import '../../features/questionnaire/models/submission_model.dart';
import '../constants/app_constants.dart';

/// Manages all offline persistence using Hive boxes.
/// Survives app restarts and logout/login cycles.
class LocalStorageService {
  static late Box _userBox;
  static late Box _submissionsBox;

  /// Initialises Hive and opens both boxes. Called once in main().
  static Future<void> init() async {
    await Hive.initFlutter();
    _userBox = await Hive.openBox(StorageKeys.userBox);
    _submissionsBox = await Hive.openBox(StorageKeys.submissionsBox);
  }

  // ── Auth helpers ──────────────────────────────────────────────────────────

  /// Persists the logged-in user to disk.
  static Future<void> saveCurrentUser(UserModel user) async {
    await _userBox.put(StorageKeys.userKey, jsonEncode(user.toJson()));
  }

  /// Returns the currently logged-in [UserModel], or null if not logged in.
  static UserModel? getCurrentUser() {
    final raw = _userBox.get(StorageKeys.userKey);
    if (raw == null) return null;
    return UserModel.fromJson(jsonDecode(raw as String));
  }

  /// Removes the current user session from local storage.
  static Future<void> clearCurrentUser() async {
    await _userBox.delete(StorageKeys.userKey);
  }

  /// Returns true if a valid user session is stored locally.
  static bool isLoggedIn() => _userBox.containsKey(StorageKeys.userKey);

  // ── Registration store ────────────────────────────────────────────────────

  /// Saves a newly registered user keyed by phone number.
  static Future<void> registerUser(UserModel user) async {
    final existing = getAllRegisteredUsers();
    existing[user.phone] = user;
    final encoded = existing.map((k, v) => MapEntry(k, jsonEncode(v.toJson())));
    await _userBox.put(StorageKeys.usersListKey, jsonEncode(encoded));
  }

  /// Returns all registered users as a phone → UserModel map.
  static Map<String, UserModel> getAllRegisteredUsers() {
    final raw = _userBox.get(StorageKeys.usersListKey);
    if (raw == null) return {};
    final decoded = jsonDecode(raw as String) as Map<String, dynamic>;
    return decoded.map(
      (k, v) => MapEntry(k, UserModel.fromJson(jsonDecode(v as String))),
    );
  }

  /// Returns true if the given phone number is already registered.
  static bool phoneExists(String phone) =>
      getAllRegisteredUsers().containsKey(phone);

  /// Looks up a user by phone number, returns null if not found.
  static UserModel? getUserByPhone(String phone) =>
      getAllRegisteredUsers()[phone];

  // ── Submission store ──────────────────────────────────────────────────────

  /// Appends a new [SubmissionModel] for the given phone number.
  static Future<void> saveSubmission(
    String userPhone,
    SubmissionModel submission,
  ) async {
    final key = 'submissions_$userPhone';
    final existing = getSubmissionsForUser(userPhone);
    existing.add(submission);
    final encoded = existing.map((s) => jsonEncode(s.toJson())).toList();
    await _submissionsBox.put(key, jsonEncode(encoded));
  }

  /// Returns all submissions for the given phone, newest first.
  static List<SubmissionModel> getSubmissionsForUser(String userPhone) {
    final key = 'submissions_$userPhone';
    final raw = _submissionsBox.get(key);
    if (raw == null) return [];
    final list = jsonDecode(raw as String) as List<dynamic>;
    return list
        .map((item) => SubmissionModel.fromJson(jsonDecode(item as String)))
        .toList();
  }

  /// Returns the total count of submissions for the given phone.
  static int getSubmissionCountForUser(String userPhone) =>
      getSubmissionsForUser(userPhone).length;
}
