import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../core/neumorphic.dart';
import 'package:intl/intl.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wprov = Provider.of<WeatherProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Forecast")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: wprov.forecast.isEmpty ? Center(child: Text("No forecast data")) :
        ListView.builder(
          itemCount: wprov.forecast.length,
          itemBuilder: (ctx, i) {
            final f = wprov.forecast[i];
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(12),
              decoration: neumorphicDecoration(radius: 12),
              child: Row(
                children: [
                  Text(DateFormat.yMMMd().format(f.date), style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 12),
                  Text("${f.temp.toStringAsFixed(1)}°C"),
                  SizedBox(width: 12),
                  Expanded(child: Text(f.description, textAlign: TextAlign.end)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
