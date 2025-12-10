# WeatherMate

A beautiful Flutter weather application with neumorphic design, featuring real-time weather data, forecasts, air quality monitoring, and favorite cities management.

## Features

- 🌤️ **Current Weather**: Real-time weather data with temperature, humidity, wind speed, and pressure
- 📅 **5-Day Forecast**: Extended weather predictions
- 💨 **Air Quality**: Monitor air pollution levels and pollutants
- ⭐ **Favorites**: Save and manage your favorite cities
- 🎨 **Neumorphic Design**: Modern, soft UI design with beautiful shadows
- 🔄 **Pull to Refresh**: Easy data updates
- 📱 **Responsive UI**: Works on all screen sizes

## Project Structure

```
lib/
├── main.dart                      # App entry point
├── constants.dart                 # App-wide constants
├── core/
│   ├── theme.dart                # App theme configuration
│   └── neumorphic.dart           # Neumorphic design utilities
├── models/
│   ├── weather.dart              # Weather data model
│   ├── forecast.dart             # Forecast data model
│   └── favorite.dart             # Favorite city model (Hive)
├── services/
│   ├── api_service.dart          # OpenWeatherMap API integration
│   └── db_service.dart           # Hive database service
├── providers/
│   ├── weather_provider.dart     # Weather state management
│   └── favorites_provider.dart   # Favorites state management
├── screens/
│   ├── dashboard_screen.dart     # Main dashboard
│   ├── search_screen.dart        # City search
│   ├── favorites_screen.dart     # Favorite cities list
│   ├── forecast_screen.dart      # 5-day forecast
│   ├── air_quality_screen.dart   # Air quality details
│   └── travel_screen.dart        # Travel planner (coming soon)
└── widgets/
    ├── weather_card.dart         # Main weather display card
    ├── metric_grid.dart          # Weather metrics grid
    ├── neumorphic_button.dart    # Custom neumorphic button
    └── neumorphic_card.dart      # Custom neumorphic card
```

## Setup

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK
- OpenWeatherMap API key

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Add your OpenWeatherMap API key in `lib/constants.dart`:
   ```dart
   const String kApiKey = 'YOUR_API_KEY_HERE';
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Dependencies

- **http** (^1.2.0): HTTP requests to OpenWeatherMap API
- **provider** (^6.0.5): State management
- **fl_chart** (^0.65.0): Charts and graphs
- **hive** (^2.2.3): Local database for favorites
- **hive_flutter** (^1.1.0): Hive Flutter integration
- **path_provider** (^2.1.2): File system paths
- **intl** (^0.18.0): Date formatting

## API Reference

This app uses the [OpenWeatherMap API](https://openweathermap.org/api):
- Current Weather Data
- 5 Day / 3 Hour Forecast
- Air Pollution API

Get your free API key at: https://openweathermap.org/api

## Screenshots

(Add screenshots of your app here)

## License

This project is licensed under the MIT License.

## Author

Created for Mobile Application Development Coursework
