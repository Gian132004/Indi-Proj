import 'dart:math';

double calculateDisplacement(double bore, double stroke, int cylinders) {
  // Displacement formula: π/4 × bore^2 × stroke × cylinders
  // Convert mm to cm for bore and stroke
  final boreCm = bore / 10;
  final strokeCm = stroke / 10;
  return 3.1416 / 4 * boreCm * boreCm * strokeCm * cylinders;
}



// Helper functions for dynamic calculations
double calculateRPMRange(double displacement, double strokeRatio, bool isTwoStroke) {
  if (isTwoStroke) {
    return 8000 + (1.0 / strokeRatio) * 2000; // 2-stroke RPM range
  } else {
    return 6000 + (1.0 / strokeRatio) * 1500; // 4-stroke RPM range
  }
}

double calculatePowerPotential(double displacement, double strokeRatio, bool isTwoStroke) {
  double basePotential = displacement / 1000; // Base on displacement
  double strokeFactor = isTwoStroke ? 1.2 : 1.0; // 2-stroke potential
  double ratioFactor = strokeRatio < 1.0 ? 1.3 : 1.0; // Oversquare advantage
  
  return (basePotential * strokeFactor * ratioFactor).clamp(0.1, 2.0);
}

String getEngineCharacteristic(double strokeRatio, double displacement) {
  if (strokeRatio < 0.8) return 'High-Revving';
  if (strokeRatio < 1.0) return 'Oversquare';
  if (strokeRatio < 1.2) return 'Square';
  if (strokeRatio < 1.5) return 'Undersquare';
  return 'Long-Stroke';
}

// Accurate carburetor sizing for different motorcycles
Map<String, int> calculateRealisticCarbSizes(double bore, double stroke, double displacement, bool isTwoStroke, double strokeRatio) {
  // Motorcycle-specific carburetor sizing based on real-world applications
  // Formula: carb_size = (bore * displacement_factor * engine_type_factor * application_factor) + offset
  
  // Displacement-based sizing (more accurate for motorcycles)
  double displacementFactor;
  if (displacement < 50) {
    displacementFactor = 0.65; // Very small engines (mopeds)
  } else if (displacement < 100) {
    displacementFactor = 0.70; // Small engines (Honda Wave, Yamaha Sniper)
  } else if (displacement < 150) {
    displacementFactor = 0.75; // Medium engines (Honda Click, Yamaha Mio)
  } else if (displacement < 250) {
    displacementFactor = 0.80; // Large engines (Honda PCX, Yamaha NMAX)
  } else if (displacement < 400) {
    displacementFactor = 0.85; // Big bikes (Honda CBR, Yamaha R1)
  } else {
    displacementFactor = 0.90; // Very large engines
  }
  
  // Engine type factor
  double engineTypeFactor = isTwoStroke ? 1.25 : 1.0; // 2-stroke needs 25% larger carbs
  
  // Stroke ratio factor
  double strokeRatioFactor = strokeRatio < 1.0 ? 1.05 : 1.0; // Oversquare engines can use slightly larger carbs
  
  // Calculate base size
  double baseSize = bore * displacementFactor * engineTypeFactor * strokeRatioFactor;
  
  // Calculate sizes for different applications
  Map<String, int> sizes = {};
  
  // Daily use - conservative sizing for reliability and fuel economy
  sizes['daily'] = (baseSize * 0.95).round().clamp(28, 50);
  
  // Performance - moderate upgrade for better power
  sizes['performance'] = (baseSize * 1.05).round().clamp(30, 55);
  
  // Racing - maximum flow for competition
  sizes['racing'] = (baseSize * 1.15).round().clamp(32, 60);
  
  // Economy - smaller for maximum fuel efficiency
  sizes['economy'] = (baseSize * 0.90).round().clamp(26, 45);
  
  // Standard - basic configuration
  sizes['standard'] = sizes['daily'] ?? 28;
  
  return sizes;
}

