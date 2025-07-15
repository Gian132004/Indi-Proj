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
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.blue.shade700,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Custom background shapes
          Positioned(
            top: -80,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.blue.shade100, Colors.blue.shade300.withOpacity(0.5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.orange.shade100, Colors.orange.shade300.withOpacity(0.4)],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
            ),
          ),
          // Existing gradient and background
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
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Engine Displacement Card
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.55),
                                Colors.blue.shade50.withOpacity(0.35),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade100.withOpacity(0.25),
                                blurRadius: 18,
                                offset: Offset(0, 8),
                              ),
                            ],
                            border: Border.all(
                              width: 1.5,
                              color: Colors.blue.shade100.withOpacity(0.7),
                            ),
                            backgroundBlendMode: BlendMode.overlay,
                          ),
                          foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.white.withOpacity(0.05),
                            backgroundBlendMode: BlendMode.overlay,
                          ),
                          margin: const EdgeInsets.only(bottom: 32),
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
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
                                  '${displacement.toStringAsFixed(1)} cc',
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
                        // Carburetor Recommendations Section
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
                            const SizedBox(width: 8),
                            Tooltip(
                              message: 'Suggested carburetor types and settings for your engine size.',
                              child: Icon(Icons.info_outline, color: Colors.blueGrey.shade400, size: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ...carbRecs.map((rec) => AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              width: double.infinity, // Expand to full width
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.55),
                                    Colors.blue.shade50.withOpacity(0.35),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.shade100.withOpacity(0.18),
                                    blurRadius: 14,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                                border: Border.all(
                                  width: 1.2,
                                  color: Colors.blue.shade100.withOpacity(0.6),
                                ),
                                backgroundBlendMode: BlendMode.overlay,
                              ),
                              foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: Colors.white.withOpacity(0.04),
                                backgroundBlendMode: BlendMode.overlay,
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(22.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${rec['purpose']}',
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              color: Colors.blue.shade700,
                                              fontWeight: FontWeight.bold,
                                            )),
                                    const SizedBox(height: 6),
                                    Text('Type: ${rec['type']}'),
                                    Text('Size: ${rec['size']} mm'),
                                    Text('Jetting: ${rec['jetting']}'),
                                    Text('Brand: ${rec['brand']}'),
                                    if (rec['ph_brands'] != null)
                                      Text('PH Brands: ${rec['ph_brands']}'),
                                  ],
                                ),
                              ),
                            )),
                        const SizedBox(height: 32),
                        // Valve Recommendations Section
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
                            const SizedBox(width: 8),
                            Tooltip(
                              message: 'Suggested intake and exhaust valve sizes/brands for your engine.',
                              child: Icon(Icons.info_outline, color: Colors.blueGrey.shade400, size: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (valveRecs.isNotEmpty)
                          ...valveRecs.map((rec) => AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                width: double.infinity, // Expand to full width
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.55),
                                      Colors.green.shade50.withOpacity(0.35),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.green.shade100.withOpacity(0.18),
                                      blurRadius: 14,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                  border: Border.all(
                                    width: 1.2,
                                    color: Colors.green.shade100.withOpacity(0.6),
                                  ),
                                  backgroundBlendMode: BlendMode.overlay,
                                ),
                                foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: Colors.white.withOpacity(0.04),
                                  backgroundBlendMode: BlendMode.overlay,
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                child: Padding(
                                  padding: const EdgeInsets.all(22.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${rec['purpose']}',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                color: Colors.green.shade700,
                                                fontWeight: FontWeight.bold,
                                              )),
                                      const SizedBox(height: 6),
                                      Text('Intake: ${rec['intake_size']} mm (${rec['intake_brand']})'),
                                      Text('Exhaust: ${rec['exhaust_size']} mm (${rec['exhaust_brand']})'),
                                      if (rec['ph_brands'] != null)
                                        Text('PH Brands: ${rec['ph_brands']}'),
                                    ],
                                  ),
                                ),
                              )),
                        if (valveRecs.isEmpty)
                          AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.55),
                                  Colors.orange.shade50.withOpacity(0.35),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.shade100.withOpacity(0.18),
                                  blurRadius: 14,
                                  offset: Offset(0, 6),
                                ),
                              ],
                              border: Border.all(
                                width: 1.2,
                                color: Colors.orange.shade100.withOpacity(0.6),
                              ),
                              backgroundBlendMode: BlendMode.overlay,
                            ),
                            foregroundDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: Colors.white.withOpacity(0.04),
                              backgroundBlendMode: BlendMode.overlay,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(22.0),
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
                        Text(
                          'All recommendations are general guidelines. For best results, consult a professional engine builder.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.blueGrey.shade700,
                                fontStyle: FontStyle.italic,
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