import 'package:flutter/material.dart';
import 'pages/landing_page.dart';
import 'pages/menu_page.dart';
import 'pages/input_page.dart';
import 'pages/result_page.dart';
import 'pages/compression_calculator_page.dart';
import 'pages/top_speed_calculator_page.dart';
import 'package:google_fonts/google_fonts.dart';
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade700,
          primary: Colors.blue.shade700,
          secondary: Colors.orange.shade600,
          background: Colors.white,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.white,
        cardTheme: CardThemeData(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 6,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          elevation: 4,
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        dividerTheme: DividerThemeData(
          color: Colors.blueGrey.shade100,
          thickness: 2,
        ),
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