// Accurate jetting calculation for different motorcycles
Map<String, String> calculateRealisticJetting(Map<String, int> carbSizes, double displacement, bool isTwoStroke, double strokeRatio, double rpmRange) {
  Map<String, String> jetting = {};
  
  carbSizes.forEach((purpose, carbSize) {
    // Motorcycle-specific jetting calculation
    // Base formula: jet_size = carb_size * multiplier + displacement_factor
    
    // Displacement-based jetting factors
    double displacementMultiplier;
    if (displacement < 50) {
      displacementMultiplier = 0.15; // Very small engines
    } else if (displacement < 100) {
      displacementMultiplier = 0.18; // Small engines
    } else if (displacement < 150) {
      displacementMultiplier = 0.20; // Medium engines
    } else if (displacement < 250) {
      displacementMultiplier = 0.22; // Large engines
    } else {
      displacementMultiplier = 0.25; // Big bikes
    }
    
    double displacementFactor = displacement * displacementMultiplier;
    
    // Calculate base jet sizes
    int mainJet = (carbSize * 3.2 + displacementFactor).round();
    int pilotJet = (carbSize * 0.75 + displacementFactor * 0.08).round();
    int needleJet = (carbSize * 1.6 + displacementFactor * 0.15).round();
    
    // Adjust for engine type
    if (isTwoStroke) {
      mainJet = (mainJet * 1.18).round(); // 2-stroke needs 18% richer jetting
      pilotJet = (pilotJet * 1.12).round();
      needleJet = (needleJet * 1.12).round();
    }
    
    // Adjust for stroke ratio
    if (strokeRatio < 1.0) {
      mainJet = (mainJet * 1.04).round(); // Oversquare engines need slightly richer jetting
      pilotJet = (pilotJet * 1.02).round();
    }
    
    // Adjust for application
    double purposeMultiplier = 1.0;
    if (purpose == 'daily') purposeMultiplier = 0.97;
    if (purpose == 'performance') purposeMultiplier = 1.06;
    if (purpose == 'racing') purposeMultiplier = 1.14;
    if (purpose == 'economy') purposeMultiplier = 0.93;
    
    mainJet = (mainJet * purposeMultiplier).round();
    pilotJet = (pilotJet * purposeMultiplier).round();
    needleJet = (needleJet * purposeMultiplier).round();
    
    // Clamp to realistic ranges for motorcycles
    mainJet = mainJet.clamp(85, 180);
    pilotJet = pilotJet.clamp(15, 40);
    needleJet = needleJet.clamp(30, 90);
    
    jetting[purpose] = 'Main: #$mainJet, Pilot: #$pilotJet, Needle: #$needleJet';
  });
  
  return jetting;
}

// Realistic carburetor type selection
Map<String, String> determineRealisticCarbTypes(double displacement, bool isTwoStroke, double strokeRatio) {
  Map<String, String> types = {};
  
  if (displacement < 50) {
    types['standard'] = isTwoStroke ? 'Round Slide' : 'CV';
  } else if (displacement < 100) {
    types['daily'] = isTwoStroke ? 'Round Slide' : 'CV';
    types['performance'] = 'Flat Slide';
  } else {
    types['daily'] = isTwoStroke ? 'Round Slide' : 'CV';
    types['performance'] = 'Flat Slide';
    types['racing'] = 'Flat Slide';
    types['economy'] = 'CV';
  }
  
  return types;
}

// Accurate brand selection for different motorcycles
Map<String, String> selectRealisticBrands(double displacement, bool isTwoStroke, Map<String, int> carbSizes) {
  Map<String, String> brands = {};
  
  if (displacement < 50) {
    // Very small engines (mopeds)
    brands['standard'] = isTwoStroke ? 'OKO' : 'Keihin';
  } else if (displacement < 100) {
    // Small engines (Honda Wave, Yamaha Sniper 115)
    brands['daily'] = isTwoStroke ? 'OKO' : 'Keihin';
    brands['performance'] = 'Mikuni';
    brands['racing'] = 'Mikuni';
    brands['economy'] = 'Keihin';
  } else if (displacement < 150) {
    // Medium engines (Honda Click, Yamaha Mio)
    brands['daily'] = isTwoStroke ? 'OKO' : 'Keihin';
    brands['performance'] = 'Mikuni';
    brands['racing'] = 'Mikuni';
    brands['economy'] = 'Keihin';
  } else if (displacement < 250) {
    // Large engines (Honda PCX, Yamaha NMAX)
    brands['daily'] = isTwoStroke ? 'OKO' : 'Keihin';
    brands['performance'] = 'Mikuni';
    brands['racing'] = 'Mikuni';
    brands['economy'] = 'Keihin';
  } else if (displacement < 400) {
    // Big bikes (Honda CBR, Yamaha R1)
    brands['daily'] = 'Keihin';
    brands['performance'] = 'Mikuni';
    brands['racing'] = 'Mikuni';
    brands['economy'] = 'Keihin';
  } else {
    // Very large engines
    brands['daily'] = 'Keihin';
    brands['performance'] = 'Mikuni';
    brands['racing'] = 'Mikuni';
    brands['economy'] = 'Keihin';
  }
  
  return brands;
}

