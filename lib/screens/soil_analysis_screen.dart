import 'package:flutter/material.dart';
import '../widgets/soil_parameter_card.dart';
import '../models/soil_parameter.dart';
import '../models/soil_location.dart';
import 'soil_history_screen.dart';
import 'soil_location_screen.dart';
import 'add_soil_test_screen.dart';

class SoilAnalysisScreen extends StatefulWidget {
  const SoilAnalysisScreen({super.key});

  @override
  State<SoilAnalysisScreen> createState() => _SoilAnalysisScreenState();
}

class _SoilAnalysisScreenState extends State<SoilAnalysisScreen> {
  late List<SoilParameter> parameters;
  late SoilLocation currentLocation;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    // Mock data initialization
    currentLocation = SoilLocation(
      id: '1',
      name: 'Field Section A',
      latitude: 40.7128,
      longitude: -74.0060,
      description: 'North-east corner of main field',
      lastTested: DateTime.now(),
    );

    parameters = [
      SoilParameter(
        id: '1',
        name: 'pH Level',
        value: '6.5',
        unit: '',
        status: 'Optimal',
        recommendation: 'No action needed',
        timestamp: DateTime.now(),
        historicalData: {'2024-01': '6.3', '2024-02': '6.4', '2024-03': '6.5'},
      ),
      SoilParameter(
        id: '2',
        name: 'Nitrogen (N)',
        value: '45',
        unit: 'mg/kg',
        status: 'Low',
        recommendation: 'Apply nitrogen-rich fertilizer',
        timestamp: DateTime.now(),
        historicalData: {'2024-01': '40', '2024-02': '42', '2024-03': '45'},
      ),
      // Add more parameters...
    ];
  }

  void _addNewSoilTest() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSoilTestScreen(
          onTestAdded: (newParameters) {
            setState(() {
              parameters = newParameters;
            });
          },
        ),
      ),
    );
  }

  void _viewHistory(SoilParameter parameter) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SoilHistoryScreen(parameter: parameter),
      ),
    );
  }

  void _changeLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SoilLocationScreen(
          onLocationSelected: (location) {
            setState(() {
              currentLocation = location;
              isLoading = true;
            });
            // Simulate loading new data
            Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                isLoading = false;
              });
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soil Analysis'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: _changeLocation,
            tooltip: 'Change Location',
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Current Location'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${currentLocation.name}'),
                      Text('Description: ${currentLocation.description}'),
                      Text('Last Tested: ${currentLocation.lastTested.toString()}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
            tooltip: 'Location Info',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: parameters.length,
              itemBuilder: (context, index) {
                final parameter = parameters[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: GestureDetector(
                    onTap: () => _viewHistory(parameter),
                    child: SoilParameterCard(
                      parameter: parameter.name,
                      value: parameter.displayValue,
                      status: parameter.status,
                      recommendation: parameter.recommendation,
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewSoilTest,
        label: const Text('New Soil Test'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}