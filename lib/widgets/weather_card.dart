import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String temperature;
  final String condition;
  final String humidity;
  final String windSpeed;
  final String rainfall;

  const WeatherCard({
    Key? key,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.rainfall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      temperature,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      condition,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.wb_sunny,
                  size: 64,
                  color: Colors.orange,
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherInfo(Icons.water_drop, 'Humidity', humidity),
                _buildWeatherInfo(Icons.air, 'Wind', windSpeed),
                _buildWeatherInfo(Icons.umbrella, 'Rain', rainfall),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 4),
        Text(label),
        Text(value),
      ],
    );
  }
}