import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _boreController = TextEditingController();
  final TextEditingController _strokeController = TextEditingController();
  final TextEditingController _cylindersController = TextEditingController();
  final TextEditingController _strokePinController = TextEditingController();

  @override
  void dispose() {
    _boreController.dispose();
    _strokeController.dispose();
    _cylindersController.dispose();
    _strokePinController.dispose();
    super.dispose();
  }

  void _calculateAndNavigate() {
    if (_formKey.currentState!.validate()) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      final engineType = args != null && args.containsKey('engineType') ? args['engineType'] : 'Unknown';
      Navigator.pushNamed(
        context,
        '/result',
        arguments: {
          'bore': double.parse(_boreController.text),
          'stroke': double.parse(_strokeController.text),
          'cylinders': int.parse(_cylindersController.text),
          'strokePin': double.parse(_strokePinController.text),
          'engineType': engineType,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Engine CC Calculator', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
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
                    padding: const EdgeInsets.only(top: 48.0, bottom: 8.0),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    child: Divider(thickness: 1.5, color: Colors.blueGrey.shade100),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    child: Hero(
                      tag: 'title',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          'Engine Displacement Input',
                          style: GoogleFonts.poppins(
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    child: Card(
                      elevation: 16,
                      shadowColor: Colors.blue.shade100,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.engineering, color: Colors.blue.shade800, size: 22),
                                  const SizedBox(width: 12),
                                  Text('Engine Displacement Input',
                                      style: GoogleFonts.poppins(
                                        color: Colors.blue.shade800,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.1,
                                        fontSize: 15,
                                      )),
                                ],
                              ),
                              const SizedBox(height: 22),
                              Divider(thickness: 1.5, color: Colors.blueGrey.shade100),
                              const SizedBox(height: 22),
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
                                    decoration: InputDecoration(
                                      labelText: 'Bore (mm)',
                                      helperText: 'Diameter of the cylinder',
                                      prefixIcon: Icon(Icons.circle, color: Colors.blueAccent),
                                      labelStyle: GoogleFonts.poppins(color: Colors.blue.shade700),
                                      helperStyle: GoogleFonts.poppins(color: Colors.blueGrey.shade600),
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
                                    decoration: InputDecoration(
                                      labelText: 'Stroke (mm)',
                                      helperText: 'Distance piston travels',
                                      prefixIcon: Icon(Icons.height, color: Colors.deepPurple),
                                      labelStyle: GoogleFonts.poppins(color: Colors.blue.shade700),
                                      helperStyle: GoogleFonts.poppins(color: Colors.blueGrey.shade600),
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
                                  message: 'Number of cylinders in the engine',
                                  child: TextFormField(
                                    controller: _cylindersController,
                                    decoration: InputDecoration(
                                      labelText: 'Cylinders',
                                      helperText: 'Number of cylinders',
                                      prefixIcon: Icon(Icons.confirmation_number, color: Colors.green),
                                      labelStyle: GoogleFonts.poppins(color: Colors.blue.shade700),
                                      helperStyle: GoogleFonts.poppins(color: Colors.blueGrey.shade600),
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
                                  message: 'Diameter of the crank pin in mm',
                                  child: TextFormField(
                                    controller: _strokePinController,
                                    decoration: InputDecoration(
                                      labelText: 'Stroke Pin (mm)',
                                      helperText: 'Diameter of the crank pin',
                                      prefixIcon: Icon(Icons.push_pin, color: Colors.orange),
                                      labelStyle: GoogleFonts.poppins(color: Colors.blue.shade700),
                                      helperStyle: GoogleFonts.poppins(color: Colors.blueGrey.shade600),
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
                                    validator: (value) => value == null || value.isEmpty ? 'Enter stroke pin' : null,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // This is needed to trigger a rebuild of the button's state
                                      // to apply the scale effect.
                                    });
                                  },
                                  child: AnimatedScale(
                                    scale: 1.0, // Default scale
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeInOut,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue.shade700,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                        elevation: 10,
                                      ),
                                      onPressed: _calculateAndNavigate,
                                      icon: const Icon(Icons.calculate),
                                      label: const Text('Calculate'),
                                    ),
                                  ),
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