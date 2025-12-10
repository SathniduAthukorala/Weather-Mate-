import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/weather.dart';
import '../models/forecast.dart';

class ApiService {
  final String _key = OPENWEATHER_API_KEY;
  final String _base = OPENWEATHER_BASE;

  Future<Weather> getCurrentWeather(String city) async {
    final url = Uri.parse("$_base/weather?q=$city&appid=$_key&units=metric");
    final res = await http.get(url);
    if (res.statusCode != 200) throw Exception('Weather API error: ${res.body}');
    final json = jsonDecode(res.body);
    return Weather.fromJson(json);
  }

  Future<List<ForecastItem>> get5DayForecast(String city) async {
    final url = Uri.parse("$_base/forecast?q=$city&appid=$_key&units=metric");
    final res = await http.get(url);
    if (res.statusCode != 200) throw Exception('Forecast API error: ${res.body}');
    final json = jsonDecode(res.body);
    List list = json['list'];
    List<ForecastItem> items = [];
    // Select one item per day - take first of every 8 (approx)
    for (int i = 0; i < list.length; i += 8) {
      items.add(ForecastItem.fromJson(list[i]));
      if (items.length == 5) break;
    }
    return items;
  }

  Future<Map<String, dynamic>> getAirQuality(double lat, double lon) async {
    final url = Uri.parse("$_base/air_pollution?lat=$lat&lon=$lon&appid=$_key");
    final res = await http.get(url);
    if (res.statusCode != 200) throw Exception('AirQuality API error: ${res.body}');
    return jsonDecode(res.body);
  }

  Future<Map<String, double>> geocode(String city) async {
    final url = Uri.parse("http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&appid=$_key");
    final res = await http.get(url);
    if (res.statusCode != 200) throw Exception('Geocode API error');
    final list = jsonDecode(res.body) as List;
    if (list.isEmpty) throw Exception('City not found');
    return {'lat': (list[0]['lat'] as num).toDouble(), 'lon': (list[0]['lon'] as num).toDouble()};
  }
}
