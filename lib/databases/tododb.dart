import 'dbBase.dart';


class TodoDB  extends DBBaseTable{
  TodoDB._internal();
  static final TodoDB _instance = TodoDB._internal();

  factory TodoDB() => _instance;

  static TodoDB get instance => _instance;

  @override
  String get tablename => 'todo';

  static const sqlTable = '''
    CREATE TABLE IF NOT EXISTS todo (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      done INTEGER,
      duedate TEXT,
      create_date TEXT)
  ''';
}