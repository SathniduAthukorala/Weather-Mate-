import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/weather_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fprov = Provider.of<FavoritesProvider>(context);
    final wprov = Provider.of<WeatherProvider>(context, listen:false);
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body: fprov.loading ? Center(child: CircularProgressIndicator()) : fprov.favorites.isEmpty ? Center(child: Text("No favorites yet")) :
      ListView.builder(
        itemCount: fprov.favorites.length,
        itemBuilder: (ctx, i) {
          final f = fprov.favorites[i];
          return ListTile(
            title: Text(f.city),
            subtitle: Text(f.note.isEmpty ? "No note" : f.note),
            trailing: PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'open') {
                  await wprov.fetchAll(f.city);
                  Navigator.pop(context);
                } else if (value == 'rename') {
                  final ctrl = TextEditingController(text: f.note);
                  final ok = await showDialog<bool>(context: context, builder: (ctx) {
                    return AlertDialog(
                      title: Text("Add / Edit Note"),
                      content: TextField(controller: ctrl, decoration: InputDecoration(labelText: "Note")),
                      actions: [
                        TextButton(onPressed: ()=> Navigator.pop(ctx,false), child: Text("Cancel")),
                        TextButton(onPressed: ()=> Navigator.pop(ctx,true), child: Text("Save")),
                      ],
                    );
                  });
                  if (ok == true) {
                    f.note = ctrl.text.trim();
                    await fprov.updateFavorite(f);
                  }
                } else if (value == 'delete') {
                  final confirmed = await showDialog<bool>(context: context, builder: (ctx) {
                    return AlertDialog(
                      title: Text("Delete favorite?"),
                      content: Text("Delete ${f.city}?"),
                      actions: [
                        TextButton(onPressed: ()=> Navigator.pop(ctx,false), child: Text("No")),
                        TextButton(onPressed: ()=> Navigator.pop(ctx,true), child: Text("Yes")),
                      ],
                    );
                  });
                  if (confirmed == true) {
                    await fprov.deleteFavorite(f.id!);
                  }
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(value: 'open', child: Text('Open')),
                PopupMenuItem(value: 'rename', child: Text('Rename / Add note')),
                PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
            onTap: () async {
              await wprov.fetchAll(f.city);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
