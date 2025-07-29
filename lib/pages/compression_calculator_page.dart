import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class CompressionCalculatorPage extends StatefulWidget {
  const CompressionCalculatorPage({super.key});

  @override
  State<CompressionCalculatorPage> createState() => _CompressionCalculatorPageState();
}

class _CompressionCalculatorPageState extends State<CompressionCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _boreController = TextEditingController();
  final TextEditingController _strokeController = TextEditingController();
  final TextEditingController _chamberController = TextEditingController();
  final TextEditingController _pistonController = TextEditingController();
  final TextEditingController _gasketController = TextEditingController();
  final TextEditingController _cylindersController = TextEditingController();
  double? _compressionRatio;
  String? _error;

  @override
  void dispose() {
    _boreController.dispose();
    _strokeController.dispose();
    _chamberController.dispose();
    _pistonController.dispose();
    _gasketController.dispose();
    _cylindersController.dispose();
    super.dispose();
  }

  void _calculateCompression() {
    setState(() {
      _error = null;
      try {
        final bore = double.parse(_boreController.text);
        final stroke = double.parse(_strokeController.text);
        final chamber = double.parse(_chamberController.text);
        final piston = double.parse(_pistonController.text);
        final gasket = double.parse(_gasketController.text);
        final cylinders = int.parse(_cylindersController.text);
        
        // Validate inputs
        if (bore <= 0 || stroke <= 0 || chamber <= 0 || gasket < 0) {
          _error = 'Please enter valid positive values for bore, stroke, and chamber. Gasket can be 0.';
          _compressionRatio = null;
          return;
        }
        
        // Convert mm to cm for bore and stroke, then calculate swept volume in cc
        final boreCm = bore / 10;
        final strokeCm = stroke / 10;
        final sweptVolume = pi / 4 * boreCm * boreCm * strokeCm;
        
        // Calculate clearance volume with proper handling of piston relief
        // Piston relief can be positive (dome) or negative (dish)
        final clearanceVolume = chamber + gasket + piston;
        
        // Validate clearance volume
        if (clearanceVolume <= 0) {
          _error = 'Clearance volume must be positive. Check your input values.';
          _compressionRatio = null;
          return;
        }
        
        // Compression ratio = (swept volume + clearance volume) / clearance volume
        _compressionRatio = (sweptVolume + clearanceVolume) / clearanceVolume;
        
        // Validate the result
        if (_compressionRatio! < 1.0) {
          _error = 'Invalid result. Check your input values.';
          _compressionRatio = null;
          return;
        }
        
        // Navigate to result page
        Navigator.pushNamed(
          context,
          '/compression_result',
          arguments: {
            'bore': bore,
            'stroke': stroke,
            'chamber': chamber,
            'piston': piston,
            'gasket': gasket,
            'cylinders': cylinders,
            'compressionRatio': _compressionRatio,
            'engineType': 'Four Stroke', // Default engine type
          },
        );
      } catch (e) {
        _compressionRatio = null;
        _error = 'Please enter valid numbers for all fields.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final String engineType = args?['engineType'] ?? 'Unknown';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Compression Calculator',
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
                Colors.purple.shade800.withOpacity(0.1),
                Colors.purple.shade600.withOpacity(0.05),
              ],
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Enhanced gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF4a148c),
                  const Color(0xFF6a1b9a),
                  const Color(0xFF8e24aa),
                  const Color(0xFFba68c8),
                ],
                stops: const [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),
          
          // Animated background shapes
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
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
            bottom: -40,
            left: -40,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.purple.shade300.withOpacity(0.15),
                    Colors.purple.shade200.withOpacity(0.1),
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
                    padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                    child: Hero(
                      tag: 'logo',
                      child: Material(
                        color: Colors.transparent,
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 80,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  
                  // Enhanced title section
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.15),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'Enter Compression Parameters',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  if (engineType == 'Two Stroke')
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.orange.shade200, width: 1.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.info_outline, color: Colors.orange.shade700, size: 22),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Note: Two-stroke engine compression ratios are typically lower (6:1 to 8:1) and are often measured as cranking compression (psi/bar) rather than geometric ratio. This calculator provides a geometric estimate. For best results, compare with manufacturer specs or use a compression tester.',
                                  style: GoogleFonts.poppins(
                                    color: Colors.orange.shade900, 
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  
                  // Compression calculation info
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.purple.shade200, width: 1.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.calculate, color: Colors.purple.shade700, size: 22),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '⚠️ ESTIMATE ONLY: This calculator provides a geometric compression ratio estimate. Actual compression may vary due to valve timing, port design, and other factors. For precise measurements, use a compression tester.',
                                style: GoogleFonts.poppins(
                                  color: Colors.purple.shade900, 
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 15),
                  
                  // Enhanced form section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
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
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                            spreadRadius: 3,
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Form header
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.purple.shade600.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.compress,
                                      color: Colors.purple.shade700,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Compression Parameters',
                                    style: GoogleFonts.poppins(
                                      color: Colors.purple.shade800,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 15),
                              
                              // Enhanced input fields
                              _buildInputField(
                                controller: _boreController,
                                label: 'Bore Diameter',
                                hint: 'Enter bore in mm',
                                icon: Icons.circle_outlined,
                                color: const Color(0xFF2196F3),
                              ),
                              
                              const SizedBox(height: 12),
                              
                              _buildInputField(
                                controller: _strokeController,
                                label: 'Stroke Length',
                                hint: 'Enter stroke in mm',
                                icon: Icons.straighten,
                                color: const Color(0xFF4CAF50),
                              ),
                              
                              const SizedBox(height: 12),
                              
                              _buildInputField(
                                controller: _chamberController,
                                label: 'Chamber Volume',
                                hint: 'Enter chamber volume in cc (typically 8-15 cc)',
                                icon: Icons.science,
                                color: const Color(0xFF9C27B0),
                              ),
                              
                              const SizedBox(height: 12),
                              
                              _buildInputField(
                                controller: _pistonController,
                                label: 'Piston Dome/Dish',
                                hint: 'Enter piston volume in cc (0 for flat-top, -2 to +2)',
                                icon: Icons.circle_outlined,
                                color: const Color(0xFFE91E63),
                              ),
                              
                              const SizedBox(height: 12),
                              
                              _buildInputField(
                                controller: _gasketController,
                                label: 'Gasket Volume',
                                hint: 'Enter gasket volume in cc (typically 0.5-1.5 cc)',
                                icon: Icons.layers,
                                color: const Color(0xFFFF9800),
                              ),
                              
                              const SizedBox(height: 12),
                              
                              _buildInputField(
                                controller: _cylindersController,
                                label: 'Number of Cylinders',
                                hint: 'Enter cylinder count',
                                icon: Icons.view_column,
                                color: const Color(0xFF607D8B),
                              ),
                              
                              const SizedBox(height: 20),
                              
                              // Enhanced calculate button
                              Container(
                                width: double.infinity,
                                height: 50,
                                child: TextButton(
                                  onPressed: _calculateCompression,
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.purple.shade600,
                                    elevation: 6,
                                    shadowColor: Colors.purple.shade300,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: Text(
                                    'Calculate',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              
                              if (_error != null) ...[
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.red.shade400.withOpacity(0.2),
                                        Colors.red.shade300.withOpacity(0.1),
                                      ],
                                    ),
                                    border: Border.all(
                                      color: Colors.red.shade300.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.red.shade500.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.red.shade600,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          _error!,
                                          style: GoogleFonts.poppins(
                                            color: Colors.red.shade800,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.purple.shade800,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.purple.shade800,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              color: Colors.purple.shade400,
              fontSize: 13,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: color.withOpacity(0.3),
                width: 1.2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: color.withOpacity(0.3),
                width: 1.2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: color,
                width: 1.8,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            if (double.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
            return null;
          },
        ),
      ],
    );
  }
} 