import 'package:bassel/utils/databaseconfig.dart';
import 'package:bassel/models/medicine/MedicineTimes.dart';
import 'package:bassel/models/medicine/medicineDays.dart';
import 'package:sqflite/sqflite.dart';

class MedicineDayService{
  String midDayesTable = 'mDayes_table';
  String dayesId = 'day_id';
  String day_date = 'd_date';
  String sortNum = 'sortn';
  String dayTimesTable = 'mTimes_table';
  String timesId = 'tid';

  DatabaseConfig _medicineDatabase = DatabaseConfig();

  /////////////////////////////////////////////////////////////midDayes///////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getmidDayesMapList() async {
    Database db = await this._medicineDatabase.honeyBee;

    var result = await db.rawQuery('SELECT * FROM $midDayesTable '
        ' WHERE $dayesId in(SELECT $dayesId FROM $dayTimesTable ) order by $sortNum ASC');
    //var result = db.query(midDayesTable, orderBy: '$sortNum ASC');
    return result;
  }

  /////////////////////////////////////////////////////////////midDayes///////////////////////////////////////////////////
  Future<int> insertDayes(MedicineDays days) async {
    Database db = await this._medicineDatabase.honeyBee;
    try {
      var result = await db.insert(midDayesTable, days.toMap());
      return result;
    } catch (e) {
      return getIdDay(days.dayDate);
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

  Future<int> updateDayes(MedicineDays days) async {
    var db = await this._medicineDatabase.honeyBee;
    var result = await db.update(midDayesTable, days.toMap(),
        where: '$dayesId = ?', whereArgs: [days.dayesId]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteDayes(int id) async {
    var db = await this._medicineDatabase.honeyBee;
    int result =
    await db.rawDelete('DELETE FROM $midDayesTable WHERE $dayesId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCountDayes() async {
    Database db = await this._medicineDatabase.honeyBee;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $midDayesTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCountDayesTime(int id) async {
    Database db = await this._medicineDatabase.honeyBee;
    List<Map<String, dynamic>> x = await db
        .rawQuery('SELECT COUNT (*) from $dayTimesTable where $dayesId = $id');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<MedicineDays>> getmidDayesList() async {
    var midDayesMapList = await getmidDayesMapList(); // Get 'Map List' from database
    int count = midDayesMapList.length; // Count the number of map entries in db table
    List<MedicineDays> dayesList = List<MedicineDays>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      dayesList.add(MedicineDays.fromMapObject(midDayesMapList[i]));
    }
    return dayesList;
  }

  Future<List<MedicineDays>> getselectmidDayesList(String name) async {
    var midDayesMapList =
    await getmidDayesMapList(); // Get 'Map List' from database
    int count =
        midDayesMapList.length; // Count the number of map entries in db table
    List<MedicineDays> dayesList = List<MedicineDays>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      dayesList.add(MedicineDays.fromMapObject(midDayesMapList[i]));
    }
    return dayesList;
  }
  Future<int> updateDayTimes(MedicineTimes medicineTimes) async {
    var db = await this._medicineDatabase.honeyBee;
    var result = await db.update(dayTimesTable, medicineTimes.toMap(),
        where: '$timesId = ?', whereArgs: [medicineTimes.timesId]);
    return result;
  }
}