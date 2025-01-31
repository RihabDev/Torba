import 'package:flutter/material.dart';
import '../models/soil_parameter.dart';
import 'package:fl_chart/fl_chart.dart';

class SoilHistoryScreen extends StatelessWidget {
  final SoilParameter parameter;

  const SoilHistoryScreen({
    super.key,
    required this.parameter,
  });

  List<FlSpot> _getChartData() {
    final List<FlSpot> spots = [];
    parameter.historicalData.forEach((key, value) {
      final month = key.split('-')[1];
      spots.add(FlSpot(
        double.parse(month),
        double.parse(value),
      ));
    });
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    final chartData = _getChartData();

    return Scaffold(
      appBar: AppBar(
        title: Text('${parameter.name} History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Status',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow('Value:', parameter.displayValue),
                    _buildDetailRow('Status:', parameter.status),
                    _buildDetailRow('Updated:', parameter.timestamp.toString()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Historical Trend',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('Month ${value.toInt()}');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toStringAsFixed(1));
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: chartData,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}