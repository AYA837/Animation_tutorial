import 'package:sqflite/sqflite.dart';

import 'dbhelper.dart';

abstract class DBBaseTable {
  String get tablename;

  Future<List<Map<String, dynamic>>> getRecords() async {
    try {
      final database = await DBHelper.getDatabase();
      List<Map<String, dynamic>> data = await database.query(tablename);
      return data;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
      return [];
    }
  }

  Future<bool> updateRecord(int id, Map<String, dynamic> data) async {
    try {
      final database = await DBHelper.getDatabase();
      database.update(tablename, data, where: 'id = ?', whereArgs: [id]);
      return true;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
      return false;
    }
  }

  Future<bool> insertRecord( String titleText , bool isDone) async {
    try{
          final database = await DBHelper.getDatabase();
        await  database.insert(tablename,{'title' : titleText , 'done' : isDone ? 1 : 0,} );
      return true;
    }catch(e , stacktrace){
          print('error $e: $stacktrace');
          return false;
    }
  }

  Future<bool> deleteRecord(int id , Map<String , dynamic> data) async{
    try{
      final database =  await DBHelper.getDatabase();
    await database.delete(tablename , where: 'id = ?' , whereArgs: [data['id']]);
      return true;
    } catch(e , stacktrace){
      print('error : $stacktrace');
      return false;
    }
  }
}