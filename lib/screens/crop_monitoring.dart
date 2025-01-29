import 'package:flutter/material.dart';
import '../widgets/crop_status_card.dart';

class CropMonitoringScreen extends StatelessWidget {
  const CropMonitoringScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Monitoring'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          CropStatusCard(
            cropName: 'Wheat',
            growthStage: 'Flowering',
            health: 'Good',
            nextAction: 'Fertilization due in 2 days',
          ),
          SizedBox(height: 16),
          CropStatusCard(
            cropName: 'Corn',
            growthStage: 'Vegetative',
            health: 'Excellent',
            nextAction: 'Irrigation scheduled tomorrow',
          ),
          SizedBox(height: 16),
          CropStatusCard(
            cropName: 'Soybeans',
            growthStage: 'Seedling',
            health: 'Fair',
            nextAction: 'Pest control needed',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}