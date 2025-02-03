import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/plant.dart';

class PlantDetailScreen extends StatefulWidget {
  final Plant plant;
  final Function(Plant) onUpdate;
  final Function() onDelete;

  const PlantDetailScreen({
    super.key,
    required this.plant,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isAnalyzing = false;
  late TextEditingController _nameController;
  late TextEditingController _growthStageController;
  late TextEditingController _nextActionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.plant.name);
    _growthStageController =
        TextEditingController(text: widget.plant.growthStage);
    _nextActionController =
        TextEditingController(text: widget.plant.nextAction);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _growthStageController.dispose();
    _nextActionController.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (photo != null) {
        setState(() => _isAnalyzing = true);
        //ai
        await Future.delayed(const Duration(seconds: 2));

        setState(() {
          widget.plant.health = _mockAnalyzeHealth();
          _isAnalyzing = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Plant health analysis completed!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      setState(() => _isAnalyzing = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Plant'),
        content: const Text('Are you sure you want to delete this plant?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onDelete();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Plant Details'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Plant Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _growthStageController,
                decoration: const InputDecoration(labelText: 'Growth Stage'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nextActionController,
                decoration: const InputDecoration(labelText: 'Next Action'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final updatedPlant = Plant(
                id: widget.plant.id,
                name: _nameController.text,
                growthStage: _growthStageController.text,
                health: widget.plant.health,
                nextAction: _nextActionController.text,
                images: widget.plant.images,
                lastUpdated: DateTime.now(),
              );
              widget.onUpdate(updatedPlant);
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  String _mockAnalyzeHealth() {
    final healthStates = ['Excellent', 'Good', 'Fair', 'Poor'];
    return healthStates[DateTime.now().millisecond % healthStates.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plant.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _showEditDialog,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _showDeleteConfirmation,
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                      'Plant Details',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow('Growth Stage:', widget.plant.growthStage),
                    _buildDetailRow('Health Status:', widget.plant.health),
                    _buildDetailRow('Next Action:', widget.plant.nextAction),
                    _buildDetailRow(
                      'Last Updated:',
                      widget.plant.lastUpdated.toString(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_isAnalyzing)
              const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Analyzing plant health...'),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isAnalyzing ? null : _takePicture,
        tooltip: 'Take Picture',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
