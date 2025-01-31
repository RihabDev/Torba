import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _city = "Tunis";
  String _temperature = "";
  String _description = "";
  String _weatherIcon = "";
  String _errorMessage = "";
  bool _isLoading = false;

  String _feelsLike = "";
  String _humidity = "";
  String _windSpeed = "";
  String _pressure = "";
  String _sunrise = "";
  String _sunset = "";

  final String apiKey = 'b509f209a7fa33f6d3bb87ece48ee564';

  Future<void> fetchWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    final String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$_city&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          _temperature = data['main']['temp'].toString();
          _feelsLike = data['main']['feels_like'].toString();
          _humidity = data['main']['humidity'].toString();
          _windSpeed = data['wind']['speed'].toString();
          _pressure = data['main']['pressure'].toString();
          _description = data['weather'][0]['description'];
          _weatherIcon =
              'https://openweathermap.org/img/wn/${data['weather'][0]['icon']}@2x.png';
          _sunrise = _formatTime(data['sys']['sunrise']);
          _sunset = _formatTime(data['sys']['sunset']);
          _errorMessage = "";
        });
      } else {
        setState(() {
          _errorMessage = "City not found. Please try again.";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to fetch data. Please check your connection.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _formatTime(int timestamp) {
    final DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Weather"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green.shade700,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (value) {
                    _city = value;
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Enter city name",
                    labelStyle: TextStyle(color: Colors.green.shade700),
                    filled: true,
                    fillColor: Colors.white70,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.green.shade700, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: fetchWeather,
                  icon: const Icon(Icons.cloud, color: Colors.white),
                  label: const Text(
                    "Get Weather",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                if (_isLoading)
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.green.shade700),
                  ),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (_temperature.isNotEmpty &&
                    !_isLoading &&
                    _errorMessage.isEmpty)
                  Column(
                    children: [
                      if (_weatherIcon.isNotEmpty)
                        Image.network(
                          _weatherIcon,
                          width: 100,
                          height: 100,
                        ),
                      Text(
                        _city,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                      Text(
                        '$_temperature°C',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                      Text(
                        _description,
                        style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              _weatherDetailRow("Feels Like", "$_feelsLike°C"),
                              _weatherDetailRow("Humidity", "$_humidity%"),
                              _weatherDetailRow(
                                  "Wind Speed", "$_windSpeed m/s"),
                              _weatherDetailRow("Pressure", "$_pressure hPa"),
                              _weatherDetailRow("Sunrise", _sunrise),
                              _weatherDetailRow("Sunset", _sunset),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _weatherDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 18)),
          Text(value,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
