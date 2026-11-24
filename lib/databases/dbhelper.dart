import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'tododb.dart';

class DBHelper {
  static const _database_name = "ENSIA_MY_DB.db";
  static const _database_version = 4;
  static var database;
  static List<String> sql_tables = [TodoDB.sqlTable];

  static Future<Database> getDatabase() async {
    if (database != null) {
      return database;
    }
    database = openDatabase(
      join(await getDatabasesPath(), _database_name),
      onCreate: (database, version) async {
        for (var item in sql_tables) {
          await database.execute(item);
        }
      },
      version: _database_version,
      onUpgrade: (db, oldVersion, newVersion) {},
    );
    return database;
  }
}