import 'package:flutter/material.dart';

class TopSpeedCalculatorPage extends StatefulWidget {
  const TopSpeedCalculatorPage({super.key});

  @override
  State<TopSpeedCalculatorPage> createState() => _TopSpeedCalculatorPageState();
}

class _TopSpeedCalculatorPageState extends State<TopSpeedCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _rpmController = TextEditingController();
  final TextEditingController _tireController = TextEditingController();
  final TextEditingController _finalDriveController = TextEditingController();
  final TextEditingController _gearController = TextEditingController();
  final TextEditingController _errorController = TextEditingController();
  double? _topSpeed;
  String? _error;

  @override
  void dispose() {
    _rpmController.dispose();
    _tireController.dispose();
    _finalDriveController.dispose();
    _gearController.dispose();
    _errorController.dispose();
    super.dispose();
  }

  void _calculateTopSpeed() {
    setState(() {
      _error = null;
      try {
        final rpm = double.parse(_rpmController.text);
        final tire = double.parse(_tireController.text);
        final finalDrive = double.parse(_finalDriveController.text);
        final gear = double.parse(_gearController.text);
        final error = double.tryParse(_errorController.text) ?? 0.0;
        final tireCircumference = tire * 0.0254 * 3.1416;
        final speedMPerMin = (rpm * tireCircumference) / (finalDrive * gear);
        double speedKmh = speedMPerMin * 60 / 1000;
        speedKmh = speedKmh * (1 + error / 100);
        _topSpeed = speedKmh;
      } catch (e) {
        _topSpeed = null;
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
          title: const Text('Top Speed Calculator'),
          backgroundColor: Colors.blue.shade700,
          elevation: 4,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: const Center(
          child: Text('Top speed calculator is only available for Four Stroke engines.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Speed Calculator'),
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
                                  Icon(Icons.speed, color: Colors.blue.shade700),
                                  const SizedBox(width: 8),
                                  Text('Top Speed Inputs',
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            color: Colors.blue.shade700,
                                            fontWeight: FontWeight.bold,
                                          )),
                                ],
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                controller: _rpmController,
                                decoration: const InputDecoration(
                                  labelText: 'Max RPM',
                                  helperText: 'Maximum engine RPM',
                                  prefixIcon: Icon(Icons.rotate_right),
                                  filled: true,
                                  fillColor: Color(0xFFF5F7FA),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter max RPM' : null,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _tireController,
                                decoration: const InputDecoration(
                                  labelText: 'Tire Diameter (inches)',
                                  helperText: 'Diameter of the drive tire',
                                  prefixIcon: Icon(Icons.circle),
                                  filled: true,
                                  fillColor: Color(0xFFF5F7FA),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter tire diameter' : null,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _finalDriveController,
                                decoration: const InputDecoration(
                                  labelText: 'Final Drive Ratio',
                                  helperText: 'Rear sprocket / front sprocket',
                                  prefixIcon: Icon(Icons.settings),
                                  filled: true,
                                  fillColor: Color(0xFFF5F7FA),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter final drive ratio' : null,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _gearController,
                                decoration: const InputDecoration(
                                  labelText: 'Gear Ratio',
                                  helperText: 'Transmission gear ratio',
                                  prefixIcon: Icon(Icons.settings_applications),
                                  filled: true,
                                  fillColor: Color(0xFFF5F7FA),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ? 'Enter gear ratio' : null,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _errorController,
                                decoration: const InputDecoration(
                                  labelText: 'Speedometer Error (%)',
                                  helperText: 'Optional: error correction',
                                  prefixIcon: Icon(Icons.error_outline),
                                  filled: true,
                                  fillColor: Color(0xFFF5F7FA),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
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
                                  onPressed: _calculateTopSpeed,
                                  icon: const Icon(Icons.calculate),
                                  label: const Text('Calculate'),
                                ),
                              ),
                              const SizedBox(height: 24),
                              if (_topSpeed != null)
                                Center(
                                  child: Text(
                                    'Top Speed: ${_topSpeed!.toStringAsFixed(2)} km/h',
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