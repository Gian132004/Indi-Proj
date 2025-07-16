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
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings, size: 28, color: Colors.blue.shade700),
                        const SizedBox(height: 16),
                        Text('Selected Engine: $engineType',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                )),
                        const SizedBox(height: 32),
                        Tooltip(
                          message: 'Calculate engine displacement (cc)',
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade700,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 36),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            icon: const Icon(Icons.calculate, size: 16),
                            label: const Text('Engine CC Calculator', style: TextStyle(fontSize: 12)),
                            onPressed: () => _navigate(context, '/cc_input', engineType),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Tooltip(
                          message: 'Calculate compression ratio (Four Stroke only)',
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.shade700,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 36),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            icon: const Icon(Icons.compress, size: 16),
                            label: const Text('Compression Calculator', style: TextStyle(fontSize: 12)),
                            onPressed: () => _navigate(context, '/compression', engineType),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Tooltip(
                          message: 'Calculate theoretical top speed (Four Stroke only)',
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade700,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 36),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            icon: const Icon(Icons.speed, size: 16),
                            label: const Text('Top Speed Calculator', style: TextStyle(fontSize: 12)),
                            onPressed: () => _navigate(context, '/top_speed', engineType),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Select a tool to begin calculations or get recommendations for your engine build.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.blueGrey.shade700,
                                fontSize: 10,
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