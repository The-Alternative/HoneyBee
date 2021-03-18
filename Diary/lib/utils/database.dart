import 'dart:io';
// import 'package:diary/models/diary.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseConfig {
  static Database _honeyBee;

  final String diaryTable = 'diary';
  final String columnId = 'id';
  final String columnAddress = 'address';
  final String columnDescription = 'description';
  final String columnDate = 'date';
  final String columnImage = 'image';


  static DatabaseConfig databaseConfig;

  Future<Database> get honeyBee async {
    if (_honeyBee != null) {
      return _honeyBee;
    }
    _honeyBee = await intDb();
    return _honeyBee;
  }

  intDb() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String path = join(appDirectory.path, 'honeyBee.db');
    var myOwnDb = await openDatabase(path, version: 1, onCreate: _oncreate);
    return myOwnDb;
  }

  void _oncreate(Database db, int newVersion) async {
    var descsql = "CREATE TABLE $diaryTable ($columnId INTEGER PRIMARY KEY ,"
        "$columnAddress TEXT,$columnDescription TEXT,$columnDate TEXT,$columnImage TEXT)";
    await db.execute(descsql);
  }
}
