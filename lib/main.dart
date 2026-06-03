import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TapCountApp());
}

class TapCountApp extends StatelessWidget {
  const TapCountApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TapCount',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}