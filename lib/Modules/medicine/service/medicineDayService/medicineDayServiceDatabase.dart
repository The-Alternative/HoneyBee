import 'package:sqflite/sqflite.dart';

import '../../model/MedicineTimes.dart';
import '../../../../utils/databaseconfig.dart';
import '../../model/medicineDays.dart';

import 'medicineDayService.dart';

class MedicineDayServiceDatabase extends MedicineDayService{

  String midDayesTable = 'mDayes_table';
  String dayesId = 'day_id';
  String day_date = 'd_date';
  String sortNum = 'sortn';
  String dayTimesTable = 'mTimes_table';
  String timesId = 'tid';
  String diagonTable = 'diagon_table';
  String diagid = 'd_id'; //primry/forign..key
  DatabaseConfig _medicineDatabase = DatabaseConfig();


  @override
  Future<int> deleteDayes(int id) async {
    // TODO: implement deleteDayes
    Database db = await this._medicineDatabase.honeyBee;
    int result =
    await db.rawDelete('DELETE FROM $midDayesTable WHERE $dayesId = $id');
    return result;
  }

  @override
  Future<int> getCountDayes() async {
    // TODO: implement getCountDayes
    Database db = await this._medicineDatabase.honeyBee;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $midDayesTable');
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
  Future<List<Map<String,dynamic>>> getmidDayesMapList(String name) async {
    // TODO: implement getmidDayesMapList
    Database db = await this._medicineDatabase.honeyBee;

    var result = await db.rawQuery('SELECT * FROM $midDayesTable '
        ' WHERE $dayesId in(SELECT $dayesId FROM $dayTimesTable WHERE '
        ' d_id in(SELECT $diagid FROM $diagonTable WHERE '
        ' p_id =(SELECT p_id FROM patent_table WHERE p_name like '+"'"+'$name'+"'"+' ))) order by $sortNum ASC');
    //var result = db.query(midDayesTable, orderBy: '$sortNum ASC');
    return result;
  }

  @override
  Future<List<MedicineDays>> getselectmidDayesList(String name) async {
    // TODO: implement getselectmidDayesList
    var midDayesMapList = await getmidDayesMapList(''); // Get 'Map List' from database
    int count = midDayesMapList.length; // Count the number of map entries in db table
    List<MedicineDays> dayesList = List<MedicineDays>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      dayesList.add(MedicineDays.fromMapObject(midDayesMapList[i]));
    }
    return dayesList;
  }

  @override
  Future<int> insertDayes(MedicineDays days) async {
    // TODO: implement insertDayes
    Database db = await this._medicineDatabase.honeyBee;
    try {
      var result = await db.insert(midDayesTable, days.toMap());
      return result;
    } catch (e) {
      return getIdDay(days.dayDate);
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

  @override
  Future<int> updateDayes(MedicineDays days) async {
    // TODO: implement updateDayes
    Database db = await this._medicineDatabase.honeyBee;
    var result = await db.update(midDayesTable, days.toMap(),
        where: '$dayesId = ?', whereArgs: [days.dayesId]);
    return result;
  }

}