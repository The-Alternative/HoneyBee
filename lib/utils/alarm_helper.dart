import '../Moduls/medicine/model/alarm_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

final String tableAlarm = 'alarm';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';
final String columnDiag = 'd_id';

class AlarmHelper {
  static Database _database;
  static AlarmHelper _alarmHelper;

  AlarmHelper._createInstance();
  factory AlarmHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper._createInstance();
    }
    return _alarmHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "alarm.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableAlarm ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPending integer,
          $columnDiag integer)
        ''');
      },
    );
    return database;
  }

  Future<int> insertAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    int result = await db.insert(tableAlarm, alarmInfo.toMap());
    print('result : $result');
    return result;
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];

    var db = await this.database;
    var result = await db.query(tableAlarm);
    result.forEach((element) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);
    });

    return _alarms;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }
  Future<int> getId(int diagid,DateTime dt) async {
    String ss= dt.toIso8601String();
    var db = await this.database;
    var res = await db.rawQuery('SELECT $columnId FROM $tableAlarm WHERE'
        ' $columnDiag=$diagid AND $columnDateTime =?',['$ss']);
    int result = Sqflite.firstIntValue(res);

    print(result);
    return result;
    //return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }
}
