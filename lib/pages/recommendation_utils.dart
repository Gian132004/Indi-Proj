double calculateDisplacement(double bore, double stroke, int cylinders) {
  // Displacement formula: π/4 × bore^2 × stroke × cylinders
  // Convert mm to cm for bore and stroke
  final boreCm = bore / 10;
  final strokeCm = stroke / 10;
  return 3.1416 / 4 * boreCm * boreCm * strokeCm * cylinders;
}

List<Map<String, String>> getCarbRecommendations(double displacement) {
  // Updated logic for carb recommendations with PH brands
  return [
    {
      'purpose': 'Fuel Efficiency',
      'type': 'CV Carburetor',
      'size': '24',
      'jetting': 'Main: 90, Pilot: 35',
      'brand': 'Keihin',
      'ph_brands': 'Keihin, OKO, Faito',
    },
    {
      'purpose': 'Extreme Power (Racing)',
      'type': 'Flat Slide Carburetor',
      'size': '28',
      'jetting': 'Main: 120, Pilot: 40',
      'brand': 'Mikuni',
      'ph_brands': 'Mikuni, Uma Racing, Racing Boy',
    },
    {
      'purpose': 'Daily Use',
      'type': 'Round Slide Carburetor',
      'size': '26',
      'jetting': 'Main: 100, Pilot: 38',
      'brand': 'OKO',
      'ph_brands': 'OKO, Keihin, Faito',
    },
  ];
}

List<Map<String, String>> getValveRecommendationsDetailed(double displacement, String engineType) {
  if (engineType.toLowerCase().contains('two')) {
    return [];
  }
  // Updated valve recommendations with PH brands
  return [
    {
      'purpose': 'Daily Use',
      'intake_size': '24',
      'intake_brand': 'Supertech',
      'exhaust_size': '22',
      'exhaust_brand': 'Supertech',
      'ph_brands': 'Faito, Uma Racing, Racing Boy',
    },
    {
      'purpose': 'Racing',
      'intake_size': '28',
      'intake_brand': 'Ferrea',
      'exhaust_size': '24',
      'exhaust_brand': 'Ferrea',
      'ph_brands': 'Uma Racing, Faito, Racing Boy',
    },
  ];
} 