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
  final TextEditingController _cvtGearingController = TextEditingController();
  double? _topSpeed;
  String? _error;
  String _transmissionType = 'Manual';

  @override
  void dispose() {
    _rpmController.dispose();
    _tireController.dispose();
    _finalDriveController.dispose();
    _gearController.dispose();
    _errorController.dispose();
    _cvtGearingController.dispose();
    super.dispose();
  }

  void _calculateTopSpeed() {
    setState(() {
      _error = null;
      try {
        final rpm = double.parse(_rpmController.text);
        final tire = double.parse(_tireController.text);
        double finalDrive = 1.0;
        double gear = 1.0;
        if (_transmissionType == 'Manual') {
          finalDrive = double.parse(_finalDriveController.text);
          gear = double.parse(_gearController.text);
        } else if (_transmissionType == 'Scooter') {
          gear = double.parse(_cvtGearingController.text);
        }
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
    // Allow both Four Stroke and Two Stroke, but show info for Two Stroke
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Speed Calculator'),
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
                                  'Note: Two-stroke top speed depends heavily on expansion chamber tuning, porting, and exhaust design. This calculator provides a theoretical estimate. Real-world results may vary.',
                                  style: TextStyle(color: Colors.orange.shade900, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                              // Transmission type selector
                              Row(
                                children: [
                                  Icon(Icons.settings_suggest, color: Colors.blue.shade700, size: 18),
                                  const SizedBox(width: 10),
                                  Text('Transmission Type:',
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                            color: Colors.blue.shade700,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          )),
                                  const SizedBox(width: 16),
                                  DropdownButton<String>(
                                    value: _transmissionType,
                                    borderRadius: BorderRadius.circular(12),
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.blue.shade900),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'Manual',
                                        child: Text('Manual'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Scooter',
                                        child: Text('Scooter'),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _transmissionType = value!;
                                        // Clear gear ratio and final drive if switching to scooter
                                        if (_transmissionType == 'Scooter') {
                                          _gearController.clear();
                                          _finalDriveController.clear();
                                          _cvtGearingController.clear();
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              if (_transmissionType == 'Manual')
                                Text(
                                  'Manual: Enter all fields including Final Drive and Gear Ratio.',
                                  style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 14),
                                ),
                              if (_transmissionType == 'Scooter')
                                Text(
                                  'Scooter: Only RPM, Tire Diameter, and Speedometer Error are required. CVT transmission does not use sprockets or gear ratio.',
                                  style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 14),
                                ),
                              const SizedBox(height: 18),
                              Row(
                                children: [
                                  Icon(Icons.speed, color: Colors.blue.shade700, size: 32),
                                  const SizedBox(width: 10),
                                  Text('Top Speed Input',
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
                              // Input fields (aligned for both Manual and Scooter)
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
                                  message: 'Maximum engine RPM',
                                  child: TextFormField(
                                    controller: _rpmController,
                                    decoration: const InputDecoration(
                                      labelText: 'Max RPM',
                                      helperText: 'Maximum engine RPM',
                                      prefixIcon: Icon(Icons.rotate_right, color: Colors.redAccent),
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
                                    validator: (value) => value == null || value.isEmpty ? 'Enter max RPM' : null,
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
                                  message: 'Diameter of the drive tire in inches',
                                  child: TextFormField(
                                    controller: _tireController,
                                    decoration: const InputDecoration(
                                      labelText: 'Tire Diameter (inches)',
                                      helperText: 'Diameter of the drive tire',
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
                                    validator: (value) => value == null || value.isEmpty ? 'Enter tire diameter' : null,
                                  ),
                                ),
                              ),
                              if (_transmissionType == 'Manual') ...[
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
                                    message: 'Rear sprocket / front sprocket ratio',
                                    child: TextFormField(
                                      controller: _finalDriveController,
                                      decoration: const InputDecoration(
                                        labelText: 'Final Drive Ratio',
                                        helperText: 'Rear sprocket / front sprocket',
                                        prefixIcon: Icon(Icons.settings, color: Colors.deepPurple),
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
                                      validator: (value) => value == null || value.isEmpty ? 'Enter final drive ratio' : null,
                                    ),
                                  ),
                                ),
                              ],
                              if (_transmissionType == 'Scooter') ...[
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
                                    message: 'CVT Gearing Ratio (primary reduction, usually 6-10)',
                                    child: TextFormField(
                                      controller: _cvtGearingController,
                                      decoration: const InputDecoration(
                                        labelText: 'CVT Gearing Ratio',
                                        helperText: 'Primary reduction (e.g. 7.5)',
                                        prefixIcon: Icon(Icons.settings, color: Colors.deepPurple),
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
                                      validator: (value) => value == null || value.isEmpty ? 'Enter CVT gearing ratio' : null,
                                    ),
                                  ),
                                ),
                              ],
                              if (_transmissionType == 'Manual') ...[
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
                                    message: 'Transmission gear ratio',
                                    child: TextFormField(
                                      controller: _gearController,
                                      decoration: const InputDecoration(
                                        labelText: 'Gear Ratio',
                                        helperText: 'Transmission gear ratio',
                                        prefixIcon: Icon(Icons.settings_applications, color: Colors.green),
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
                                      validator: (value) {
                                        if (_transmissionType == 'Manual') {
                                          return value == null || value.isEmpty ? 'Enter gear ratio' : null;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
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
                                  message: 'Optional: speedometer error correction (%)',
                                  child: TextFormField(
                                    controller: _errorController,
                                    decoration: const InputDecoration(
                                      labelText: 'Speedometer Error (%)',
                                      helperText: 'Optional: error correction',
                                      prefixIcon: Icon(Icons.error_outline, color: Colors.orange),
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