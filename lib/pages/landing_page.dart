import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'menu_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  void _selectEngineType(BuildContext context, String type) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const MenuPageWrapper(),
      settings: RouteSettings(arguments: {'engineType': type}),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Select Engine Type', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
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
                                blurRadius: 32,
                                offset: const Offset(0, 12),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 130,
                              height: 130,
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
                        Icon(Icons.settings_input_component, size: 40, color: Colors.blue.shade800),
                        const SizedBox(height: 36),
                        Text(
                          'Choose your engine type',
                          style: GoogleFonts.poppins(
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 36),
                        Tooltip(
                          message: 'Standard 4-stroke engine (most motorcycles/cars)',
                          child: AnimatedScale(
                            scale: 1.0,
                            duration: const Duration(milliseconds: 150),
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
                              icon: const Icon(Icons.directions_car, size: 22),
                              label: const Text('Four Stroke', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                              onPressed: () => _selectEngineType(context, 'Four Stroke'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Tooltip(
                          message: '2-stroke engine (some motorcycles, small engines)',
                          child: AnimatedScale(
                            scale: 1.0,
                            duration: const Duration(milliseconds: 150),
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
                              icon: const Icon(Icons.motorcycle, size: 22),
                              label: const Text('Two Stroke', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                              onPressed: () => _selectEngineType(context, 'Two Stroke'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 44),
                        Text(
                          'Get started by selecting your engine type. You can calculate engine displacement, compression ratio, and top speed with recommendations.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.blueGrey.shade700,
                            fontSize: 14,
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

// Wrapper for MenuPage to support custom transition
class MenuPageWrapper extends StatelessWidget {
  const MenuPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    return MenuPage(key: key);
  }
} 