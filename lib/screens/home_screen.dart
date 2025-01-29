import 'package:flutter/material.dart';
import '../widgets/feature_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Agriculture'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome, Farmer!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    FeatureCard(
                      title: 'Crop Monitoring',
                      icon: Icons.local_florist,
                      color: Colors.green,
                      onTap: () => Navigator.pushNamed(context, '/crop-monitoring'),
                    ),
                    FeatureCard(
                      title: 'Weather',
                      icon: Icons.cloud,
                      color: Colors.blue,
                      onTap: () => Navigator.pushNamed(context, '/weather'),
                    ),
                    FeatureCard(
                      title: 'Irrigation Control',
                      icon: Icons.water_drop,
                      color: Colors.lightBlue,
                      onTap: () => Navigator.pushNamed(context, '/irrigation'),
                    ),
                    FeatureCard(
                      title: 'Soil Analysis',
                      icon: Icons.landscape,
                      color: Colors.brown,
                      onTap: () => Navigator.pushNamed(context, '/soil-analysis'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}