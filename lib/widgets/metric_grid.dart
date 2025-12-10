import 'package:flutter/material.dart';
import '../core/neumorphic.dart';

class MetricGrid extends StatelessWidget {
  final int humidity;
  final double wind;
  final double feelsLike;

  const MetricGrid({Key? key, required this.humidity, required this.wind, required this.feelsLike}) : super(key: key);

  Widget metricTile(String title, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: neumorphicDecoration(radius: 14),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        metricTile("Humidity", "$humidity%"),
        SizedBox(width: 10),
        metricTile("Wind", "${wind.toStringAsFixed(1)} m/s"),
        SizedBox(width: 10),
        metricTile("Feels like", "${feelsLike.toStringAsFixed(1)}°C"),
      ],
    );
  }
}
