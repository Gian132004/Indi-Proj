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
      debugShowCheckedModeBanner: false, // Hide debug banner for polish
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade700,
          primary: Colors.blue.shade700,
          secondary: Colors.orange.shade600,
          background: Colors.white,
        ),
        useMaterial3: true, // Ensure Material 3
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.white,
        cardTheme: CardThemeData(
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: 8,
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          elevation: 6,
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        dividerTheme: DividerThemeData(
          color: Colors.blueGrey.shade100,
          thickness: 2.5,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF5F7FA),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.blue.shade100),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.blue.shade700),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.blue.shade700,
          contentTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
