class ForecastItem {
  final DateTime date;
  final double temp;
  final String description;

  ForecastItem({required this.date, required this.temp, required this.description});

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      date: DateTime.fromMillisecondsSinceEpoch((json['dt'] as num).toInt() * 1000),
      temp: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}
