import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  final int totalTaps;
  final int streak;
  final int goalsCompleted;

  const AchievementsScreen({
    super.key,
    required this.totalTaps,
    required this.streak,
    required this.goalsCompleted,
  });

  Widget achievementTile(
    String title,
    String subtitle,
    bool unlocked,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(
          unlocked ? Icons.emoji_events : Icons.lock,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(
          unlocked ? 'Unlocked' : 'Locked',
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Achievements"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          achievementTile(
            "🥉 First Goal",
            "Complete your first goal",
            goalsCompleted >= 1,
          ),

          achievementTile(
            "🥈 Dedicated",
            "Complete 10 goals",
            goalsCompleted >= 10,
          ),

          achievementTile(
            "🥇 Tap Master",
            "Reach 1000 total taps",
            totalTaps >= 1000,
          ),

          achievementTile(
            "🔥 Streak Warrior",
            "Reach a 7 day streak",
            streak >= 7,
          ),
        ],
      ),
    );
  }
}