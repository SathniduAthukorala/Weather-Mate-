import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../core/neumorphic.dart';

class AirQualityScreen extends StatelessWidget {
  const AirQualityScreen({Key? key}) : super(key: key);

  String aqiText(int aqi) {
    switch (aqi) {
      case 1: return "Good";
      case 2: return "Fair";
      case 3: return "Moderate";
      case 4: return "Poor";
      case 5: return "Very Poor";
      default: return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    final wprov = Provider.of<WeatherProvider>(context);
    final data = wprov.airQuality;
    return Scaffold(
      appBar: AppBar(title: Text("Air Quality")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: data == null ? Center(child: Text("No air quality data")) :
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(14),
              decoration: neumorphicDecoration(radius: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("AQI: ${data['list'][0]['main']['aqi']}", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text(aqiText(data['list'][0]['main']['aqi'])),
                ],
              ),
            ),
            SizedBox(height: 12),
            Text("Components", style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12),
              decoration: neumorphicDecoration(radius: 12),
              child: Column(
                children: (data['list'][0]['components'] as Map<String, dynamic>).entries.map((e) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Text(e.key.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 12),
                        Text("${e.value} µg/m³")
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
