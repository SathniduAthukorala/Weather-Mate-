import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../models/forecast.dart';
import '../services/api_service.dart';

class WeatherProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  Weather? current;
  List<ForecastItem> forecast = [];
  Map<String, dynamic>? airQuality;
  bool loading = false;
  String error = '';

  Future<void> fetchAll(String city) async {
    loading = true;
    error = '';
    notifyListeners();
    try {
      current = await _api.getCurrentWeather(city);
      forecast = await _api.get5DayForecast(city);
      airQuality = await _api.getAirQuality(current!.lat, current!.lon);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void clear() {
    current = null;
    forecast = [];
    airQuality = null;
    notifyListeners();
  }
}

