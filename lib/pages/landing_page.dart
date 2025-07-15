import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  void _selectEngineType(BuildContext context, String type) {
    Navigator.pushNamed(context, '/menu', arguments: {'engineType': type});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Engine Type'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.blue.shade700,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
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
          AnimatedOpacity(
            opacity: 0.18,
            duration: Duration(seconds: 1),
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
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 220,
                        height: 220,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings_input_component, size: 64, color: Colors.blue.shade700),
                        const SizedBox(height: 32),
                        Text('Choose your engine type',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.1,
                                )),
                        const SizedBox(height: 32),
                        Tooltip(
                          message: 'Standard 4-stroke engine (most motorcycles/cars)',
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade700,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 60),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                            ),
                            icon: const Icon(Icons.directions_car),
                            label: const Text('Four Stroke', style: TextStyle(fontSize: 22)),
                            onPressed: () => _selectEngineType(context, 'Four Stroke'),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Tooltip(
                          message: '2-stroke engine (some motorcycles, small engines)',
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.shade700,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 60),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                            ),
                            icon: const Icon(Icons.motorcycle),
                            label: const Text('Two Stroke', style: TextStyle(fontSize: 22)),
                            onPressed: () => _selectEngineType(context, 'Two Stroke'),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Get started by selecting your engine type. You can calculate engine displacement, compression ratio, and top speed with recommendations.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.blueGrey.shade700,
                                fontSize: 16,
                              ),
                        ),
                        const SizedBox(height: 24),
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