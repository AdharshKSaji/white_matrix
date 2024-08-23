import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:white_matrix/model/productmodel.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'favorites.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE favorites(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, image TEXT, price REAL)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertFavorite(ProductModel product) async {
    final db = await database;
    await db.insert(
      'favorites',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(int id) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<ProductModel>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) {
      return ProductModel(
        
        title: maps[i]['title'],
        image: maps[i]['image'],
        price: maps[i]['price'],
         review: '',
         description: '', 
         seller: '',
          rate: maps[i]['rate'],
          quantity: maps[i]['qty'],
      );
    });
  }
}
