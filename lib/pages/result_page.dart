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
    final String engineType = args['engineType'] ?? 'Unknown';

    final double displacement = calculateDisplacement(bore, stroke, cylinders);
    final carbRecs = getCarbRecommendations(displacement);
    final valveRecs = getValveRecommendationsDetailed(displacement, engineType);

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
                                          letterSpacing: 1.2,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${displacement.round()} cc',
                                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                          color: Colors.blue.shade900,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Divider(thickness: 2, color: Colors.blueGrey.shade100),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.local_gas_station, color: Colors.blue.shade700),
                              const SizedBox(width: 8),
                              Text('Carburetor Recommendations',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Colors.blue.shade800,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      )),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...carbRecs.map((rec) => Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                color: Colors.blue.shade50,
                                child: ListTile(
                                  leading: Icon(Icons.settings, color: Colors.blue.shade400, size: 32),
                                  title: Text(rec['purpose'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Type: ${rec['type'] ?? ''}', style: const TextStyle(fontSize: 15)),
                                      Text('Size: ${rec['size'] ?? ''} mm', style: const TextStyle(fontSize: 15)),
                                      Text('Jetting: ${rec['jetting'] ?? ''}', style: const TextStyle(fontSize: 15)),
                                      Text('Brand: ${rec['brand'] ?? ''}', style: const TextStyle(fontSize: 15)),
                                    ],
                                  ),
                                ),
                              )),
                          const SizedBox(height: 32),
                          Divider(thickness: 2, color: Colors.blueGrey.shade100),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.build, color: Colors.blue.shade700),
                              const SizedBox(width: 8),
                              Text('Valve Recommendations',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Colors.blue.shade800,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      )),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (valveRecs.isNotEmpty)
                            ...valveRecs.map((rec) => Card(
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  color: Colors.green.shade50,
                                  child: ListTile(
                                    leading: Icon(Icons.tune, color: Colors.green.shade400, size: 32),
                                    title: Text(rec['purpose'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Intake Valve: ${rec['intake_size'] ?? ''} mm, Brand: ${rec['intake_brand'] ?? ''}', style: const TextStyle(fontSize: 15)),
                                        Text('Exhaust Valve: ${rec['exhaust_size'] ?? ''} mm, Brand: ${rec['exhaust_brand'] ?? ''}', style: const TextStyle(fontSize: 15)),
                                      ],
                                    ),
                                  ),
                                )),
                          if (valveRecs.isEmpty)
                            Card(
                              elevation: 0,
                              color: Colors.orange.shade50,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.info_outline, color: Colors.orange.shade700, size: 32),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        'No valve recommendations for two-stroke engines. Two-stroke engines do not use intake/exhaust valves.',
                                        style: TextStyle(
                                          color: Colors.orange.shade900,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(height: 32),
                          Divider(thickness: 2, color: Colors.blueGrey.shade100),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade700,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 6,
                              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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