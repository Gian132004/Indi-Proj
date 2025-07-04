import 'package:flutter/material.dart';
import 'pages/landing_page.dart';
import 'pages/menu_page.dart';
import 'pages/input_page.dart';
import 'pages/result_page.dart';
import 'pages/compression_calculator_page.dart';
import 'pages/top_speed_calculator_page.dart';
// (Compression and Top Speed calculator imports will be added later)

void main() {
  runApp(const EngineCalcApp());
}

class EngineCalcApp extends StatelessWidget {
  const EngineCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Engine Displacement Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/menu': (context) => const MenuPage(),
        '/cc_input': (context) => const InputPage(),
        '/result': (context) => const ResultPage(),
        '/compression': (context) => const CompressionCalculatorPage(),
        '/top_speed': (context) => const TopSpeedCalculatorPage(),
      },
    );
  }
}
