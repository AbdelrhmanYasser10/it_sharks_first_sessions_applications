import 'package:sqflite/sqflite.dart';

abstract class DatabaseHelper{
  static Database? _db;
  static String tableName = "Note";
  static Future<void> initializeDatabase()async{
    var databasesPath = await getDatabasesPath();
    String finalPath = "$databasesPath/mydatabase.db";
    _db = await openDatabase(
        finalPath,
        version: 1,
      onCreate: (db, version)async {
        await db.execute(
            'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, title TEXT, desc TEXT, date TEXT, status INTEGER)');
          print("مبروك عملنا داتابيز (الفرحه)");
      },
      onOpen: (db) {
        print("مبروك الداتا بيز اتفتحت");
      },
    );

  }

  // CRUD Operations
  // create , read , update , delete
  // 1 - create => insert
  static Future<void> insertNewRow(Map<String,dynamic> map)async{
    if(_db != null){
      await _db!.insert(tableName, map);
      print("inserted successfully");
    }
  }
  //2 - read => select(query)
  // SELECT * FROM Note Where id = 1
  static Future<List<Map<String,dynamic>>> getAllData()async{
    if(_db != null){
      return await _db!.query(tableName);
    }
    return [];
  }
  static Future<Map<String,dynamic>> getSpecificRow(int id)async{
    if(_db != null){
      List<Map<String,dynamic>> result = await _db!.query("Note",where: "id = ?",whereArgs: [id]);
      if(result.isNotEmpty) {
        return result[0];
      }
      else{
        return {};
      }
    }
    return {};
  }

  //3- UPDATE
  static Future<void> updateData(Map<String,dynamic> data , int id) async{
    if(_db != null){
      await _db!.update(tableName, data , where: "id = ?" , whereArgs: [id]);
    }
  }

  //4 - DELETE
  static Future<void> deleteData(int id) async{
    if(_db != null) {
      await _db!.delete(tableName, where: "id = ?", whereArgs: [id]);
    }
  }
}