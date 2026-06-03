import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String countKey = "count";

  static Future<void> saveCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(countKey, count);
  }

  static Future<int> loadCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(countKey) ?? 0;
  }
}