import 'package:meta/meta.dart' show visibleForTesting;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'local_database.db');

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  @visibleForTesting
  Future<void> createTestDb(Database db, int version) async {
    await _createDb(db, version);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      login TEXT NOT NULL,
      avatar_url TEXT NOT NULL
    );
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS repositories (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      full_name TEXT NOT NULL,
      html_url TEXT NOT NULL,
      description TEXT,
      language TEXT,
      stargazers_count INTEGER,
      username TEXT NOT NULL,
      FOREIGN KEY (username) REFERENCES users (login) ON DELETE CASCADE
    );
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS ads (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ad_banner_url TEXT NOT NULL,
      link_url TEXT NOT NULL
    );
    ''');
  }

  Future<void> clearTables() async {
    final db = await database;
    await db.delete('users');
    await db.delete('repositories');
    await db.delete('ads');
  }

  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