// Create realistic recommendation
Map<String, String> createRealisticRecommendation({
  required String purpose,
  required int carbSize,
  required String jetting,
  required String carbType,
  required String brand,
  required bool isTwoStroke,
  required double displacement,
  required String engineCharacteristic,
  required double rpmRange,
}) {
  String notes = generateRealisticNotes(purpose, isTwoStroke, displacement, engineCharacteristic, rpmRange);
  String tuningTips = generateRealisticTuningTips(purpose, isTwoStroke, displacement, engineCharacteristic);
  String airFilter = generateRealisticAirFilter(purpose, isTwoStroke, displacement);
  String exhaust = generateRealisticExhaust(purpose, isTwoStroke, displacement, engineCharacteristic);
  
  return {
    'purpose': purpose,
    'type': carbType,
    'size': '${carbSize}mm',
    'jetting': jetting,
    'brand': brand,
    'ph_brands': getRealisticPHBrands(brand, isTwoStroke, displacement),
    'notes': notes,
    'tuning_tips': tuningTips,
    'air_filter': airFilter,
    'exhaust': exhaust,
    'engine_characteristic': engineCharacteristic,
    'rpm_range': '${rpmRange.round()} RPM',
  };
}

String generateRealisticNotes(String purpose, bool isTwoStroke, double displacement, String engineCharacteristic, double rpmRange) {
  String baseNote = '';
  
  if (purpose == 'Daily Use') {
    baseNote = isTwoStroke 
      ? 'Optimized for reliability and fuel economy. Good for daily commuting in Philippine traffic.'
      : 'Balanced performance for everyday use. Smooth power delivery and good fuel efficiency.';
  } else if (purpose == 'Performance') {
    baseNote = isTwoStroke
      ? 'Enhanced power output while maintaining reliability. Good for spirited riding and modifications.'
      : 'Improved throttle response and power delivery. Suitable for performance modifications.';
  } else if (purpose == 'Racing') {
    baseNote = isTwoStroke
      ? 'Maximum power output for competition use. Requires precise tuning and regular maintenance.'
      : 'High-performance setup for racing applications. Demands professional tuning and maintenance.';
  } else if (purpose == 'Economy') {
    baseNote = 'Maximum fuel efficiency setup. Optimized for long-distance commuting and fuel savings.';
  } else {
    baseNote = 'Standard configuration suitable for general use.';
  }
  
  return '$baseNote Engine characteristic: $engineCharacteristic. RPM range: ${rpmRange.round()} RPM.';
}

String generateRealisticTuningTips(String purpose, bool isTwoStroke, double displacement, String engineCharacteristic) {
  String tips = '';
  
  if (purpose == 'Daily Use') {
    tips = isTwoStroke 
      ? 'Start with stock jetting. Adjust main jet ±2 sizes based on spark plug color. Use quality 2T oil at 25:1 ratio.'
      : 'Fine-tune idle mixture screw for smooth idle. Check spark plug color after 50km of mixed riding.';
  } else if (purpose == 'Performance') {
    tips = isTwoStroke
      ? 'Use wideband O2 sensor for precise tuning. Monitor EGT (exhaust gas temperature) - keep below 1200°F.'
      : 'Dyno tune recommended for optimal performance. Monitor AFR (air-fuel ratio) - target 12.8-13.2:1 at WOT.';
  } else if (purpose == 'Racing') {
    tips = isTwoStroke
      ? 'Professional dyno tuning required. Monitor EGT continuously - keep below 1200°F. Use racing fuel.'
      : 'Professional dyno tuning essential. Monitor AFR continuously - target 12.5-13.0:1 at WOT.';
  } else if (purpose == 'Economy') {
    tips = 'Lean mixture for fuel economy. Monitor engine temperature - avoid overheating.';
  }
  
  return tips;
}

String generateRealisticAirFilter(String purpose, bool isTwoStroke, double displacement) {
  if (purpose == 'Daily Use') {
    return isTwoStroke ? 'High-flow foam filter (K&N, Uni)' : 'Paper filter or mild high-flow (K&N)';
  } else if (purpose == 'Performance') {
    return 'High-flow filter (K&N, BMC, Uni)';
  } else if (purpose == 'Racing') {
    return 'High-flow filter with velocity stack (K&N, BMC)';
  } else if (purpose == 'Economy') {
    return 'Stock paper filter for maximum filtration';
  }
  return 'Standard air filter';
}

