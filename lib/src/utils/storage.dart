// src/utils/storage.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import '../data/models/user_model.dart';
import '../data/models/task_model.dart';
import 'hive_adapter.dart';
import 'constants.dart';

class Storage {
  static late SharedPreferences _prefs;

  // Key constants
  static const String KEY_AUTH_TOKEN = 'auth_token';
  static const String KEY_ONBOARDED = 'has_onboarded';
  static const String KEY_DARK_MODE = 'dark_mode';
  static const String KEY_OTP_EMAIL = 'otp_email';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await HiveAdapter.init();
  }

  // === SharedPreferences Methods ===
  static Future<void> saveToken(String token) async {
    await _prefs.setString(KEY_AUTH_TOKEN, token);
  }

  static String? getToken() {
    return _prefs.getString(KEY_AUTH_TOKEN);
  }

  static Future<void> setOnboarded() async {
    await _prefs.setBool(KEY_ONBOARDED, true);
  }

  static bool hasOnboarded() {
    return _prefs.getBool(KEY_ONBOARDED) ?? false;
  }

  static Future<void> setDarkMode(bool isDark) async {
    await _prefs.setBool(KEY_DARK_MODE, isDark);
  }

  static bool isDarkMode() {
    return _prefs.getBool(KEY_DARK_MODE) ?? false;
  }

  // === OTP Email Persistence ===
  static Future<void> saveOtpEmail(String email) async {
    await _prefs.setString(KEY_OTP_EMAIL, email);
  }

  static String? getOtpEmail() {
    return _prefs.getString(KEY_OTP_EMAIL);
  }

  static Future<void> removeOtpEmail() async {
    await _prefs.remove(KEY_OTP_EMAIL);
  }

  // === Hive Methods ===
  static Future<void> saveUser(UserModel user) async {
    final box = await HiveAdapter.openBox<UserModel>(HiveBoxes.userBox);
    await box.put('current', user);
  }

  static UserModel? getUser() {
    if (!Hive.isBoxOpen(HiveBoxes.userBox)) return null;
    final box = Hive.box<UserModel>(HiveBoxes.userBox);
    return box.get('current');
  }

  static Future<void> saveTasks(List<TaskModel> tasks) async {
    final box = await HiveAdapter.openBox<TaskModel>(HiveBoxes.taskBox);
    await box.clear();
    for (var task in tasks) {
      await box.put(task.id, task);
    }
  }

  static List<TaskModel> getTasks() {
    if (!Hive.isBoxOpen(HiveBoxes.taskBox)) return [];
    final box = Hive.box<TaskModel>(HiveBoxes.taskBox);
    return box.values.toList();
  }

  static Future<void> addTask(TaskModel task) async {
    final box = await HiveAdapter.openBox<TaskModel>(HiveBoxes.taskBox);
    await box.put(task.id, task);
  }

  static Future<void> updateTask(TaskModel task) async {
    final box = await HiveAdapter.openBox<TaskModel>(HiveBoxes.taskBox);
    await box.put(task.id, task);
  }

  static Future<void> deleteTask(String taskId) async {
    final box = await HiveAdapter.openBox<TaskModel>(HiveBoxes.taskBox);
    await box.delete(taskId);
  }

  // === Clear All Data ===
  static Future<void> clear() async {
    await _prefs.clear();

    if (Hive.isBoxOpen(HiveBoxes.userBox)) {
      await Hive.box(HiveBoxes.userBox).clear();
    }
    if (Hive.isBoxOpen(HiveBoxes.taskBox)) {
      await Hive.box(HiveBoxes.taskBox).clear();
    }
  }
}
