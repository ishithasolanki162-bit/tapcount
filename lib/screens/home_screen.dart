import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import '../services/storage_service.dart';

class HomeScreen extends StatefulWidget {
const HomeScreen({super.key});

@override
State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int count = 0;
int goal = 108;

@override
void initState() {
super.initState();
loadData();
}

Future<void> loadData() async {
count = await StorageService.loadCount();
goal = await StorageService.loadGoal();
setState(() {});
}

Future<void> increment() async {
count++;

if (await Vibration.hasVibrator()) {
  Vibration.vibrate(duration: 30);
}

await StorageService.saveCount(count);

setState(() {});

}

Future<void> decrement() async {
if (count > 0) {
count--;
await StorageService.saveCount(count);
setState(() {});
}
}

Future<void> resetCounter() async {
count = 0;
await StorageService.saveCount(count);
setState(() {});
}

Future<void> setGoal() async {
final controller = TextEditingController(
text: goal.toString(),
);

await showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text("Set Goal"),
    content: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: "Enter goal",
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Cancel"),
      ),
      TextButton(
        onPressed: () {
          final value =
              int.tryParse(controller.text);

          if (value != null && value > 0) {
            setState(() {
              goal = value;
            });
            StorageService.saveGoal(goal);
          }

          Navigator.pop(context);
        },
        child: const Text("Save"),
      ),
    ],
  ),
);

}

@override
Widget build(BuildContext context) {
double progress =
(count / goal).clamp(0.0, 1.0);

return Scaffold(
  body: GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: increment,
    child: SafeArea(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          const Text(
            "TapCount",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 40),

          Text(
            "$count",
            style: const TextStyle(
              fontSize: 90,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Text(
                "Goal: $goal",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),

              IconButton(
                onPressed: setGoal,
                icon: const Icon(Icons.edit),
              ),
            ],
          ),

          Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "${(progress * 100).toInt()}%",
            style: const TextStyle(
              fontSize: 18,
            ),
          ),

          if (count >= goal)
            const Padding(
              padding:
                  EdgeInsets.only(top: 10),
              child: Text(
                "🎉 Goal Reached!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),

          const SizedBox(height: 30),

          const Text(
            "Tap Anywhere",
            style: TextStyle(
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 50),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: decrement,
                child: const Text("-1"),
              ),

              ElevatedButton(
                onPressed: resetCounter,
                child: const Text("Reset"),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);

}
}