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
        backgroundColor: Colors.blue.shade700,
        elevation: 4,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.15,
            child: Image.asset(
              'assets/images/bg.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings_input_component, size: 64, color: Colors.blue.shade700),
                        const SizedBox(height: 32),
                        Text('Choose your engine type',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.bold,
                                )),
                        const SizedBox(height: 32),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          icon: const Icon(Icons.directions_car),
                          label: const Text('Four Stroke', style: TextStyle(fontSize: 20)),
                          onPressed: () => _selectEngineType(context, 'Four Stroke'),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          icon: const Icon(Icons.motorcycle),
                          label: const Text('Two Stroke', style: TextStyle(fontSize: 20)),
                          onPressed: () => _selectEngineType(context, 'Two Stroke'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 