import 'package:flutter/material.dart';
import 'feed_page.dart';
import '../widgets/feature_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text('Torba Tech', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.forum, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedPage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo & Branding with sleek design
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.green.shade300, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset('assets/images/logo.png',
                              fit: BoxFit.contain),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Torba Tech',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B5E20),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const Text(
                        'Smart Agriculture Solutions',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),

                // Welcome Section with glassmorphism effect
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.9),
                    border: Border.all(color: Colors.green.shade200, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.waving_hand_rounded,
                          color: Color(0xFF2E7D32),
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome, Farmer!',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Manage your farm efficiently with AI-driven tools and real-time insights.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Features Section with updated grid layout
                const Text(
                  'Features',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E20),
                  ),
                ),
                const SizedBox(height: 20),
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  children: [
                    FeatureCard(
                      title: 'Crop Monitoring',
                      icon: Icons.local_florist,
                      color: Colors.green.shade700,
                      onTap: () =>
                          Navigator.pushNamed(context, '/crop-monitoring'),
                    ),
                    FeatureCard(
                      title: 'Weather',
                      icon: Icons.cloud,
                      color: Colors.blue.shade600,
                      onTap: () => Navigator.pushNamed(context, '/weather'),
                    ),
                    FeatureCard(
                      title: 'Irrigation Control',
                      icon: Icons.water_drop,
                      color: Colors.lightBlue.shade700,
                      onTap: () => Navigator.pushNamed(context, '/irrigation'),
                    ),
                    FeatureCard(
                      title: 'Soil Analysis',
                      icon: Icons.landscape,
                      color: Colors.brown.shade700,
                      onTap: () =>
                          Navigator.pushNamed(context, '/soil-analysis'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
