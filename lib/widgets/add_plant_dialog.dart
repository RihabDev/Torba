import 'package:flutter/material.dart';

class AddPlantDialog extends StatefulWidget {
  final Function(String name, String growthStage, String nextAction) onAdd;

  const AddPlantDialog({
    super.key,
    required this.onAdd,
  });

  @override
  State<AddPlantDialog> createState() => _AddPlantDialogState();
}

class _AddPlantDialogState extends State<AddPlantDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _growthStageController = TextEditingController();
  final _nextActionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _growthStageController.dispose();
    _nextActionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Plant'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Plant Name',
                hintText: 'Enter plant name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a plant name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _growthStageController,
              decoration: const InputDecoration(
                labelText: 'Growth Stage',
                hintText: 'Enter growth stage',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a growth stage';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nextActionController,
              decoration: const InputDecoration(
                labelText: 'Next Action',
                hintText: 'Enter next action needed',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the next action';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onAdd(
                _nameController.text,
                _growthStageController.text,
                _nextActionController.text,
              );
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}