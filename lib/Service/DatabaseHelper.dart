import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        color INTEGER NOT NULL DEFAULT 0xFFFFFFFF
      )
    ''');
  }

  Future<int> insertNote(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('notes', row);
  }

  Future<List<Map<String, dynamic>>> queryAllNote() async {
    final db = await instance.database;
    return await db.query('notes');
  }

  Future<int> updateNote(Map<String, dynamic> row) async {
    final db = await instance.database;
    int id = row['id'];
    return await db.update('notes', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
