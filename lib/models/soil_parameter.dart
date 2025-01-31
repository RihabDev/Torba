class SoilParameter {
  final String id;
  final String name;
  final String value;
  final String unit;
  final String status;
  final String recommendation;
  final DateTime timestamp;
  final Map<String, dynamic> historicalData;

  SoilParameter({
    required this.id,
    required this.name,
    required this.value,
    required this.unit,
    required this.status,
    required this.recommendation,
    required this.timestamp,
    required this.historicalData,
  });

  String get displayValue => '$value $unit';

  static String determineStatus(String parameter, double value) {
    switch (parameter) {
      case 'pH Level':
        if (value >= 6.0 && value <= 7.0) return 'Optimal';
        if (value < 6.0) return 'Too Acidic';
        return 'Too Alkaline';
      case 'Nitrogen (N)':
        if (value < 40) return 'Low';
        if (value > 80) return 'High';
        return 'Optimal';
      default:
        return 'Unknown';
    }
  }
}
