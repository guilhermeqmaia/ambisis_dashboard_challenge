import 'package:ambisis_dashboard_challenge/core/services/helpers/db_insert_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

final databaseProvider =
    Provider<IDashboardDatabase>((ref) => DashboardDatabase());

abstract class IDashboardDatabase {
  Future<void> createTableEsgGoal(Database db);
  Future<void> insertEsgGoal(DbInsertModel model);
  Future<List<Map<String, Object?>>> selectEsgGoals();
}

class DashboardDatabase extends IDashboardDatabase {
  Database? _database;

  Future<Database> database() async {
    _database ??= await _getDatabase();
    return _database!;
  }

  Future<Database> _getDatabase() async {
    String dbPath = await sqflite.getDatabasesPath();
    String dbName = 'esg_dashboard.db';
    String path = "$dbPath/$dbName";
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await createTableEsgGoal(db);
      },
    );
  }

  @override
  Future<void> createTableEsgGoal(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS esg_goal (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date INT,
        isComplete INT,
        type INT
      )
    ''');
  }

  @override
  Future<List<Map<String, Object?>>> selectEsgGoals() async {
    final db = await database();
    final queryResult = await db.rawQuery('SELECT * FROM esg_goal');
    return queryResult;
  }

  @override
  Future<void> insertEsgGoal(DbInsertModel model) async {
    final db = await database();
    await db.insert('esg_goal', model.toMap());
  }
}
