import 'package:agri/widgets/add_plant_dialog.dart';
import 'package:flutter/material.dart';
import '../widgets/crop_status_card.dart';
import '../models/plant.dart';
import 'plant_detail_screen.dart';

class CropMonitoringScreen extends StatefulWidget {
  const CropMonitoringScreen({super.key});

  @override
  State<CropMonitoringScreen> createState() => _CropMonitoringScreenState();
}

class _CropMonitoringScreenState extends State<CropMonitoringScreen> {
  final List<Plant> plants = [
    Plant(
      id: '1',
      name: 'Wheat',
      growthStage: 'Flowering',
      health: 'Good',
      nextAction: 'Fertilization due in 2 days',
      images: [],
      lastUpdated: DateTime.now(),
    ),
    Plant(
      id: '2',
      name: 'Corn',
      growthStage: 'Vegetative',
      health: 'Excellent',
      nextAction: 'Irrigation scheduled tomorrow',
      images: [],
      lastUpdated: DateTime.now(),
    ),
    Plant(
      id: '3',
      name: 'Soybeans',
      growthStage: 'Seedling',
      health: 'Fair',
      nextAction: 'Pest control needed',
      images: [],
      lastUpdated: DateTime.now(),
    ),
  ];

  void _addNewPlant() {
    showDialog(
      context: context,
      builder: (context) => AddPlantDialog(
        onAdd: (String name, String growthStage, String nextAction) {
          setState(() {
            plants.add(
              Plant(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: name,
                growthStage: growthStage,
                health: 'Good',
                nextAction: nextAction,
                images: [],
                lastUpdated: DateTime.now(),
              ),
            );
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void _updatePlant(Plant updatedPlant) {
    setState(() {
      final index = plants.indexWhere((p) => p.id == updatedPlant.id);
      if (index != -1) {
        plants[index] = updatedPlant;
      }
    });
  }

  void _deletePlant(String id) {
    setState(() {
      plants.removeWhere((p) => p.id == id);
    });
  }

  void _openPlantDetails(Plant plant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlantDetailScreen(
          plant: plant,
          onUpdate: _updatePlant,
          onDelete: () => _deletePlant(plant.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Monitoring'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: plants.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: GestureDetector(
              onTap: () => _openPlantDetails(plants[index]),
              child: CropStatusCard(
                cropName: plants[index].name,
                growthStage: plants[index].growthStage,
                health: plants[index].health,
                nextAction: plants[index].nextAction,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewPlant,
        tooltip: 'Add Plant',
        child: const Icon(Icons.add),
      ),
    );
  }
}
