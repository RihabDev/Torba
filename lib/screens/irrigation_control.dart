import 'package:flutter/material.dart';

class IrrigationControlScreen extends StatelessWidget {
  const IrrigationControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Irrigation Control'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildIrrigationZoneCard(
            context,
            'Zone 1 - Wheat Field',
            'Active',
            '75%',
            '06:00 AM Tomorrow',
          ),
          const SizedBox(height: 16),
          _buildIrrigationZoneCard(
            context,
            'Zone 2 - Corn Field',
            'Inactive',
            '82%',
            '08:00 PM Today',
          ),
          const SizedBox(height: 16),
          _buildIrrigationZoneCard(
            context,
            'Zone 3 - Soybean Field',
            'Scheduled',
            '60%',
            '04:30 PM Today',
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

  Widget _buildIrrigationZoneCard(
    BuildContext context,
    String zoneName,
    String status,
    String moisture,
    String nextSchedule,
  ) {
    Color statusColor;
    IconData statusIcon;
    String actionLabel;

    switch (status) {
      case 'Active':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        actionLabel = "Pause Irrigation";
        break;
      case 'Inactive':
        statusColor = Colors.red;
        statusIcon = Icons.remove_circle;
        actionLabel = "Start Irrigation";
        break;
      case 'Scheduled':
        statusColor = Colors.orange;
        statusIcon = Icons.access_time;
        actionLabel = "Activate Now";
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help;
        actionLabel = "Unknown";
    }

    return GestureDetector(
      onTap: () {

        _showZoneDetails(context, zoneName, status, nextSchedule);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                statusIcon,
                color: statusColor,
                size: 32,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    zoneName,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('Status: $status', style: TextStyle(color: statusColor)),
                      const SizedBox(width: 16),
                      Text('Moisture: $moisture'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Next Schedule: $nextSchedule'),
                ],
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  _handleIrrigationAction(status);
                },
                child: Text(actionLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showZoneDetails(
    BuildContext context,
    String zoneName,
    String status,
    String nextSchedule,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Details for $zoneName', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 16),
              Text('Status: $status'),
              const SizedBox(height: 8),
              Text('Next Schedule: $nextSchedule'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _handleIrrigationAction(status);
                },
                child: Text(status == 'Active' ? 'Pause Irrigation' : 'Start Irrigation'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleIrrigationAction(String status) {
    if (status == 'Active') {
      print("Pausing irrigation...");
    } else if (status == 'Inactive') {
      print("Starting irrigation...");
    } else if (status == 'Scheduled') {
      print("Activating irrigation now...");
    }
  }
}
