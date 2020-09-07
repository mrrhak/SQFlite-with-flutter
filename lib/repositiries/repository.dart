import 'package:sqflite/sqlite_api.dart';
import 'package:todo_list/repositiries/database_connection.dart';

class Repository {
  DatabaseConnection _databaseConnection;
  Repository() {
    this._databaseConnection = DatabaseConnection();
  }

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  //Inserting Data
  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  updateData(table, data) async {
    var connection = await database;
    return await connection
        .update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  deleteData(table, categoryId) async {
    var connection = await database;
    return await connection
        .rawDelete("DELETE FROM $table WHERE id = $categoryId");
  }

  // Read Data From Table
  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  readDataById(table, itemId) async {
    var connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [itemId]);
  }
}
