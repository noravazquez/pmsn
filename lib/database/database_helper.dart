import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:primer_proyecto/models/event_model.dart';
import 'package:primer_proyecto/models/post_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final nameDB = 'SOCIALDB';
  static final versionDB = 4;

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return await openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables,
    );
  }

  _createTables(Database db, int version) async {
    String query =
        "CREATE TABLE tblPost(idPost INTEGER PRIMARY KEY, dscPost VARCHAR(200), datePost DATE)";
    db.execute(query);
    query =
        "CREATE TABLE tblEvents(idEvent INTEGER PRIMARY KEY, dscEvent VARCHAR(200), dateEvent DATE, complete BOOLEAN)";
    db.execute(query);
  }

  Future<int> INSERT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion.insert(tblName, data);
  }

  Future<int> UPDATE(
      String tblName, Map<String, dynamic> data, String idColumn) async {
    var conexion = await database;
    return conexion.update(tblName, data,
        where: '$idColumn=?', whereArgs: [data[idColumn]]);
  }

  Future<int> DELETE(String tblName, int id, String idColumn) async {
    var conexion = await database;
    return conexion.delete(tblName, where: '$idColumn=?', whereArgs: [id]);
  }

  Future<List<PostModel>> GETALLPOST() async {
    var conexion = await database;
    var result = await conexion.query('tblPost');
    return result.map((post) => PostModel.fromMap(post)).toList();
  }

  Future<List<EventModel>> GETALLEVENTS() async {
    var conexion = await database;
    var result = await conexion.query('tblEvents');
    return result.map((event) => EventModel.fromMap(event)).toList();
  }
}
