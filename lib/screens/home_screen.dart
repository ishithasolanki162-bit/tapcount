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

  @override
  void initState() {
    super.initState();
    loadCount();
  }

  Future<void> loadCount() async {
    count = await StorageService.loadCount();
    setState(() {});
  }

  Future<void> increment() async {
    count++;

    if (await Vibration.hasVibrator() ) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: increment,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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

              const Text(
                "Tap Anywhere",
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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