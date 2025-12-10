import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../providers/favorites_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final wprov = Provider.of<WeatherProvider>(context);
    final fprov = Provider.of<FavoritesProvider>(context, listen:false);
    return Scaffold(
      appBar: AppBar(title: Text("Search City")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "City name", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: () async {
                  if (_controller.text.trim().isEmpty) return;
                  await wprov.fetchAll(_controller.text.trim());
                  Navigator.pop(context);
                }, child: Text("Search"))),
                SizedBox(width: 10),
                Expanded(child: ElevatedButton(onPressed: () async {
                  if (_controller.text.trim().isEmpty) return;
                  setState(() => _saving = true);
                  await fprov.addFavorite(_controller.text.trim());
                  setState(() => _saving = false);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Saved to favorites")));
                }, child: _saving ? SizedBox(height:16, width:16, child: CircularProgressIndicator(strokeWidth:2, color: Colors.white)) : Text("Save"))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
