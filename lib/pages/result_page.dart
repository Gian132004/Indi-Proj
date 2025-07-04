import 'package:flutter/material.dart';
import 'recommendation_utils.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final double bore = args['bore'];
    final double stroke = args['stroke'];
    final int cylinders = args['cylinders'];
    final double strokePin = args['strokePin'];

    final double displacement = calculateDisplacement(bore, stroke, cylinders);
    final carbRecs = getCarbRecommendations(displacement);
    final valveRecs = getValveRecommendationsDetailed(displacement);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results & Recommendations'),
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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                children: [
                                  Icon(Icons.speed, color: Colors.blue.shade700, size: 48),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Engine Displacement',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: Colors.blue.shade700,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${displacement.round()} cc',
                                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                          color: Colors.blue.shade900,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              Icon(Icons.local_gas_station, color: Colors.blue.shade700),
                              const SizedBox(width: 8),
                              Text('Carburetor Recommendations',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Colors.blue.shade800,
                                        fontWeight: FontWeight.w600,
                                      )),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...carbRecs.map((rec) => Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  leading: Icon(Icons.settings, color: Colors.blue.shade400),
                                  title: Text(rec['purpose'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Type: ${rec['type'] ?? ''}'),
                                      Text('Size: ${rec['size'] ?? ''} mm'),
                                      Text('Jetting: ${rec['jetting'] ?? ''}'),
                                      Text('Brand: ${rec['brand'] ?? ''}'),
                                    ],
                                  ),
                                ),
                              )),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              Icon(Icons.build, color: Colors.blue.shade700),
                              const SizedBox(width: 8),
                              Text('Valve Recommendations',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Colors.blue.shade800,
                                        fontWeight: FontWeight.w600,
                                      )),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...valveRecs.map((rec) => Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  leading: Icon(Icons.tune, color: Colors.blue.shade400),
                                  title: Text(rec['purpose'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Intake Valve: ${rec['intake_size'] ?? ''} mm, Brand: ${rec['intake_brand'] ?? ''}'),
                                      Text('Exhaust Valve: ${rec['exhaust_size'] ?? ''} mm, Brand: ${rec['exhaust_brand'] ?? ''}'),
                                    ],
                                  ),
                                ),
                              )),
                          const SizedBox(height: 32),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade700,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back),
                            label: const Text('Back'),
                          ),
                        ],
                      ),
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