String generateRealisticExhaust(String purpose, bool isTwoStroke, double displacement, String engineCharacteristic) {
  if (purpose == 'Daily Use') {
    return isTwoStroke ? 'Stock or mild expansion chamber' : 'Stock exhaust or mild aftermarket';
  } else if (purpose == 'Performance') {
    return isTwoStroke ? 'Performance expansion chamber' : 'Performance exhaust system';
  } else if (purpose == 'Racing') {
    return isTwoStroke ? 'Tuned expansion chamber for your RPM range' : 'Full exhaust system with header';
  } else if (purpose == 'Economy') {
    return 'Stock exhaust system';
  }
  return 'Standard exhaust';
}

String getRealisticPHBrands(String brand, bool isTwoStroke, double displacement) {
  if (brand == 'Keihin') {
    return 'Keihin, OKO, Faito, Mikuni';
  } else if (brand == 'Mikuni') {
    return 'Mikuni, Uma Racing, Racing Boy, Keihin';
  } else if (brand == 'OKO') {
    return 'OKO, Keihin, Faito, Mikuni';
  }
  return 'Keihin, OKO, Faito, Mikuni, Uma Racing, Racing Boy';
}

Map<String, String> calculateJetting(double displacement, Map<String, dynamic> carbSizes, bool isTwoStroke, double strokeRatio, double rpmRange) {
  Map<String, String> jetting = {};
  
  carbSizes.forEach((purpose, carbSize) {
    // Realistic jetting calculations based on Philippine market experience
    
    // Base jetting calculation based on carburetor size (more accurate for real-world)
    double carbSizeFactor = carbSize * 2.0; // Carb size is the primary factor
    double displacementFactor = displacement * 0.3; // Secondary factor
    
    // Calculate base jet sizes
    double mainBase = carbSizeFactor + displacementFactor;
    double pilotBase = carbSizeFactor * 0.25 + displacementFactor * 0.1;
    double needleBase = carbSizeFactor * 0.4 + displacementFactor * 0.2;
    
    // Adjust for engine type (2-stroke needs richer jetting)
    double engineTypeFactor = isTwoStroke ? 1.25 : 1.0;
    
    // Adjust for stroke ratio (oversquare engines need richer jetting)
    double strokeRatioFactor = strokeRatio < 1.0 ? 1.1 : 1.0;
    
    // Adjust for RPM range
    double rpmFactor = rpmRange > 8000 ? 1.05 : 1.0;
    
    // Adjust for application purpose (Philippine market experience)
    double purposeMultiplier = 1.0;
    if (purpose == 'daily') purposeMultiplier = 0.95;
    if (purpose == 'performance') purposeMultiplier = 1.08;
    if (purpose == 'racing') purposeMultiplier = 1.15;
    if (purpose == 'economy') purposeMultiplier = 0.9;
    if (purpose == 'standard') purposeMultiplier = 0.95;
    
    // Calculate final jet sizes
    int mainJet = (mainBase * engineTypeFactor * strokeRatioFactor * rpmFactor * purposeMultiplier).round();
    int pilotJet = (pilotBase * engineTypeFactor * strokeRatioFactor * rpmFactor * purposeMultiplier).round();
    int needleJet = (needleBase * engineTypeFactor * strokeRatioFactor * rpmFactor * purposeMultiplier).round();
    
    // Realistic ranges based on Philippine market experience
    // 24mm carb: Main #100-140, Pilot #20-30, Needle #40-60
    // 26mm carb: Main #110-150, Pilot #22-32, Needle #45-65
    // 28mm carb: Main #120-160, Pilot #25-35, Needle #50-70
    // 30mm carb: Main #130-170, Pilot #28-38, Needle #55-75
    
    // Clamp to realistic ranges based on carburetor size
    int minMain = (carbSize * 3.5).round();
    int maxMain = (carbSize * 5.5).round();
    int minPilot = (carbSize * 0.7).round();
    int maxPilot = (carbSize * 1.2).round();
    int minNeedle = (carbSize * 1.5).round();
    int maxNeedle = (carbSize * 2.5).round();
    
    mainJet = mainJet.clamp(minMain, maxMain);
    pilotJet = pilotJet.clamp(minPilot, maxPilot);
    needleJet = needleJet.clamp(minNeedle, maxNeedle);
    
    // Ensure realistic ranges for Philippine market
    mainJet = mainJet.clamp(90, 200);
    pilotJet = pilotJet.clamp(18, 45);
    needleJet = needleJet.clamp(35, 100);
    
    jetting[purpose] = 'Main: #$mainJet, Pilot: #$pilotJet, Needle: #$needleJet';
  });
  
  return jetting;
}

