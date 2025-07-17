double calculateDisplacement(double bore, double stroke, int cylinders) {
  // Displacement formula: π/4 × bore^2 × stroke × cylinders
  // Convert mm to cm for bore and stroke
  final boreCm = bore / 10;
  final strokeCm = stroke / 10;
  return 3.1416 / 4 * boreCm * boreCm * strokeCm * cylinders;
}

List<Map<String, String>> getCarbRecommendations({
  required double bore,
  required double stroke,
  required int cylinders,
  required double displacement,
  required String engineType,
}) {
  final isTwoStroke = engineType.toLowerCase().contains('two');
  List<Map<String, String>> recos = [];

  // Daily use: carb size ≈ 0.9 × bore (2-stroke: 1.0 × bore)
  // Racing: carb size ≈ 1.1 × bore (2-stroke: 1.2 × bore)
  double dailyFactor = isTwoStroke ? 1.0 : 0.9;
  double raceFactor = isTwoStroke ? 1.2 : 1.1;
  int dailyCarb = (bore * dailyFactor).round();
  int raceCarb = (bore * raceFactor).round();

  // Jetting estimate (very rough, for demo)
  String dailyJetting = 'Main: ${(displacement * 0.8).round()}, Pilot: ${(displacement * 0.3).round()}';
  String raceJetting = 'Main: ${(displacement * 1.0).round()}, Pilot: ${(displacement * 0.4).round()}';

  recos.add({
    'purpose': 'Daily Use',
    'type': isTwoStroke ? 'Round Slide Carburetor' : 'CV Carburetor',
    'size': dailyCarb.toString(),
    'jetting': dailyJetting,
    'brand': isTwoStroke ? 'OKO' : 'Keihin',
    'ph_brands': isTwoStroke ? 'OKO, Keihin, Faito' : 'Keihin, OKO, Faito',
  });
  recos.add({
    'purpose': 'Racing',
    'type': 'Flat Slide Carburetor',
    'size': raceCarb.toString(),
    'jetting': raceJetting,
    'brand': 'Mikuni',
    'ph_brands': 'Mikuni, Uma Racing, Racing Boy',
  });
  return recos;
}

List<Map<String, String>> getValveRecommendationsDetailed({
  required double bore,
  required double displacement,
  required String engineType,
}) {
  if (engineType.toLowerCase().contains('two')) {
    return [];
  }
  // Daily: intake ≈ 0.35 × bore, exhaust ≈ 0.3 × bore
  // Racing: intake ≈ 0.4 × bore, exhaust ≈ 0.35 × bore
  int intakeDaily = (bore * 0.35).round();
  int exhaustDaily = (bore * 0.3).round();
  int intakeRace = (bore * 0.4).round();
  int exhaustRace = (bore * 0.35).round();

  return [
    {
      'purpose': 'Daily Use',
      'intake_size': intakeDaily.toString(),
      'intake_brand': 'Supertech',
      'exhaust_size': exhaustDaily.toString(),
      'exhaust_brand': 'Supertech',
      'ph_brands': 'Faito, Uma Racing, Racing Boy',
    },
    {
      'purpose': 'Racing',
      'intake_size': intakeRace.toString(),
      'intake_brand': 'Ferrea',
      'exhaust_size': exhaustRace.toString(),
      'exhaust_brand': 'Ferrea',
      'ph_brands': 'Uma Racing, Faito, Racing Boy',
    },
  ];
} 