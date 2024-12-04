import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/Item.dart';
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('items.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');
  }

  // CREATE
  Future<int> insertItem(Item item) async {
    final db = await instance.database;
    return await db.insert('items', item.toMap());
  }

  // READ
  Future<List<Item>> fetchItems() async {
    final db = await instance.database;

    final maps = await db.query('items');

    return List.generate(
      maps.length,
          (index) => Item.fromMap(maps[index]),
    );
  }

  // UPDATE
  Future<int> updateItem(Item item) async {
    final db = await instance.database;

    return await db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  // DELETE
  Future<int> deleteItem(int id) async {
    final db = await instance.database;

    return await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Ma'lumotlar bazasini yopish
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
