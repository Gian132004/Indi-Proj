import 'package:flutter/material.dart';

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
        title: const Text('Engine CC Calculator'),
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
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
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
                        padding: const EdgeInsets.all(32.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.engineering, color: Colors.blue.shade700, size: 32),
                                  const SizedBox(width: 10),
                                  Text('Engine Displacement Input',
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            color: Colors.blue.shade700,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.1,
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
                                    decoration: const InputDecoration(
                                      labelText: 'Stroke Pin (mm)',
                                      helperText: 'Diameter of the crank pin',
                                      prefixIcon: Icon(Icons.push_pin, color: Colors.orange),
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