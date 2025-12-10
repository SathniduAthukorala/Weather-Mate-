import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/weather_card.dart';
import '../widgets/metric_grid.dart';
import '../widgets/neumorphic_button.dart';
import '../widgets/neumorphic_card.dart';
import '../core/neumorphic.dart';
import 'search_screen.dart';
import 'favorites_screen.dart';
import 'travel_screen.dart';
import 'air_quality_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wprov = Provider.of<WeatherProvider>(context);
    final fprov = Provider.of<FavoritesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("WeatherMate"),
        actions: [
          IconButton(icon: Icon(Icons.favorite), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FavoritesScreen()))),
          SizedBox(width: 8)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.search),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen())),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: wprov.loading
            ? Center(child: CircularProgressIndicator())
            : wprov.error.isNotEmpty
                ? Center(child: Text("Error: ${wprov.error}"))
                : wprov.current == null
                    ? Center(child: Text("Search a city to get weather"))
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            WeatherCard(weather: wprov.current!),
                            SizedBox(height: 12),
                            MetricGrid(humidity: wprov.current!.humidity, wind: wprov.current!.windSpeed, feelsLike: wprov.current!.feelsLike),
                            SizedBox(height: 12),
                            Text("5-Day Forecast", style: TextStyle(fontWeight: FontWeight.w600)),
                            SizedBox(height: 8),
                            SizedBox(
                              height: 110,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: wprov.forecast.length,
                                itemBuilder: (ctx, i) {
                                  final f = wprov.forecast[i];
                                  return Container(
                                    width: 120,
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(10),
                                    decoration: neumorphicDecoration(radius: 14),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${f.date.month}/${f.date.day}", style: TextStyle(fontWeight: FontWeight.bold)),
                                        SizedBox(height: 6),
                                        Text("${f.temp.toStringAsFixed(1)}°C"),
                                        SizedBox(height: 6),
                                        Text(f.description, style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(child: NeumorphicButton(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TravelScreen())), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.flight), SizedBox(width: 8), Text("Travel")] ))),
                                SizedBox(width: 10),
                                Expanded(child: NeumorphicButton(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AirQualityScreen())), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.air), SizedBox(width: 8), Text("Air Quality")] ))),
                              ],
                            ),
                            SizedBox(height: 12),
                            wprov.airQuality != null ? NeumorphicCard(
                              padding: EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Air Quality (AQI)", style: TextStyle(fontWeight: FontWeight.w600)),
                                  SizedBox(height: 8),
                                  Text("AQI index: ${wprov.airQuality!['list'][0]['main']['aqi']} (1 Good - 5 Very Poor)"),
                                ],
                              ),
                            ) : SizedBox(),
                            SizedBox(height: 20),
                            Text("Saved Favorites", style: TextStyle(fontWeight: FontWeight.w600)),
                            SizedBox(height: 8),
                            fprov.loading ? CircularProgressIndicator() : fprov.favorites.isEmpty ? Text("No favorites yet") :
                            Column(
                              children: fprov.favorites.take(3).map((f) => GestureDetector(
                                onTap: () async {
                                  await Provider.of<WeatherProvider>(context, listen:false).fetchAll(f.city);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.all(12),
                                  decoration: neumorphicDecoration(radius: 14),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on),
                                      SizedBox(width: 12),
                                      Expanded(child: Text(f.city)),
                                      IconButton(onPressed: () {
                                        // open favorites screen
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => FavoritesScreen()));
                                      }, icon: Icon(Icons.more_horiz))
                                    ],
                                  ),
                                ),
                              )).toList()
                            )
                          ],
                        ),
                      ),
      ),
    );
  }
}
