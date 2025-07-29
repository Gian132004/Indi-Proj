import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompressionResultPage extends StatelessWidget {
  const CompressionResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    
    if (args == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        ),
        body: const Center(child: Text('No data provided')),
      );
    }

    final double bore = args['bore'] ?? 0.0;
    final double stroke = args['stroke'] ?? 0.0;
    final double chamber = args['chamber'] ?? 0.0;
    final double piston = args['piston'] ?? 0.0;
    final double gasket = args['gasket'] ?? 0.0;
    final int cylinders = args['cylinders'] ?? 0;
    final double compressionRatio = args['compressionRatio'] ?? 0.0;
    final String engineType = args['engineType'] ?? 'Unknown';

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Calculation Result',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.orange.shade800.withOpacity(0.1),
                Colors.orange.shade600.withOpacity(0.05),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Enhanced gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFE65100),
                  const Color(0xFFF57C00),
                  const Color(0xFFFF9800),
                  const Color(0xFFFFB74D),
                ],
                stops: const [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),
          
          // Animated background shapes
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          Positioned(
            bottom: -60,
            left: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.orange.shade300.withOpacity(0.15),
                    Colors.orange.shade200.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          // Subtle background pattern
          AnimatedOpacity(
            opacity: 0.08,
            duration: const Duration(seconds: 2),
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
                  // Enhanced header section
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
                    child: Hero(
                      tag: 'logo',
                      child: Material(
                        color: Colors.transparent,
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  
                  // Enhanced content section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Engine type indicator
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.1),
                              ],
                            ),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                engineType == 'Four Stroke' ? Icons.precision_manufacturing : Icons.motorcycle,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                engineType,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 25),
                        
                        // Enhanced Compression Ratio Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0.95),
                                Colors.white.withOpacity(0.85),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 30,
                                offset: const Offset(0, 15),
                                spreadRadius: 5,
                              ),
                            ],
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade600.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  Icons.compress,
                                  color: Colors.orange.shade700,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'Estimated Compression Ratio',
                                style: GoogleFonts.poppins(
                                  color: Colors.orange.shade800,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.2,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${compressionRatio.toStringAsFixed(2)} : 1',
                                style: GoogleFonts.poppins(
                                  color: Colors.orange.shade900,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 32,
                                ),
                              ),
                              const SizedBox(height: 16),
                              
                              // Accuracy note
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade100.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.orange.shade200.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.orange.shade700,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'This is a geometric estimate. Actual compression may vary.',
                                        style: GoogleFonts.poppins(
                                          color: Colors.orange.shade800,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // Engine specifications
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade50.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.orange.shade200.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    _buildSpecRow('Bore', '${bore.toStringAsFixed(1)} mm', Icons.circle_outlined),
                                    const SizedBox(height: 6),
                                    _buildSpecRow('Stroke', '${stroke.toStringAsFixed(1)} mm', Icons.straighten),
                                    const SizedBox(height: 6),
                                    _buildSpecRow('Chamber Volume', '${chamber.toStringAsFixed(1)} cc', Icons.volume_up),
                                    const SizedBox(height: 6),
                                    _buildSpecRow('Piston Dome/Dish', '${piston.toStringAsFixed(1)} cc', Icons.arrow_upward),
                                    const SizedBox(height: 6),
                                    _buildSpecRow('Gasket Volume', '${gasket.toStringAsFixed(1)} cc', Icons.layers),
                                    const SizedBox(height: 6),
                                    _buildSpecRow('Cylinders', '$cylinders', Icons.view_column),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 25),
                        
                        // Enhanced success message
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [
                                Colors.green.shade400.withOpacity(0.2),
                                Colors.green.shade300.withOpacity(0.1),
                              ],
                            ),
                            border: Border.all(
                              color: Colors.green.shade300.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade500.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.green.shade600,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Geometric compression ratio estimated. For precise measurements, use a compression tester.',
                                  style: GoogleFonts.poppins(
                                    color: Colors.green.shade800,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 25),
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
  
  Widget _buildSpecRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.orange.shade600,
          size: 18,
        ),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: GoogleFonts.poppins(
            color: Colors.orange.shade700,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.orange.shade800,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
} 