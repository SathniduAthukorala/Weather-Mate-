import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/favorite.dart';

class DBService {
  static final DBService _instance = DBService._internal();
  factory DBService() => _instance;
  DBService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'weathermate.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE favorites (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          city TEXT NOT NULL,
          note TEXT
        )
      ''');
    });
  }

  Future<int> createFavorite(Favorite fav) async {
    final db = await database;
    return await db.insert('favorites', fav.toMap());
  }

  Future<List<Favorite>> getFavorites() async {
    final db = await database;
    final res = await db.query('favorites', orderBy: 'id DESC');
    return res.map((m) => Favorite.fromMap(m)).toList();
  }

  Future<int> updateFavorite(Favorite fav) async {
    final db = await database;
    return await db.update('favorites', fav.toMap(), where: 'id = ?', whereArgs: [fav.id]);
  }

  Future<int> deleteFavorite(int id) async {
    final db = await database;
    return await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }
}
