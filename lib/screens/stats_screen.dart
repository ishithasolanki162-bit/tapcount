import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  final int streak;
  final int totalTaps;
  final int longestStreak;
  final int goalsCompleted;


  const StatsScreen({
    super.key,
    required this.streak,
    required this.totalTaps,
    required this.longestStreak,
    required this.goalsCompleted,
  });

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Statistics"),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.touch_app),
              title: const Text("Total Taps"),
              trailing: Text("$totalTaps"),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.local_fire_department),
              title: const Text("Current Streak"),
              trailing: Text("$streak"),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.emoji_events),
              title: const Text("Longest Streak"),
              trailing: Text("$longestStreak"),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text("Goals Completed"),
              trailing: Text("$goalsCompleted"),
            ),
          ),
        ],
      ),
    ),
  );
}
}
