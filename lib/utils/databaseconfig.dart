import 'dart:io';
// import 'package:diary/models/diary.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseConfig {
  static Database _honeyBee;
  //==============================================================================
  final String StageTable = 'stage';
  final String taskId = 'tid';
  final String stageId = 'sid';
  //==============================================================================
  final String PersonTable = 'person';
  final String personId = 'pid';
  final String name = 'name';
  //==============================================================================
  final String noticeTable = 'notice';
  final String noticeId = 'nid';
  final String columnNoticse = 'cnotice';
  //==============================================================================
  final String imageTable = 'image';
  final String imgId = 'imgid';
  final String path = 'path';
  //==============================================================================
  final String TaskTable = 'event';
  final String columnId = 'id';
  final String columntitle = 'title';
  final String columnDescription = 'description';
  final String columnPiriority = 'piriority';
  final String taskCase = 'tcase';
  final String columnPlaces = 'places';
  final String columnDate = 'eventDate';
  final String columnTime = 'time';
  final String columnPath1 = 'path1';
  final String columnPath2 = 'path2';

  //==============================================================================
  static DatabaseConfig databaseConfig;
  //==============================================================================

  Future<Database> get honeyBee async {
    if (_honeyBee != null) {
      return _honeyBee;
    }
    _honeyBee = await intDb();
    return _honeyBee;
  }
  //==============================================================================

  intDb() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String path = join(appDirectory.path, 'task.db');
    var myOwnDb = await openDatabase(path, version: 1, onCreate: _oncreate);
    return myOwnDb;
  }
  //==============================================================================

  void _oncreate(Database db, int newVersion) async {
    //================================task table==============================================

    var descsql = "CREATE TABLE"
        " $TaskTable ("
        "$columnId INTEGER PRIMARY KEY ,"
        "$columntitle TEXT,"
        "$columnDescription TEXT,"
        "$columnPiriority TEXT,"
        "$columnPlaces TEXT,"
        "$taskCase INTEGER,"
        "$columnDate TEXT,"
        "$columnTime TEXT,"
        "$columnPath2 TEXT,"
        "$columnPath1 TEXT)";
    await db.execute(descsql);
    //================================== stage table============================================
    await db.execute('CREATE TABLE '
        '$StageTable ('
        '$stageId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$columntitle TEXT,'
        '$taskId INTEGER FORIGN KEY REFERENCES $TaskTable($columnId))');
    //======================================= notice table=======================================
    await db.execute('CREATE TABLE '
        '$noticeTable ('
        '$noticeId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$columnNoticse TEXT,'
        '$taskId INTEGER FORIGN KEY REFERENCES $TaskTable($columnId))');
    //========================================== person table====================================
    await db.execute('CREATE TABLE '
        '$PersonTable ('
        '$personId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$name TEXT,'
        '$taskId INTEGER FORIGN KEY REFERENCES $TaskTable($columnId))');
    //========================================== image table====================================
    await db.execute('CREATE TABLE '
        '$imageTable ('
        '$imgId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$path TEXT,'
        '$taskId INTEGER FORIGN KEY REFERENCES $TaskTable($columnId))');
    //==========================================================================================
  }
}