import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
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
          _description = data['weather'][0]['description'];
          _weatherIcon =
              'https://openweathermap.org/img/wn/${data['weather'][0]['icon']}@2x.png';
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

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Weather"),
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
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  _city = value;
                },
                style: TextStyle(color: Colors.black), 
                decoration: InputDecoration(
                  labelText: "Enter city name",
                  labelStyle: TextStyle(color: Colors.green.shade700),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green.shade700, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: fetchWeather,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700, 
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Get Weather",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              if (_isLoading)
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade700),
                ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 18),
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
                      '$_city',
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
                      '$_description',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Colors.green.shade700, 
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
