import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
      if (count == goal) {
        Vibration.vibrate(duration: 300);
      } else {
        Vibration.vibrate(duration: 30);
      }
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

    bool goalReached = count >= goal;

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
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: goalReached
                          ? Colors.greenAccent
                              .withValues(alpha: 0.4)
                          : Colors.blueAccent
                              .withValues(alpha: 0.3),
                      blurRadius: 25,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: CircularPercentIndicator(
                  radius: 120,
                  lineWidth: 14,
                  percent: progress,
                  animation: true,
                  animationDuration: 500,
                  animateFromLastPercent: true,
                  circularStrokeCap:
                      CircularStrokeCap.round,
                  backgroundColor:
                      Colors.white12,
                  progressColor: goalReached
                      ? Colors.greenAccent
                      : Colors.blueAccent,
                  center: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text(
                        "$count",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight:
                              FontWeight.bold,
                          color: goalReached
                              ? const Color.fromARGB(255, 47, 223, 56)
                              : Colors.blueAccent,
                          shadows: [
                            Shadow(
                              blurRadius:
                                  goalReached
                                      ? 20
                                      : 8,
                              color: goalReached
                                  ? const Color.fromARGB(255, 47, 223, 56)
                                  : Colors
                                      .blueAccent,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "/ $goal",
                        style:
                            const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Text(
                    "Goal: $goal",
                    style:
                        const TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: setGoal,
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                ],
              ),

              if (goalReached)
                const Padding(
                  padding:
                      EdgeInsets.only(
                    top: 10,
                  ),
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
                    MainAxisAlignment
                        .spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: decrement,
                    icon: const Icon(
                      Icons.remove,
                    ),
                    label: const Text(
                      "Minus",
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed:
                        resetCounter,
                    icon: const Icon(
                      Icons.refresh,
                    ),
                    label: const Text(
                      "Reset",
                    ),
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