Map<String, String> determineCarbTypes(double displacement, double strokeRatio, bool isTwoStroke, double powerPotential) {
  Map<String, String> types = {};
  
  // Determine carb types based on engine characteristics
  if (displacement < 50) {
    types['standard'] = isTwoStroke ? 'Round Slide' : 'CV';
  } else if (displacement < 150) {
    types['daily'] = isTwoStroke ? 'Round Slide' : 'CV';
    types['performance'] = 'Flat Slide';
  } else {
    types['daily'] = isTwoStroke ? 'Round Slide' : 'CV';
    types['performance'] = 'Flat Slide';
    types['racing'] = 'Flat Slide';
    types['economy'] = 'CV';
  }
  
  return types;
}

Map<String, String> selectBrands(double displacement, bool isTwoStroke, double powerPotential) {
  Map<String, String> brands = {};
  
  // Philippine market brand selection based on common availability and popularity
  if (displacement < 50) {
    // Small engines (mopeds, small scooters) - common in PH
    brands['standard'] = isTwoStroke ? 'OKO' : 'Keihin';
  } else if (displacement < 100) {
    // Small motorcycles (Honda Wave, Yamaha Sniper 115, etc.)
    brands['daily'] = isTwoStroke ? 'OKO' : 'Keihin';
    brands['performance'] = powerPotential > 0.6 ? 'Mikuni' : 'Keihin';
  } else if (displacement < 150) {
    // Medium motorcycles (Honda Click, Yamaha Mio, etc.)
    brands['daily'] = isTwoStroke ? 'OKO' : 'Keihin';
    brands['performance'] = powerPotential > 0.6 ? 'Mikuni' : 'Keihin';
  } else if (displacement < 250) {
    // Large motorcycles (Honda PCX, Yamaha NMAX, etc.)
    brands['daily'] = isTwoStroke ? 'OKO' : 'Keihin';
    brands['performance'] = powerPotential > 0.7 ? 'Mikuni' : 'Keihin';
    brands['racing'] = 'Mikuni';
    brands['economy'] = 'Keihin';
  } else {
    // Very large motorcycles (Honda CB150R, Yamaha R15, etc.)
    brands['daily'] = isTwoStroke ? 'OKO' : 'Keihin';
    brands['performance'] = powerPotential > 0.8 ? 'Mikuni' : 'Keihin';
    brands['racing'] = 'Mikuni';
    brands['economy'] = 'Keihin';
  }
  
  return brands;
}

Map<String, String> createRecommendation({
  required String purpose,
  required int carbSize,
  required String jetting,
  required String carbType,
  required String brand,
  required bool isTwoStroke,
  required double displacement,
  required String engineCharacteristic,
  required double rpmRange,
}) {
  // Generate dynamic notes based on engine characteristics
  String notes = generateNotes(purpose, isTwoStroke, displacement, engineCharacteristic, rpmRange);
  String tuningTips = generateTuningTips(purpose, isTwoStroke, displacement, engineCharacteristic);
  String airFilter = generateAirFilterRecommendation(purpose, isTwoStroke, displacement);
  String exhaust = generateExhaustRecommendation(purpose, isTwoStroke, displacement, engineCharacteristic);
  
  return {
    'purpose': purpose,
    'type': carbType,
    'size': '${carbSize}mm',
    'jetting': jetting,
    'brand': brand,
    'ph_brands': getPHBrands(brand, isTwoStroke, displacement),
    'notes': notes,
    'tuning_tips': tuningTips,
    'air_filter': airFilter,
    'exhaust': exhaust,
    'engine_characteristic': engineCharacteristic,
    'rpm_range': '${rpmRange.round()} RPM',
  };
}

