class SoilLocation {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String description;
  final DateTime lastTested;

  SoilLocation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.lastTested,
  });
}