class Plant {
  final String id;
  final String name;
  final String growthStage;
  String health;
  String nextAction;
  final List<String> images;
  final DateTime lastUpdated;

  Plant({
    required this.id,
    required this.name,
    required this.growthStage,
    required this.health,
    required this.nextAction,
    required this.images,
    required this.lastUpdated,
  });
}