String generateNotes(String purpose, bool isTwoStroke, double displacement, String engineCharacteristic, double rpmRange) {
  String baseNote = '';
  
  if (purpose == 'Daily Use') {
    baseNote = isTwoStroke 
      ? 'Optimized for reliability and fuel economy. Good for commuting and daily riding in Philippine traffic conditions.'
      : 'Balanced performance for everyday use. Smooth power delivery and good fuel efficiency. Popular for daily commuting in Metro Manila and provinces.';
  } else if (purpose == 'Performance') {
    baseNote = isTwoStroke
      ? 'Enhanced power output while maintaining reliability. Good for spirited riding. Popular for underbone modifications in Philippine racing scene.'
      : 'Improved throttle response and power delivery. Suitable for aggressive riding. Common for big bike modifications in Philippine performance scene.';
  } else if (purpose == 'Racing') {
    baseNote = isTwoStroke
      ? 'Maximum power output for competition use. Requires precise tuning and maintenance. Popular for drag racing and circuit racing in Philippines.'
      : 'High-performance setup for racing applications. Demands regular maintenance and tuning. Common for track day and racing events in Philippines.';
  } else if (purpose == 'Economy') {
    baseNote = 'Maximum fuel efficiency setup. Optimized for long-distance commuting in Philippine provinces. Good for fuel cost savings.';
  } else {
    baseNote = 'Standard configuration suitable for general use. Available at local motorcycle shops throughout Philippines.';
  }
  
  return '$baseNote Engine characteristic: $engineCharacteristic. RPM range: ${rpmRange.round()} RPM.';
}

String generateTuningTips(String purpose, bool isTwoStroke, double displacement, String engineCharacteristic) {
  String tips = '';
  
  if (purpose == 'Daily Use') {
    tips = isTwoStroke 
      ? 'Start with stock jetting. Adjust main jet ±2 sizes based on spark plug color. Use quality 2T oil at 25:1 ratio. Monitor engine temperature. Available at local motorcycle shops.'
      : 'Fine-tune idle mixture screw for smooth idle. Check spark plug color after 50km of mixed riding. Monitor fuel consumption. Common in Philippine traffic conditions.';
  } else if (purpose == 'Performance') {
    tips = isTwoStroke
      ? 'Use wideband O2 sensor for precise tuning (available at performance shops). Monitor EGT (exhaust gas temperature) - keep below 1200°F. Check plug color frequently. Popular for underbone racing.'
      : 'Dyno tune recommended for optimal performance (available at major cities). Monitor AFR (air-fuel ratio) - target 12.8-13.2:1 at WOT. Regular valve adjustments. Common for big bike modifications.';
  } else if (purpose == 'Racing') {
    tips = isTwoStroke
      ? 'Professional dyno tuning required (racing shops in Metro Manila). Monitor EGT continuously - keep below 1200°F. Use racing fuel (available at select stations). Frequent plug changes. Popular for drag racing and circuit racing.'
      : 'Professional dyno tuning essential (racing shops in Metro Manila). Monitor AFR continuously - target 12.5-13.0:1 at WOT. Use racing fuel. Frequent maintenance. Common for track day and racing events.';
  } else if (purpose == 'Economy') {
    tips = 'Lean mixture for fuel economy. Monitor engine temperature - avoid overheating. Regular air filter maintenance. Ideal for long-distance commuting in Philippine provinces.';
  }
  
  if (engineCharacteristic.contains('High-Revving') || engineCharacteristic.contains('Oversquare')) {
    tips += ' High-revving engine requires careful jetting at high RPM. Monitor for lean conditions at peak power. Common in Philippine racing scene.';
  }
  
  return tips;
}

String generateAirFilterRecommendation(String purpose, bool isTwoStroke, double displacement) {
  if (purpose == 'Daily Use') {
    return isTwoStroke ? 'High-flow foam filter (K&N, Uni, Racing Boy)' : 'Paper filter or mild high-flow (K&N, Racing Boy)';
  } else if (purpose == 'Performance') {
    return 'High-flow filter (K&N, BMC, Uni, Racing Boy, Uma Racing)';
  } else if (purpose == 'Racing') {
    return 'High-flow filter with velocity stack (K&N, BMC, Uma Racing)';
  } else if (purpose == 'Economy') {
    return 'Stock paper filter for maximum filtration (good for dusty Philippine roads)';
  }
  return 'Standard air filter (available at local motorcycle shops)';
}

String generateExhaustRecommendation(String purpose, bool isTwoStroke, double displacement, String engineCharacteristic) {
  if (purpose == 'Daily Use') {
    return isTwoStroke ? 'Stock or mild expansion chamber (Racing Boy, Faito)' : 'Stock exhaust or mild aftermarket (Racing Boy, Faito)';
  } else if (purpose == 'Performance') {
    return isTwoStroke ? 'Performance expansion chamber (Uma Racing, Racing Boy)' : 'Performance exhaust system (Uma Racing, Racing Boy)';
  } else if (purpose == 'Racing') {
    return isTwoStroke ? 'Tuned expansion chamber for your RPM range (Uma Racing, custom)' : 'Full exhaust system with header (Uma Racing, custom)';
  } else if (purpose == 'Economy') {
    return 'Stock exhaust system (good for fuel efficiency and noise compliance)';
  }
  return 'Standard exhaust (available at local motorcycle shops)';
}

