import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'input_page.dart';
import 'compression_calculator_page.dart';
import 'top_speed_calculator_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  void _navigate(BuildContext context, String route, String engineType) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => _getPage(route),
      settings: RouteSettings(arguments: {'engineType': engineType}),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    ));
  }

  Widget _getPage(String route) {
    switch (route) {
      case '/cc_input':
        return const InputPage();
      case '/compression':
        return const CompressionCalculatorPage();
      case '/top_speed':
        return const TopSpeedCalculatorPage();
      default:
        return const InputPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final String engineType = args?['engineType'] ?? 'Unknown';

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Engine Tools', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.blue.shade800,
      ),
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFe3f2fd),
                  Color(0xFFbbdefb),
                  Color(0xFF90caf9),
                ],
              ),
            ),
          ),
          // Subtle background image overlay
          AnimatedOpacity(
            opacity: 0.15,
            duration: const Duration(seconds: 1),
            child: Image.asset(
              'assets/images/bg.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 48.0, bottom: 16.0),
                    child: Hero(
                      tag: 'logo',
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade100.withOpacity(0.4),
                                blurRadius: 28,
                                offset: const Offset(0, 10),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 90,
                              height: 90,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings, size: 32, color: Colors.blue.shade800),
                        const SizedBox(height: 20),
                        Text('Selected Engine: $engineType',
                            style: GoogleFonts.poppins(
                              color: Colors.blue.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )),
                        const SizedBox(height: 36),
                        Tooltip(
                          message: 'Calculate engine displacement (cc)',
                          child: AnimatedScale(
                            scale: 1.0,
                            duration: const Duration(milliseconds: 100),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade800,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                elevation: 10,
                                shadowColor: Colors.blue.shade200,
                              ),
                              icon: const Icon(Icons.calculate, size: 20),
                              label: const Text('Engine CC Calculator', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                              onPressed: () => _navigate(context, '/cc_input', engineType),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Tooltip(
                          message: 'Calculate compression ratio (Four Stroke only)',
                          child: AnimatedScale(
                            scale: 1.0,
                            duration: const Duration(milliseconds: 100),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent.shade700,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                elevation: 10,
                                shadowColor: Colors.blue.shade200,
                              ),
                              icon: const Icon(Icons.compress, size: 20),
                              label: const Text('Compression Calculator', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                              onPressed: () => _navigate(context, '/compression', engineType),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Tooltip(
                          message: 'Calculate theoretical top speed (Four Stroke only)',
                          child: AnimatedScale(
                            scale: 1.0,
                            duration: const Duration(milliseconds: 100),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade700,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                elevation: 10,
                                shadowColor: Colors.blue.shade200,
                              ),
                              icon: const Icon(Icons.speed, size: 20),
                              label: const Text('Top Speed Calculator', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                              onPressed: () => _navigate(context, '/top_speed', engineType),
                            ),
                          ),
                        ),
                        const SizedBox(height: 44),
                        Text(
                          'Select a tool to begin calculations or get recommendations for your engine build.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.blueGrey.shade700,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 