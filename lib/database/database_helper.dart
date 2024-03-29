import 'dart:io';
import 'package:path/path.dart';
import 'package:primer_proyecto/models/event_model.dart';
import 'package:primer_proyecto/models/popular_model.dart';
import 'package:primer_proyecto/models/post_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final nameDB = 'SOCIALDB';
  static final versionDB = 11;

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
    String query = '''
      CREATE TABLE tblPost (
        idPost INTEGER PRIMARY KEY,
        dscPost VARCHAR(200),
        datePost DATE
      );''';
    await db.execute(query);
    String query2 = '''
      CREATE TABLE tblEvento (
        idEvento INTEGER PRIMARY KEY,
        descEvento VARCHAR(200),
        fechaEvento DATE,
        completado BOOLEAN
      );
    ''';
    await db.execute(query2);
    String query3 = '''CREATE TABLE tblMoviesFavs(id INTEGER, 
            backdrop_path TEXT, 
            original_language TEXT, 
            original_title TEXT, 
            overview TEXT, 
            popularity REAL, 
            poster_path TEXT, 
            release_date TEXT, 
            title TEXT, 
            vote_average REAL, 
            vote_count INTEGER)''';
    await db.execute(query3);
  }

  Future<int> INSERT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    print(data);
    return await conexion.insert(tblName, data);
  }

  Future<int> UPDATE(
      String tblName, Map<String, dynamic> data, String idColumnName) async {
    var conexion = await database;
    return await conexion.update(
      tblName,
      data,
      where: '$idColumnName = ?',
      whereArgs: [data[idColumnName]],
    );
  }

  Future<int> DELETE(String tblName, int id, String idColumnName) async {
    var conexion = await database;
    return await conexion.delete(
      tblName,
      where: '$idColumnName = ?',
      whereArgs: [id],
    );
  }

  Future<List<PostModel>> GETALLPOST() async {
    var conexion = await database;
    var result = await conexion.query('tblPost');
    return result.map((post) => PostModel.fromMap(post)).toList();
  }

  Future<List<EventModel>> getAllEventos() async {
    var conexion = await database;
    var result = await conexion.query('tblEvento');
    return result.map((evento) => EventModel.fromMap(evento)).toList();
  }

  Future<List<EventModel>> getEvent(int id) async {
    var conexion = await database;
    var query = "Select * from tblEvento where idEvento =?";
    var result = await conexion.rawQuery(query, [id]);
    List<EventModel> eventos = [];
    if (result != null && result.isNotEmpty) {
      eventos = result.map((evento) => EventModel.fromMap(evento)).toList();
    }
    return eventos;
  }

  Future<List<PopularModel>> getAllMovies() async {
    var conexion = await database;
    var result = await conexion.query('tblMoviesFavs');
    return result.map((movie) => PopularModel.fromMap(movie)).toList();
  }

  Future<bool> searchMovie(int idMovie) async {
    var conexion = await database;
    var query = "SELECT * FROM tblMoviesFavs where id=?";
    var result = await conexion.rawQuery(query, [idMovie]);
    if (result != null && result.isNotEmpty) {
      return true;
    }
    return false;
  }
}
