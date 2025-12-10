import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../core/neumorphic.dart';
import 'package:intl/intl.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final temp = weather.tempC.toStringAsFixed(1);
    return Container(
      padding: EdgeInsets.all(18),
      decoration: neumorphicDecoration(radius: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(weather.cityName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
              Icon(Icons.favorite_border)
            ],
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$temp°C", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(weather.description, style: TextStyle(fontSize: 14)),
                    SizedBox(height: 6),
                    Text("Humidity: ${weather.humidity}%", style: TextStyle(fontSize: 12)),
                    Text("Wind: ${weather.windSpeed} m/s", style: TextStyle(fontSize: 12)),
                    Text("Feels like: ${weather.feelsLike.toStringAsFixed(1)}°C", style: TextStyle(fontSize: 12)),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 12),
          Text(DateFormat.yMMMMd().format(DateTime.now()), style: TextStyle(fontSize: 12, color: Colors.grey[700])),
        ],
      ),
    );
  }
}
