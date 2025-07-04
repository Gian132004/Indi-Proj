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
      Navigator.pushNamed(
        context,
        '/result',
        arguments: {
          'bore': double.parse(_boreController.text),
          'stroke': double.parse(_strokeController.text),
          'cylinders': int.parse(_cylindersController.text),
          'strokePin': double.parse(_strokePinController.text),
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Engine Displacement Input'),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.engineering, color: Colors.blue.shade700),
                                  const SizedBox(width: 8),
                                  Text('Engine Specs',
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            color: Colors.blue.shade700,
                                            fontWeight: FontWeight.bold,
                                          )),
                                ],
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                controller: _boreController,
                                decoration: const InputDecoration(
                                  labelText: 'Bore (mm)',
                                  helperText: 'Diameter of the cylinder',
                                  prefixIcon: Icon(Icons.circle),
                                  filled: true,
                                  fillColor: Color(0xFFF5F7FA),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter bore' : null,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _strokeController,
                                decoration: const InputDecoration(
                                  labelText: 'Stroke (mm)',
                                  helperText: 'Distance piston travels',
                                  prefixIcon: Icon(Icons.height),
                                  filled: true,
                                  fillColor: Color(0xFFF5F7FA),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter stroke' : null,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _cylindersController,
                                decoration: const InputDecoration(
                                  labelText: 'Cylinders',
                                  helperText: 'Number of cylinders',
                                  prefixIcon: Icon(Icons.confirmation_number),
                                  filled: true,
                                  fillColor: Color(0xFFF5F7FA),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter cylinders' : null,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _strokePinController,
                                decoration: const InputDecoration(
                                  labelText: 'Stroke Pin (mm)',
                                  helperText: 'Diameter of the crank pin',
                                  prefixIcon: Icon(Icons.push_pin),
                                  filled: true,
                                  fillColor: Color(0xFFF5F7FA),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter stroke pin' : null,
                              ),
                              const SizedBox(height: 32),
                              Center(
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue.shade700,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 