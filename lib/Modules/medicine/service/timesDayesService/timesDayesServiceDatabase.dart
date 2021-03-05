import '../../model/MedicineTimes.dart';
import 'package:sqflite/sqflite.dart';

import 'timesDayesService.dart';
import '.././../../../utils/databaseconfig.dart';

class TimesDayesServiceDatabase extends TimesDayesService{

  String midDayesTable = 'mDayes_table';
  String dayesId = 'day_id';
  String day_date = 'd_date';
  String sortNum = 'sortn';
  String dayTimesTable = 'mTimes_table';
  String timesId = 'tid';
  String day_time = 'd_time';
  String day_time_state = 'd_t_state';
  DatabaseConfig _medicineDatabase = DatabaseConfig();


  @override
  Future<int> deleteDayTimes(int id, int day) async {
    // TODO: implement deleteDayTimes
    Database db = await this._medicineDatabase.honeyBee;
    int result =
    await db.rawDelete('DELETE FROM $dayTimesTable WHERE $timesId = $id');
    int t = await getCountDayesTime(day);
    if (t == 0) deleteDayes(day);
    return result;
  }

  @override
  Future<int> deleteDayes(int id) async {
    // TODO: implement deleteDayes
    Database db = await this._medicineDatabase.honeyBee;
    int result =
    await db.rawDelete('DELETE FROM $midDayesTable WHERE $dayesId = $id');
    return result;
  }

  @override
  Future<int> getCountDayTimes() async {
    // TODO: implement getCountDayTimes
    Database db = await this._medicineDatabase.honeyBee;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $dayTimesTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  @override
  Future<int> getCountDayesTime(int id) async {
    // TODO: implement getCountDayesTime
    Database db = await this._medicineDatabase.honeyBee;
    List<Map<String, dynamic>> x = await db
        .rawQuery('SELECT COUNT (*) from $dayTimesTable where $dayesId = $id');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  @override
  Future<List<MedicineTimes>> getDayTimesList() async {
    // TODO: implement getDayTimesList
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

  @override
  Future<List<Map<String,dynamic>>> getDayTimesMapList() async {
    // TODO: implement getDayTimesMapList
    Database db = await this._medicineDatabase.honeyBee;
//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = db.query(dayTimesTable, orderBy: '$timesId ASC');
    return result;
  }

  @override
  Future<int> getIdDay(String name) async {
    // TODO: implement getIdDay
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

  @override
  Future<int> insert_DayTimes(MedicineTimes medicineTimes) async {
    // TODO: implement insert_DayTimes
    Database db = await this._medicineDatabase.honeyBee;
    var result = await db.insert(dayTimesTable, medicineTimes.toMap());
    // Alarmmm.notid =result;
    print('notif_id:${result}');

    return result;
  }

  @override
  testDay() async {
    // TODO: implement testDay
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

  @override
  Future<int> updateDayTimes(MedicineTimes medicineTimes) async {
    // TODO: implement updateDayTimes
    Database db = await this._medicineDatabase.honeyBee;
    var result = await db.update(dayTimesTable, medicineTimes.toMap(),
        where: '$timesId = ?', whereArgs: [medicineTimes.timesId]);
    return result;
  }

}