String getPHBrands(String brand, bool isTwoStroke, double displacement) {
  // Philippine market brands - commonly available in local shops
  if (brand == 'Keihin') {
    return 'Keihin, OKO, Faito, Mikuni, Uma Racing';
  } else if (brand == 'Mikuni') {
    return 'Mikuni, Uma Racing, Racing Boy, Keihin, Faito';
  } else if (brand == 'OKO') {
    return 'OKO, Keihin, Faito, Mikuni, Uma Racing';
  }
  return 'Keihin, OKO, Faito, Mikuni, Uma Racing, Racing Boy';
}

// Valve recommendation helper functions
Map<String, dynamic> calculateValveSizes(double bore, double strokeRatio, double displacement, double powerPotential) {
  // Base valve sizing factors
  double baseIntakeFactor = 0.35; // Standard intake valve ratio
  double baseExhaustFactor = 0.30; // Standard exhaust valve ratio
  
  // Adjust for stroke ratio (oversquare engines can use larger valves)
  double ratioMultiplier = strokeRatio < 1.0 ? 1.15 : 1.0;
  
  // Adjust for power potential
  double powerMultiplier = powerPotential > 1.0 ? 1.1 : 1.0;
  
  // Calculate base sizes
  int baseIntake = (bore * baseIntakeFactor * ratioMultiplier * powerMultiplier).round();
  int baseExhaust = (bore * baseExhaustFactor * ratioMultiplier * powerMultiplier).round();
  
  // Calculate sizes for different applications
  Map<String, dynamic> sizes = {};
  
  // Standard/Daily use
  sizes['standard'] = {
    'intake': baseIntake.clamp(20, 35),
    'exhaust': baseExhaust.clamp(18, 30),
  };
  
  sizes['daily'] = {
    'intake': (baseIntake * 1.0).round().clamp(22, 38),
    'exhaust': (baseExhaust * 1.0).round().clamp(20, 32),
  };
  
  // Performance
  sizes['performance'] = {
    'intake': (baseIntake * 1.1).round().clamp(25, 42),
    'exhaust': (baseExhaust * 1.1).round().clamp(22, 36),
  };
  
  // Racing
  sizes['racing'] = {
    'intake': (baseIntake * 1.2).round().clamp(28, 45),
    'exhaust': (baseExhaust * 1.15).round().clamp(25, 38),
  };
  
  // Economy
  sizes['economy'] = {
    'intake': (baseIntake * 0.95).round().clamp(20, 32),
    'exhaust': (baseExhaust * 0.95).round().clamp(18, 28),
  };
  
  return sizes;
}

Map<String, String> determineValveTypes(double displacement, double strokeRatio, double powerPotential) {
  Map<String, String> types = {};
  
  // Determine valve types based on application and engine characteristics
  if (displacement < 100) {
    types['standard'] = 'Standard Steel';
  } else if (displacement < 250) {
    types['daily'] = 'Standard Steel';
    types['performance'] = powerPotential > 0.6 ? 'Performance Steel' : 'Standard Steel';
  } else {
    types['daily'] = 'Standard Steel';
    types['performance'] = 'Performance Steel';
    types['racing'] = 'Titanium';
    types['economy'] = 'Standard Steel';
  }
  
  return types;
}

Map<String, String> selectValveBrands(double displacement, double powerPotential) {
  Map<String, String> brands = {};
  
  // Philippine market valve brands - commonly available
  if (displacement < 100) {
    // Small engines (common in PH)
    brands['standard'] = 'Supertech';
  } else if (displacement < 150) {
    // Medium engines (Honda Wave, Yamaha Sniper, etc.)
    brands['daily'] = 'Supertech';
    brands['performance'] = powerPotential > 0.6 ? 'Ferrea' : 'Supertech';
  } else if (displacement < 250) {
    // Large engines (Honda Click, Yamaha Mio, etc.)
    brands['daily'] = 'Supertech';
    brands['performance'] = powerPotential > 0.7 ? 'Ferrea' : 'Supertech';
    brands['racing'] = 'Ferrea';
    brands['economy'] = 'Supertech';
  } else {
    // Very large engines (big bikes)
    brands['daily'] = 'Supertech';
    brands['performance'] = powerPotential > 0.8 ? 'Ferrea' : 'Supertech';
    brands['racing'] = 'Ferrea';
    brands['economy'] = 'Supertech';
  }
  
  return brands;
}

