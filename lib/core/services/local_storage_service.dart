import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/auth/models/user_model.dart';
import '../../features/questionnaire/models/submission_model.dart';
import '../constants/storage_keys.dart';

class LocalStorageService {
  static late Box _userBox;
  static late Box _submissionsBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    _userBox = await Hive.openBox(StorageKeys.userBox);
    _submissionsBox = await Hive.openBox(StorageKeys.submissionsBox);
  }

  // ─── Auth ────────────────────────────────────────────────────────────────

  static Future<void> saveCurrentUser(UserModel user) async {
    await _userBox.put(StorageKeys.userKey, jsonEncode(user.toJson()));
  }

  static UserModel? getCurrentUser() {
    final raw = _userBox.get(StorageKeys.userKey);
    if (raw == null) return null;
    return UserModel.fromJson(jsonDecode(raw as String));
  }

  static Future<void> clearCurrentUser() async {
    await _userBox.delete(StorageKeys.userKey);
  }

  static bool isLoggedIn() => _userBox.containsKey(StorageKeys.userKey);

  // ─── Registered users ────────────────────────────────────────────────────

  static Future<void> registerUser(UserModel user) async {
    final existing = getAllRegisteredUsers();
    existing[user.phone] = user;
    final encoded = existing.map((k, v) => MapEntry(k, jsonEncode(v.toJson())));
    await _userBox.put(StorageKeys.usersListKey, jsonEncode(encoded));
  }

  static Map<String, UserModel> getAllRegisteredUsers() {
    final raw = _userBox.get(StorageKeys.usersListKey);
    if (raw == null) return {};
    final decoded = jsonDecode(raw as String) as Map<String, dynamic>;
    return decoded.map(
      (k, v) => MapEntry(k, UserModel.fromJson(jsonDecode(v as String))),
    );
  }

  static bool phoneExists(String phone) {
    return getAllRegisteredUsers().containsKey(phone);
  }

  static UserModel? getUserByPhone(String phone) {
    return getAllRegisteredUsers()[phone];
  }

  // ─── Submissions ─────────────────────────────────────────────────────────

  /// Key: phone → List<SubmissionModel JSON>
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

  static List<SubmissionModel> getSubmissionsForUser(String userPhone) {
    final key = 'submissions_$userPhone';
    final raw = _submissionsBox.get(key);
    if (raw == null) return [];
    final list = jsonDecode(raw as String) as List<dynamic>;
    return list
        .map((item) => SubmissionModel.fromJson(jsonDecode(item as String)))
        .toList();
  }

  static int getSubmissionCountForUser(String userPhone) {
    return getSubmissionsForUser(userPhone).length;
  }
}
