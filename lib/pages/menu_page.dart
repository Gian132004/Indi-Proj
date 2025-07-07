import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  void _navigate(BuildContext context, String route, String engineType) {
    Navigator.pushNamed(context, route, arguments: {'engineType': engineType});
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final String engineType = args?['engineType'] ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Engine Tools'),
        backgroundColor: Colors.blue.shade700,
        elevation: 4,
        foregroundColor: Colors.white,
      ),
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
            opacity: 0.15,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings, size: 56, color: Colors.blue.shade700),
                        const SizedBox(height: 16),
                        Text('Selected Engine: $engineType',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                          icon: const Icon(Icons.calculate),
                          label: const Text('Engine CC Calculator', style: TextStyle(fontSize: 18)),
                          onPressed: () => _navigate(context, '/cc_input', engineType),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          icon: const Icon(Icons.compress),
                          label: const Text('Compression Calculator', style: TextStyle(fontSize: 18)),
                          onPressed: () => _navigate(context, '/compression', engineType),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          icon: const Icon(Icons.speed),
                          label: const Text('Top Speed Calculator', style: TextStyle(fontSize: 18)),
                          onPressed: () => _navigate(context, '/top_speed', engineType),
                        ),
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