Map<String, String> createValveRecommendation({
  required String purpose,
  required int intakeSize,
  required int exhaustSize,
  required String valveType,
  required String brand,
  required double displacement,
  required String engineCharacteristic,
  required double rpmRange,
}) {
  // Generate dynamic notes based on valve characteristics
  String notes = generateValveNotes(purpose, displacement, engineCharacteristic, rpmRange);
  String maintenanceTips = generateValveMaintenanceTips(purpose, valveType, displacement);
  String installationTips = generateValveInstallationTips(purpose, valveType, displacement);
  
  return {
    'purpose': purpose,
    'intake_size': '${intakeSize}mm',
    'intake_brand': brand,
    'exhaust_size': '${exhaustSize}mm',
    'exhaust_brand': brand,
    'valve_type': valveType,
    'ph_brands': getValvePHBrands(brand, displacement),
    'notes': notes,
    'maintenance_tips': maintenanceTips,
    'installation_tips': installationTips,
    'engine_characteristic': engineCharacteristic,
    'rpm_range': '${rpmRange.round()} RPM',
  };
}

String generateValveNotes(String purpose, double displacement, String engineCharacteristic, double rpmRange) {
  String baseNote = '';
  
  if (purpose == 'Daily Use') {
    baseNote = 'Reliable valve setup for everyday use. Good durability and reasonable performance.';
  } else if (purpose == 'Performance') {
    baseNote = 'Enhanced valve setup for improved performance. Better flow characteristics and durability.';
  } else if (purpose == 'Racing') {
    baseNote = 'High-performance valve setup for racing applications. Maximum flow and lightweight construction.';
  } else if (purpose == 'Economy') {
    baseNote = 'Economy-focused valve setup. Optimized for fuel efficiency and long service life.';
  } else {
    baseNote = 'Standard valve configuration suitable for general use.';
  }
  
  return '$baseNote Engine characteristic: $engineCharacteristic. RPM range: ${rpmRange.round()} RPM.';
}

String generateValveMaintenanceTips(String purpose, String valveType, double displacement) {
  String tips = '';
  
  if (purpose == 'Daily Use') {
    tips = 'Check valve clearance every 10,000km. Use quality valve spring oil (available at local shops). Monitor valve seat wear. Common for daily commuting in Philippine traffic.';
  } else if (purpose == 'Performance') {
    tips = 'Check valve clearance every 5,000km. Use performance valve spring oil. Monitor valve guide wear. Regular valve seat inspection. Popular for underbone modifications.';
  } else if (purpose == 'Racing') {
    tips = 'Check valve clearance every 1,000km. Use racing valve spring oil. Frequent valve guide inspection. Monitor valve seat condition closely. Common in Philippine racing scene.';
  } else if (purpose == 'Economy') {
    tips = 'Check valve clearance every 15,000km. Use standard valve spring oil. Monitor for valve seat recession. Ideal for long-distance commuting in provinces.';
  }
  
  if (valveType.contains('Titanium')) {
    tips += ' Titanium valves require special handling and frequent inspection. Available at high-end performance shops in Metro Manila.';
  }
  
  return tips;
}

String generateValveInstallationTips(String purpose, String valveType, double displacement) {
  String tips = '';
  
  if (purpose == 'Daily Use') {
    tips = 'Standard installation procedure. Use factory torque specifications. Check valve clearance after installation. Available at local motorcycle shops.';
  } else if (purpose == 'Performance') {
    tips = 'Professional installation recommended. Use performance valve springs. Check valve clearance and spring pressure. Available at performance shops in major cities.';
  } else if (purpose == 'Racing') {
    tips = 'Professional installation essential. Use racing valve springs and retainers. Check spring pressure and valve clearance. Available at racing shops in Metro Manila.';
  } else if (purpose == 'Economy') {
    tips = 'Standard installation procedure. Use economy valve springs. Check valve clearance after installation. Available at local motorcycle shops.';
  }
  
  if (valveType.contains('Titanium')) {
    tips += ' Titanium valves require special installation tools and procedures. Available at high-end performance shops in Metro Manila.';
  }
  
  return tips;
}

String getValvePHBrands(String brand, double displacement) {
  // Philippine market valve brands - commonly available in local shops
  if (brand == 'Supertech') {
    return 'Supertech, Faito, Uma Racing, Racing Boy, Ferrea';
  } else if (brand == 'Ferrea') {
    return 'Ferrea, Supertech, Faito, Uma Racing, Racing Boy';
  }
  return 'Supertech, Faito, Uma Racing, Racing Boy, Ferrea';
}

 