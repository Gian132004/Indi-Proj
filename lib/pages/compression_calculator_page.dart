import 'package:flutter/material.dart';

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
        final swept = 3.1416 / 4 * bore * bore * stroke;
        final clearance = chamber + piston + gasket;
        _compressionRatio = (swept + clearance) / clearance;
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
    // Allow both Four Stroke and Two Stroke, but show info for Two Stroke
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compression Calculator'),
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
                    padding: const EdgeInsets.only(top: 48.0, bottom: 8.0),
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  if (engineType == 'Two Stroke')
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.orange.shade200, width: 1.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.info_outline, color: Colors.orange.shade700, size: 28),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Note: Two-stroke engine compression ratios are typically lower (6:1 to 8:1) and are often measured as cranking compression (psi/bar) rather than geometric ratio. This calculator provides a geometric estimate. For best results, compare with manufacturer specs or use a compression tester.',
                                  style: TextStyle(color: Colors.orange.shade900, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    child: Card(
                      elevation: 14,
                      shadowColor: Colors.blue.shade100,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.engineering, color: Colors.blue.shade700, size: 18),
                                  const SizedBox(width: 10),
                                  Text('Compression Ratio Input',
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                            color: Colors.blue.shade700,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.1,
                                            fontSize: 12,
                                          )),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Divider(thickness: 1.5, color: Colors.blueGrey.shade100),
                              const SizedBox(height: 18),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
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
                                      blurRadius: 16,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                  border: Border.all(
                                    width: 1.5,
                                    color: Colors.blue.shade100.withOpacity(0.7),
                                  ),
                                  backgroundBlendMode: BlendMode.overlay,
                                ),
                                foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.white.withOpacity(0.05),
                                  backgroundBlendMode: BlendMode.overlay,
                                ),
                                child: Tooltip(
                                  message: 'Diameter of the cylinder in mm',
                                  child: TextFormField(
                                controller: _boreController,
                                decoration: const InputDecoration(
                                  labelText: 'Bore (mm)',
                                  helperText: 'Diameter of the cylinder',
                                      prefixIcon: Icon(Icons.circle, color: Colors.blueAccent),
                                  filled: true,
                                      fillColor: Colors.transparent,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        borderSide: BorderSide(color: Color(0xFFB3E5FC), width: 1.2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        borderSide: BorderSide(color: Color(0xFF0288D1), width: 2),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter bore' : null,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
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
                                      blurRadius: 16,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                  border: Border.all(
                                    width: 1.5,
                                    color: Colors.blue.shade100.withOpacity(0.7),
                                  ),
                                  backgroundBlendMode: BlendMode.overlay,
                                ),
                                foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.white.withOpacity(0.05),
                                  backgroundBlendMode: BlendMode.overlay,
                                ),
                                child: Tooltip(
                                  message: 'Distance piston travels in mm',
                                  child: TextFormField(
                                controller: _strokeController,
                                decoration: const InputDecoration(
                                  labelText: 'Stroke (mm)',
                                  helperText: 'Distance piston travels',
                                      prefixIcon: Icon(Icons.height, color: Colors.deepPurple),
                                  filled: true,
                                      fillColor: Colors.transparent,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        borderSide: BorderSide(color: Color(0xFFB3E5FC), width: 1.2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        borderSide: BorderSide(color: Color(0xFF0288D1), width: 2),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter stroke' : null,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
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
                                      blurRadius: 16,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                  border: Border.all(
                                    width: 1.5,
                                    color: Colors.blue.shade100.withOpacity(0.7),
                                  ),
                                  backgroundBlendMode: BlendMode.overlay,
                                ),
                                foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.white.withOpacity(0.05),
                                  backgroundBlendMode: BlendMode.overlay,
                                ),
                                child: Tooltip(
                                  message: 'Combustion chamber volume in cc',
                                  child: TextFormField(
                                controller: _chamberController,
                                decoration: const InputDecoration(
                                  labelText: 'Chamber Volume (cc)',
                                  helperText: 'Combustion chamber volume',
                                      prefixIcon: Icon(Icons.science, color: Colors.teal),
                                  filled: true,
                                      fillColor: Colors.transparent,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        borderSide: BorderSide(color: Color(0xFFB3E5FC), width: 1.2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        borderSide: BorderSide(color: Color(0xFF0288D1), width: 2),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter chamber volume' : null,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
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
                                      blurRadius: 16,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                  border: Border.all(
                                    width: 1.5,
                                    color: Colors.blue.shade100.withOpacity(0.7),
                                  ),
                                  backgroundBlendMode: BlendMode.overlay,
                                ),
                                foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.white.withOpacity(0.05),
                                  backgroundBlendMode: BlendMode.overlay,
                                ),
                                child: Tooltip(
                                  message: 'Piston dome (+) or dish (-) volume in cc',
                                  child: TextFormField(
                                controller: _pistonController,
                                decoration: const InputDecoration(
                                  labelText: 'Piston Dome/Dish (cc)',
                                  helperText: 'Piston dome (+) or dish (-) volume',
                                      prefixIcon: Icon(Icons.circle_outlined, color: Colors.pink),
                                  filled: true,
                                      fillColor: Colors.transparent,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        borderSide: BorderSide(color: Color(0xFFB3E5FC), width: 1.2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        borderSide: BorderSide(color: Color(0xFF0288D1), width: 2),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter piston dome/dish' : null,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
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
                                      blurRadius: 16,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                  border: Border.all(
                                    width: 1.5,
                                    color: Colors.blue.shade100.withOpacity(0.7),
                                  ),
                                  backgroundBlendMode: BlendMode.overlay,
                                ),
                                foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.white.withOpacity(0.05),
                                  backgroundBlendMode: BlendMode.overlay,
                                ),
                                child: Tooltip(
                                  message: 'Head gasket volume in cc',
                                  child: TextFormField(
                                controller: _gasketController,
                                decoration: const InputDecoration(
                                  labelText: 'Gasket Thickness (cc)',
                                  helperText: 'Head gasket volume',
                                      prefixIcon: Icon(Icons.layers, color: Colors.amber),
                                  filled: true,
                                      fillColor: Colors.transparent,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        borderSide: BorderSide(color: Color(0xFFB3E5FC), width: 1.2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        borderSide: BorderSide(color: Color(0xFF0288D1), width: 2),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter gasket thickness' : null,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
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
                                      blurRadius: 16,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                  border: Border.all(
                                    width: 1.5,
                                    color: Colors.blue.shade100.withOpacity(0.7),
                                  ),
                                  backgroundBlendMode: BlendMode.overlay,
                                ),
                                foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.white.withOpacity(0.05),
                                  backgroundBlendMode: BlendMode.overlay,
                                ),
                                child: Tooltip(
                                  message: 'Number of cylinders in the engine',
                                  child: TextFormField(
                                controller: _cylindersController,
                                decoration: const InputDecoration(
                                  labelText: 'Cylinders',
                                  helperText: 'Number of cylinders',
                                      prefixIcon: Icon(Icons.confirmation_number, color: Colors.green),
                                  filled: true,
                                      fillColor: Colors.transparent,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        borderSide: BorderSide(color: Color(0xFFB3E5FC), width: 1.2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        borderSide: BorderSide(color: Color(0xFF0288D1), width: 2),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter cylinders' : null,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              Center(
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue.shade700,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                    elevation: 10,
                                  ),
                                  onPressed: _calculateCompression,
                                  icon: const Icon(Icons.calculate),
                                  label: const Text('Calculate'),
                                ),
                              ),
                              const SizedBox(height: 24),
                              if (_compressionRatio != null)
                                Center(
                                  child: Text(
                                    'Compression Ratio: ${_compressionRatio!.toStringAsFixed(2)} : 1',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: Colors.blue.shade700,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              if (_error != null)
                                Center(
                                  child: Text(
                                    _error!,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
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