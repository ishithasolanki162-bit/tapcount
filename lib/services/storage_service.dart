import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String countKey = "count";
  static const String goalKey = "goal";

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
}