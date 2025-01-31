import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/crop_status_card.dart';

class CropMonitoringScreen extends StatefulWidget {
  const CropMonitoringScreen({super.key});

  @override
  State<CropMonitoringScreen> createState() => _CropMonitoringScreenState();
}

class _CropMonitoringScreenState extends State<CropMonitoringScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePicture() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (photo != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Photo captured successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error accessing camera: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

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
        onPressed: _takePicture,
        tooltip: 'Take Picture',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
