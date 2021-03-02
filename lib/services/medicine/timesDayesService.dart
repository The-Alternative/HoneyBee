
import 'package:bassel/models/medicine/MedicineTimes.dart';
import 'package:bassel/utils/databaseconfig.dart';
import 'package:sqflite/sqflite.dart';

class TimesDayesService{

  String midDayesTable = 'mDayes_table';
  String dayesId = 'day_id';
  String day_date = 'd_date';
  String sortNum = 'sortn';
  String dayTimesTable = 'mTimes_table';
  String timesId = 'tid';
  String day_time = 'd_time';
  String day_time_state = 'd_t_state';
  DatabaseConfig _medicineDatabase = DatabaseConfig();
  static Database _database;

  //init database
  // Future<Database> get database async{
  //   if(_database != null) return _database;
  //   _database = await _medicineDatabase.setDatabase();
  //   return _database;
  // }


/////////////////////////////timesday//////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getDayTimesMapList() async {
    Database db = await this._medicineDatabase.honeyBee;
//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = db.query(dayTimesTable, orderBy: '$timesId ASC');
    return result;
  }

  Future<int> insert_DayTimes(MedicineTimes medicineTimes) async {
    Database db = await this._medicineDatabase.honeyBee;
    var result = await db.insert(dayTimesTable, medicineTimes.toMap());
    // Alarmmm.notid =result;
    print('notif_id:${result}');

    return result;
  }

  Future<int> updateDayTimes(MedicineTimes medicineTimes) async {
    Database db = await this._medicineDatabase.honeyBee;
    var result = await db.update(dayTimesTable, medicineTimes.toMap(),
        where: '$timesId = ?', whereArgs: [medicineTimes.timesId]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteDayTimes(int id, int day) async {
    Database db = await this._medicineDatabase.honeyBee;
    int result =
    await db.rawDelete('DELETE FROM $dayTimesTable WHERE $timesId = $id');
    int t = await getCountDayesTime(day);
    if (t == 0) deleteDayes(day);
    return result;
  }
  Future<int> getCountDayesTime(int id) async {
    Database db = await this._medicineDatabase.honeyBee;
    List<Map<String, dynamic>> x = await db
        .rawQuery('SELECT COUNT (*) from $dayTimesTable where $dayesId = $id');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteDayes(int id) async {
    Database db = await this._medicineDatabase.honeyBee;
    int result =
    await db.rawDelete('DELETE FROM $midDayesTable WHERE $dayesId = $id');
    return result;
  }
  // Get number of Note objects in database
  Future<int> getCountDayTimes() async {
    Database db = await this._medicineDatabase.honeyBee;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $dayTimesTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<MedicineTimes>> getDayTimesList() async {
    var medicineTimesMapList =
    await getDayTimesMapList(); // Get 'Map List' from database
    int count = medicineTimesMapList
        .length; // Count the number of map entries in db table
    List<MedicineTimes> medicineTimeList = List<MedicineTimes>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      medicineTimeList
          .add(MedicineTimes.fromMapObject(medicineTimesMapList[i]));
    }

    return medicineTimeList;
  }
  testDay() async {
    Database db = await this._medicineDatabase.honeyBee;
    // get single row
    List<String> columnsToSelect = [dayesId];
    List<Map> result = await db.query(midDayesTable, columns: columnsToSelect);
    List<int> ids = List<int>();
    // get each row in the result list and print it
    result.forEach((row) {
      int a = row['day_id'];
      ids.add(a);
    });
    for (var i = 0; i < ids.length; i++) {
      //getCountDayesTime(ids[i]);
      if (getCountDayesTime(ids[i]) == 0) deleteDayes(ids[i]);
      return result;
    }
  }

  Future<int> getIdDay(String name) async {
    // get a reference to the database
    Database db = await this._medicineDatabase.honeyBee;

    // get single row
    List<String> columnsToSelect = [dayesId];
    String whereString = '${day_date} = ?';
    int rowId = 0;
    List<dynamic> whereArguments = [name];
    List<Map> result = await db.query(midDayesTable,
        columns: columnsToSelect,
        where: whereString,
        whereArgs: whereArguments);

    // print the results
    rowId = Sqflite.firstIntValue(result);
    return rowId;
  }

}