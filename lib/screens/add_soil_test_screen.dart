import 'package:flutter/material.dart';
import '../models/soil_parameter.dart';

class AddSoilTestScreen extends StatefulWidget {
  final Function(List<SoilParameter>) onTestAdded;

  const AddSoilTestScreen({
    super.key,
    required this.onTestAdded,
  });

  @override
  State<AddSoilTestScreen> createState() => _AddSoilTestScreenState();
}

class _AddSoilTestScreenState extends State<AddSoilTestScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {
    'pH Level': TextEditingController(),
    'Nitrogen (N)': TextEditingController(),
    'Phosphorus (P)': TextEditingController(),
    'Potassium (K)': TextEditingController(),
    'Organic Matter': TextEditingController(),
  };

  final Map<String, String> units = {
    'pH Level': '',
    'Nitrogen (N)': 'mg/kg',
    'Phosphorus (P)': 'mg/kg',
    'Potassium (K)': 'mg/kg',
    'Organic Matter': '%',
  };

  bool _isProcessing = false;

  void _submitTest() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isProcessing = true);

      await Future.delayed(const Duration(seconds: 2));

      final List<SoilParameter> newParameters = [];
      controllers.forEach((name, controller) {
        final value = controller.text;
        final status = SoilParameter.determineStatus(name, double.parse(value));
        
        newParameters.add(SoilParameter(
          id: DateTime.now().toString(),
          name: name,
          value: value,
          unit: units[name]!,
          status: status,
          recommendation: _generateRecommendation(name, status),
          timestamp: DateTime.now(),
          historicalData: {'2024-03': value},
        ));
      });

      widget.onTestAdded(newParameters);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  String _generateRecommendation(String parameter, String status) {
    if (status == 'Optimal') return 'No action needed';
    if (status == 'Low') return 'Consider adding ${parameter.toLowerCase()} rich fertilizer';
    return 'Monitor levels closely';
  }

  @override
  void dispose() {
    controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Soil Test'),
      ),
      body: _isProcessing
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Processing soil test...'),
                ],
              ),
            )
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  ...controllers.entries.map((entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFormField(
                          controller: entry.value,
                          decoration: InputDecoration(
                            labelText: entry.key,
                            suffixText: units[entry.key],
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a value';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),
                      )),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitTest,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Submit Soil Test'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}