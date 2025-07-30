import 'package:flutter/material.dart';
import 'pages/landing_page.dart';
import 'pages/menu_page.dart';
import 'pages/input_page.dart';
import 'pages/result_page.dart';
import 'pages/compression_calculator_page.dart';
import 'pages/compression_result_page.dart';
import 'package:google_fonts/google_fonts.dart';
// (Compression and Top Speed calculator imports will be added later)

void main() {
  runApp(const MotoRunApp());
}

class MotoRunApp extends StatelessWidget {
  const MotoRunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MotoRun',
      debugShowCheckedModeBanner: false, // Hide debug banner for polish
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade800, // More vibrant blue
          primary: Colors.blue.shade800,
          secondary: Colors.lightBlueAccent.shade100,
          background: Colors.white,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          displayLarge: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
          titleLarge: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
          titleMedium: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.blue.shade700,
          ),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.blueGrey.shade900,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.blueGrey.shade800,
          ),
          bodySmall: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.blueGrey.shade700,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        cardTheme: CardThemeData(
          elevation: 20,
          shadowColor: Colors.blue.shade100.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          color: Colors.white.withOpacity(0.55), // Glassmorphism
          margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.blue.shade900;
              }
              return Colors.blue.shade800;
            }),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            textStyle: MaterialStateProperty.all(const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22))),
            elevation: MaterialStateProperty.all(14),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 44, vertical: 22)),
            shadowColor: MaterialStateProperty.all(Colors.blue.shade200),
            overlayColor: MaterialStateProperty.all(Colors.blue.shade100.withOpacity(0.18)),
            animationDuration: const Duration(milliseconds: 200),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade800,
          foregroundColor: Colors.white,
          elevation: 8,
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
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
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.blue.shade100),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.blue.shade800),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.blue.shade800,
          contentTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          
          case '/':
            builder = (context) => const LandingPage();
            break;
          case '/menu':
            builder = (context) => const MenuPage();
            break;
          case '/cc_input':
            builder = (context) => const InputPage();
            break;
          case '/result':
            builder = (context) => const ResultPage();
            break;
          case '/compression':
            builder = (context) => const CompressionCalculatorPage();
            break;
          case '/compression_result':
            builder = (context) => const CompressionResultPage();
            break;
          default:
            builder = (context) => const LandingPage();
        }
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final fade = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            final scale = Tween<double>(begin: 0.98, end: 1.0).animate(fade);
            return FadeTransition(
              opacity: fade,
              child: ScaleTransition(scale: scale, child: child),
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
          settings: settings,
        );
      },
    );
  }
}
