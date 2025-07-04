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
    if (engineType != 'Four Stroke') {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Compression Calculator'),
          backgroundColor: Colors.blue.shade700,
          elevation: 4,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: const Center(
          child: Text('Compression calculator is only available for Four Stroke engines.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compression Calculator'),
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
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
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
                  Padding(
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
                                  Text('Compression Inputs',
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
                                controller: _chamberController,
                                decoration: const InputDecoration(
                                  labelText: 'Chamber Volume (cc)',
                                  helperText: 'Combustion chamber volume',
                                  prefixIcon: Icon(Icons.science),
                                  filled: true,
                                  fillColor: Color(0xFFF5F7FA),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter chamber volume' : null,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _pistonController,
                                decoration: const InputDecoration(
                                  labelText: 'Piston Dome/Dish (cc)',
                                  helperText: 'Piston dome (+) or dish (-) volume',
                                  prefixIcon: Icon(Icons.circle_outlined),
                                  filled: true,
                                  fillColor: Color(0xFFF5F7FA),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter piston dome/dish' : null,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _gasketController,
                                decoration: const InputDecoration(
                                  labelText: 'Gasket Thickness (cc)',
                                  helperText: 'Head gasket volume',
                                  prefixIcon: Icon(Icons.layers),
                                  filled: true,
                                  fillColor: Color(0xFFF5F7FA),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter gasket thickness' : null,
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
                              const SizedBox(height: 32),
                              Center(
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue.shade700,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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