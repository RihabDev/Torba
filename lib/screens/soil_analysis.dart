import 'package:flutter/material.dart';
import '../widgets/soil_parameter_card.dart';

class SoilAnalysisScreen extends StatelessWidget {
  const SoilAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soil Analysis'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          SoilParameterCard(
            parameter: 'pH Level',
            value: '6.5',
            status: 'Optimal',
            recommendation: 'No action needed',
          ),
          SizedBox(height: 16),
          SoilParameterCard(
            parameter: 'Nitrogen (N)',
            value: '45 mg/kg',
            status: 'Low',
            recommendation: 'Apply nitrogen-rich fertilizer',
          ),
          SizedBox(height: 16),
          SoilParameterCard(
            parameter: 'Phosphorus (P)',
            value: '30 mg/kg',
            status: 'Medium',
            recommendation: 'Monitor levels',
          ),
          SizedBox(height: 16),
          SoilParameterCard(
            parameter: 'Potassium (K)',
            value: '180 mg/kg',
            status: 'High',
            recommendation: 'Reduce potassium application',
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