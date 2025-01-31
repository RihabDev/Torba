import 'package:flutter/material.dart';

class CropStatusCard extends StatelessWidget {
  final String cropName;
  final String growthStage;
  final String health;
  final String nextAction;

  const CropStatusCard({
    super.key,
    required this.cropName,
    required this.growthStage,
    required this.health,
    required this.nextAction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cropName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildInfoRow('Growth Stage:', growthStage),
            _buildInfoRow('Health:', health),
            _buildInfoRow('Next Action:', nextAction),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
}