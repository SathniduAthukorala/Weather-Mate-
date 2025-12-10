class Weather {
  final String cityName;
  final double tempC;
  final String description;
  final int humidity;
  final double windSpeed;
  final int conditionId;
  final double feelsLike;
  final double lat;
  final double lon;

  Weather({
    required this.cityName,
    required this.tempC,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.conditionId,
    required this.feelsLike,
    required this.lat,
    required this.lon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      tempC: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      conditionId: json['weather'][0]['id'],
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      lat: (json['coord']['lat'] as num).toDouble(),
      lon: (json['coord']['lon'] as num).toDouble(),
    );
  }
}
