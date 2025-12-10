import 'package:flutter/material.dart';
import '../models/favorite.dart';
import '../services/db_service.dart';

class FavoritesProvider extends ChangeNotifier {
  final DBService _db = DBService();
  List<Favorite> favorites = [];
  bool loading = false;

  FavoritesProvider() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    loading = true;
    notifyListeners();
    favorites = await _db.getFavorites();
    loading = false;
    notifyListeners();
  }

  Future<void> addFavorite(String city, {String note = ""}) async {
    await _db.createFavorite(Favorite(city: city, note: note));
    await loadFavorites();
  }

  Future<void> updateFavorite(Favorite fav) async {
    await _db.updateFavorite(fav);
    await loadFavorites();
  }

  Future<void> deleteFavorite(int id) async {
    await _db.deleteFavorite(id);
    await loadFavorites();
  }
}
