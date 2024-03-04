import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Define database instance
  static Database? _database;

  // Define table and column names
  static const String tableName = 'favorites';
  static const String columnId = 'id';
  static const String columnName = 'name';
  // Add more columns as needed

  // Create the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'favorite_items.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Create the table
        await db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT
            -- Add more columns here
          )
        ''');
      },
    );

    // Create table if it doesn't exist
    await _database!.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT
        -- Add more columns here
      )
    ''');

    return _database!;
  }

  // Insert data into the database
  Future<void> insertFavorite(Map<String, dynamic> row) async {
    final db = await database;
    await db.insert(tableName, row);
  }

  // Retrieve all favorites from the database
  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db.query(tableName);
  }
}
