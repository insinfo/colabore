import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:colabore/models/usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  //singleton
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }


  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Usuario("
        "id INTEGER PRIMARY KEY,"
        "expiresIn INTEGER,"
        "accessToken TEXT,"
        "fullName TEXT,"
        "loginName TEXT,"
        "idPessoa INTEGER,"
        "idOrganograma INTEGER,"
        "idPerfil INTEGER,"
        "imagemPessoa TEXT,"
        "cpfPessoa TEXT)"
        );
    print("Created tables");
  }

  Future<int> saveUser(Usuario user) async {
    var dbClient = await db;
    int res = await dbClient.insert("Usuario", user.toJson());
    return res;
  }

  Future<int> deleteUsers() async {
    var dbClient = await db;
    int res = await dbClient.delete("Usuario");
    return res;
  }

  Future<Usuario> getFistUser() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query("Usuario", limit: 1, offset: 0);
    if (maps.length > 0) {
      return Usuario.fromJson(maps.first);
    }
    return null;
  }

  Future<bool> isLoggedIn() async {
    var dbClient = await db;
    var res = await dbClient.query("Usuario");
    return res.length > 0 ? true : false;
  }

  Future close() async {
    _db.close();
  }
}
