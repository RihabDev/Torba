import 'package:flutter/material.dart';
import '../models/soil_location.dart';

class SoilLocationScreen extends StatelessWidget {
  final Function(SoilLocation) onLocationSelected;

  const SoilLocationScreen({
    super.key,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Mock locations data
    final locations = [
      SoilLocation(
        id: '1',
        name: 'Field Section A',
        latitude: 40.7128,
        longitude: -74.0060,
        description: 'North-east corner of main field',
        lastTested: DateTime.now(),
      ),
      SoilLocation(
        id: '2',
        name: 'Field Section B',
        latitude: 40.7129,
        longitude: -74.0061,
        description: 'Central area of main field',
        lastTested: DateTime.now().subtract(const Duration(days: 7)),
      ),
      SoilLocation(
        id: '3',
        name: 'Field Section C',
        latitude: 40.7130,
        longitude: -74.0062,
        description: 'South-west corner of main field',
        lastTested: DateTime.now().subtract(const Duration(days: 14)),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(location.name),
              subtitle: Text(location.description),
              trailing: Text(
                'Last tested:\n${location.lastTested.toString().split(' ')[0]}',
                textAlign: TextAlign.right,
              ),
              onTap: () {
                onLocationSelected(location);
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add new location functionality
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add new location feature coming soon!'),
            ),
          );
        },
        child: const Icon(Icons.add_location),
      ),
    );
  }
}