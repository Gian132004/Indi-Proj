import 'package:flutter/material.dart';
import 'recommendation_utils.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final carbRecs = getCarbRecommendations(
      bore: bore,
      stroke: stroke,
      cylinders: cylinders,
      displacement: displacement,
      engineType: engineType,
    );
    final valveRecs = getValveRecommendationsDetailed(
      bore: bore,
      displacement: displacement,
      engineType: engineType,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Results & Recommendations', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.blue.shade800,
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
                  colors: [Colors.lightBlueAccent.shade100, Colors.lightBlueAccent.shade200.withOpacity(0.4)],
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
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 70,
                              height: 70,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
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
                          duration: const Duration(milliseconds: 500),
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
                                offset: const Offset(0, 8),
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
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Icon(Icons.speed, color: Colors.blue.shade800, size: 28),
                                const SizedBox(height: 14),
                                Text(
                                  'Engine Displacement',
                                  style: GoogleFonts.poppins(
                                    color: Colors.blue.shade800,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${displacement.toStringAsFixed(1)} cc',
                                  style: GoogleFonts.poppins(
                                    color: Colors.blue.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Carburetor Recommendations Section
                        Row(
                          children: [
                            Icon(Icons.local_gas_station, color: Colors.blue.shade800),
                            const SizedBox(width: 10),
                            Text('Carburetor Recommendations',
                                style: GoogleFonts.poppins(
                                  color: Colors.blue.shade800,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                )),
                            const SizedBox(width: 8),
                            Tooltip(
                              message: 'Suggested carburetor types and settings for your engine size.',
                              child: Icon(Icons.info_outline, color: Colors.blueGrey.shade400, size: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        ...carbRecs.map((rec) => AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
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
                                    offset: const Offset(0, 6),
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
                                        style: GoogleFonts.poppins(
                                          color: Colors.blue.shade800,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    const SizedBox(height: 6),
                                    Text('Type: ${rec['type']}', style: GoogleFonts.poppins(fontSize: 14)),
                                    Text('Size: ${rec['size']} mm', style: GoogleFonts.poppins(fontSize: 14)),
                                    Text('Jetting: ${rec['jetting']}', style: GoogleFonts.poppins(fontSize: 14)),
                                    Text('Brand: ${rec['brand']}', style: GoogleFonts.poppins(fontSize: 14)),
                                    if (rec['ph_brands'] != null)
                                      Text('PH Brands: ${rec['ph_brands']}', style: GoogleFonts.poppins(fontSize: 14)),
                                  ],
                                ),
                              ),
                            )),
                        const SizedBox(height: 32),
                        // Valve Recommendations Section
                        Row(
                          children: [
                            Icon(Icons.build, color: Colors.blue.shade800),
                            const SizedBox(width: 10),
                            Text('Valve Recommendations',
                                style: GoogleFonts.poppins(
                                  color: Colors.blue.shade800,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                )),
                            const SizedBox(width: 8),
                            Tooltip(
                              message: 'Suggested valve sizes and types for your engine.',
                              child: Icon(Icons.info_outline, color: Colors.blueGrey.shade400, size: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        ...valveRecs.map((rec) => AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              width: double.infinity,
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
                                    offset: const Offset(0, 6),
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
                                        style: GoogleFonts.poppins(
                                          color: Colors.blue.shade800,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    const SizedBox(height: 6),
                                    Text('Intake: ${rec['intake_size']} mm (${rec['intake_brand']})', style: GoogleFonts.poppins(fontSize: 14)),
                                    Text('Exhaust: ${rec['exhaust_size']} mm (${rec['exhaust_brand']})', style: GoogleFonts.poppins(fontSize: 14)),
                                    if (rec['ph_brands'] != null)
                                      Text('PH Brands: ${rec['ph_brands']}', style: GoogleFonts.poppins(fontSize: 14)),
                                  ],
                                ),
                              ),
                            )),
                        const SizedBox(height: 40),
                        Text(
                          'All recommendations are based on typical engine builds. Always consult a professional for your specific application.',
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