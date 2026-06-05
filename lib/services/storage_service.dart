import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String countKey = "count";
  static const String goalKey = "goal";
  static const String streakKey = "streak";
  static const String lastCompletedDateKey = "lastCompletedDate";
  static const String totalTapsKey = "totalTaps";
  static const String longestStreakKey = "longestStreak";
  static const String goalsCompletedKey = "goalsCompleted";

  static Future<void> saveCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(countKey, count);
  }

  static Future<int> loadCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(countKey) ?? 0;
  }

  static Future<void> saveGoal(int goal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(goalKey, goal);
  }

  static Future<int> loadGoal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(goalKey) ?? 108;
  }

  static Future<void> saveStreak(int streak) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(streakKey, streak);
  }

  static Future<int> loadStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(streakKey) ?? 0;
  }

  static Future<void> saveLastCompletedDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(lastCompletedDateKey, date.toIso8601String());
  }

  static Future<String?> loadLastCompletedDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastCompletedDateKey);
  }

  static Future<void> saveTotalTaps(int total ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(totalTapsKey, total);
  }

  static Future<int> loadTotalTaps() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(totalTapsKey) ?? 0;
  }

  static Future<void> saveLongestStreak(int streak) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(longestStreakKey,  streak);
  }

  static Future<int> loadLongestStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(longestStreakKey) ?? 0;
  }

  static Future<void> saveGoalsCompleted(int goals) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(goalsCompletedKey, goals);
  }

  static Future<int> loadGoalsCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(goalsCompletedKey) ?? 0;
  }
}