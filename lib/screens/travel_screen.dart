import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../core/neumorphic.dart';
import 'package:intl/intl.dart';

class TravelScreen extends StatefulWidget {
  const TravelScreen({Key? key}) : super(key: key);
  @override
  _TravelScreenState createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  final _cityCtrl = TextEditingController();
  DateTime? _date;
  String _result = "";

  @override
  Widget build(BuildContext context) {
    final wprov = Provider.of<WeatherProvider>(context, listen:false);
    return Scaffold(
      appBar: AppBar(title: Text("Travel Checker")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(controller: _cityCtrl, decoration: InputDecoration(labelText: "Destination city", border: OutlineInputBorder())),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: Text(_date == null ? "Select date" : DateFormat.yMMMd().format(_date!))),
                ElevatedButton(onPressed: () async {
                  final d = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 14)));
                  if (d != null) setState(()=> _date = d);
                }, child: Text("Pick date"))
              ],
            ),
            SizedBox(height: 12),
            ElevatedButton(onPressed: () async {
              if (_cityCtrl.text.trim().isEmpty || _date == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter city and date")));
                return;
              }
              await wprov.fetchAll(_cityCtrl.text.trim());
              final forecast = wprov.forecast;
              if (forecast.isEmpty) {
                setState(()=> _result = "No forecast data available");
                return;
              }
              final closest = forecast.reduce((a,b) => (a.date.difference(_date!).abs().inHours < b.date.difference(_date!).abs().inHours) ? a : b);
              String advice;
              if (closest.description.contains("rain") || closest.temp < 0 || closest.temp > 40) {
                advice = "Unsafe: ${closest.description}, ${closest.temp.toStringAsFixed(1)}°C";
              } else {
                advice = "Safe: ${closest.description}, ${closest.temp.toStringAsFixed(1)}°C";
              }
              setState(()=> _result = advice);
            }, child: Text("Check Safety")),
            SizedBox(height: 12),
            _result.isEmpty ? SizedBox() : Container(
              padding: EdgeInsets.all(12),
              decoration: neumorphicDecoration(radius: 12),
              child: Text(_result),
            )
          ],
        ),
      ),
    );
  }
}
