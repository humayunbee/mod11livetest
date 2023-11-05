import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class WeatherData {
  final String city;
  final int temperature;
  final String condition;
  final int humidity;
  final double windSpeed;

  WeatherData({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['city'],
      temperature: json['temperature'],
      condition: json['condition'],
      humidity: json['humidity'],
      windSpeed: json['windSpeed'],
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<WeatherData> weatherDataList = [];

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final String jsonString = '''
    [
      {
        "city": "New York",
        "temperature": 20,
        "condition": "Clear",
        "humidity": 60,
        "windSpeed": 5.5
      },
      {
        "city": "Los Angeles",
        "temperature": 25,
        "condition": "Sunny",
        "humidity": 50,
        "windSpeed": 6.8
      },
      {
        "city": "London",
        "temperature": 15,
        "condition": "Partly Cloudy",
        "humidity": 70,
        "windSpeed": 4.2
      },
      {
        "city": "Tokyo",
        "temperature": 28,
        "condition": "Rainy",
        "humidity": 75,
        "windSpeed": 8.0
      },
      {
        "city": "Sydney",
        "temperature": 22,
        "condition": "Cloudy",
        "humidity": 55,
        "windSpeed": 7.3
      }
    ]
    ''';

    final List<dynamic> jsonData = json.decode(jsonString);
    final List<WeatherData> data =
        jsonData.map((e) => WeatherData.fromJson(e)).toList();

    setState(() {
      weatherDataList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather Info App'),
        ),
        body: ListView.builder(
          itemCount: weatherDataList.length,
          itemBuilder: (context, index) {
            final weather = weatherDataList[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.all(16),
              child: ListTile(
                title: Text(weather.city),
                subtitle: Text(
                  'Temperature: ${weather.temperature}°C\nCondition: ${weather.condition}\nHumidity: ${weather.humidity}%\nWind Speed: ${weather.windSpeed} km/h',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
