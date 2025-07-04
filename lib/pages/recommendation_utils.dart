double calculateDisplacement(double bore, double stroke, int cylinders) {
  // Displacement formula: π/4 × bore^2 × stroke × cylinders
  // Convert mm to cm for bore and stroke
  final boreCm = bore / 10;
  final strokeCm = stroke / 10;
  return 3.1416 / 4 * boreCm * boreCm * strokeCm * cylinders * 10;
}

List<Map<String, String>> getCarbRecommendations(double displacement) {
  // Placeholder logic for carb recommendations with size
  return [
    {
      'purpose': 'Fuel Efficiency',
      'type': 'CV Carburetor',
      'size': '24',
      'jetting': 'Main: 90, Pilot: 35',
      'brand': 'Keihin',
    },
    {
      'purpose': 'Extreme Power (Racing)',
      'type': 'Flat Slide Carburetor',
      'size': '28',
      'jetting': 'Main: 120, Pilot: 40',
      'brand': 'Mikuni',
    },
    {
      'purpose': 'Daily Use',
      'type': 'Round Slide Carburetor',
      'size': '26',
      'jetting': 'Main: 100, Pilot: 38',
      'brand': 'OKO',
    },
  ];
}

List<Map<String, String>> getValveRecommendationsDetailed(double displacement) {
  // Detailed valve recommendations with intake and exhaust
  return [
    {
      'purpose': 'Daily Use',
      'intake_size': '24',
      'intake_brand': 'Supertech',
      'exhaust_size': '22',
      'exhaust_brand': 'Supertech',
    },
    {
      'purpose': 'Racing',
      'intake_size': '28',
      'intake_brand': 'Ferrea',
      'exhaust_size': '24',
      'exhaust_brand': 'Ferrea',
    },
  ];
} 