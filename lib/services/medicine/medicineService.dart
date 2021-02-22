import 'package:bassel/utils/databaseconfig.dart';
import 'package:bassel/models/medicine/Medicine.dart';
import 'package:bassel/models/medicine/MedicineInfo.dart';
import 'package:bassel/models/medicine/MedicineTimes.dart';
import 'package:sqflite/sqflite.dart';

class MedicineService{
  String medicinTable = 'med_table';
  String medId = 'id'; //primry/forign..key
  String medTitle = 'title';
  String medform = 'form';
  String diagonTable = 'diagon_table';
  String diagid = 'd_id'; //primry/forign..key
  String patientTable = 'patent_table';
  String patname = 'p_name';
  String patId = 'p_id'; //primry/forign..key
  String midDayesTable = 'mDayes_table';
  String dayesId = 'day_id';
  String dayTimesTable = 'mTimes_table';
  String timesId = 'tid';

  DatabaseConfig _medicineDatabase = DatabaseConfig();


  //insert something to database
  Future<int> insertData(String table,Map<String,dynamic> data) async{
    Database db = await this._medicineDatabase.honeyBee;
    try{
      return await db.insert(table, data);
    }catch(e){
      return null;
    }
  }

  //get all data from database
  Future<List<Map<String,dynamic>>> getAllData(table) async{
    Database db = await this._medicineDatabase.honeyBee;
    try{
      return db.query(table);
    }catch(e){
      return null;
    }
  }

  //delete data
  Future<int> deleteData(String table,int id) async{
    Database db = await this._medicineDatabase.honeyBee;
    try{
      return await db.delete(table,where: "id = ?", whereArgs: [id]);
    }catch(e){
      return null;
    }
  }

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
    return result;
  }

  Future<int> updateDayTimes(MedicineTimes medicineTimes) async {
    var db = await this._medicineDatabase.honeyBee;
    var result = await db.update(dayTimesTable, medicineTimes.toMap(),
        where: '$timesId = ?', whereArgs: [medicineTimes.timesId]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteDayTimes(int id, int day) async {
    var db = await this._medicineDatabase.honeyBee;
    int result =
    await db.rawDelete('DELETE FROM $dayTimesTable WHERE $timesId = $id');
    int t = await getCountDayesTime(day);
    if (t == 0) deleteDayes(day);
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

/////////////////////////////Medicine//////////////////////////
  Future<List<Map<String, dynamic>>> getMedicineMapList() async {
    Database db = await this._medicineDatabase.honeyBee;
//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(medicinTable, orderBy: '$medId ASC');
    return result;
  }

  Future<List<MedicineInfo>> getFMedicine() async {
    List<MedicineInfo> _medicn = [];

    var db = await this._medicineDatabase.honeyBee;
    var result = await db.query(medicinTable);
    result.forEach((element) {
      var medicineInfo = MedicineInfo.fromMap(element);
      _medicn.add(medicineInfo);
    });

    return _medicn;
  }

  Future<int> insert_medicine(Medicine medicine) async {
    Database db = await this._medicineDatabase.honeyBee;
    try {
      var result = await db.insert(medicinTable, medicine.toMap());
      return result;
    } catch (e) {
      return getIdMedicine(medicinTable,medicine.medTitle);
    }
  }

  Future<List<MedicineInfo>> getselectMedicine(String name) async {
    List<MedicineInfo> _medicn = [];
    var db = await this._medicineDatabase.honeyBee;
    var result = await db.rawQuery(
        'SELECT $medicinTable.$medId,$medTitle,$medform,$diagid FROM $medicinTable,$diagonTable,$patientTable'
            ' WHERE $diagonTable.$patId = $patientTable.$patId AND $diagonTable.$medId = $medicinTable.$medId '
            'AND $patientTable.$patname =?',
        ['$name']);
    result.forEach((element) {
      var medicineInfo = MedicineInfo.fromMap(element);
      _medicn.add(medicineInfo);
    });

    return _medicn;
  }

  Future<int> updateMedicine(Medicine medicine) async {
    var db = await this._medicineDatabase.honeyBee;
    var result = await db.update(medicinTable, medicine.toMap(),
        where: '$medId = ?', whereArgs: [medicine.medId]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteMedicine(int id) async {
    var db = await this._medicineDatabase.honeyBee;
    int result =
    await db.rawDelete('DELETE FROM $medicinTable WHERE $medId = $id');
    return result;
  }

  Future<int> deleteselectedMedicine(MedicineInfo medicineInfo) async {
    var db = await this._medicineDatabase.honeyBee;
    int result = 0;
    if (medicineInfo.diagonid != null) {
      result = await db.rawDelete(
          'DELETE FROM $dayTimesTable WHERE $diagid = ${medicineInfo.diagonid}');
      result = await db.rawDelete(
          'DELETE FROM $diagonTable WHERE $diagid = ${medicineInfo.diagonid}');
      result = await db.rawDelete(
          'DELETE FROM $medicinTable WHERE $medId = ${medicineInfo.medId}');
    }
    if (result != 0) testDay();

    return result;
  }


  testDay() async {
    var db = await this._medicineDatabase.honeyBee;
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
  }  Future<int> getCountDayesTime(int id) async {
    Database db = await this._medicineDatabase.honeyBee;
    List<Map<String, dynamic>> x = await db
        .rawQuery('SELECT COUNT (*) from $dayTimesTable where $dayesId = $id');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
  Future<int> deleteDayes(int id) async {
    var db = await this._medicineDatabase.honeyBee;
    int result =
    await db.rawDelete('DELETE FROM $midDayesTable WHERE $dayesId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount_Medicine() async {
    Database db = await this._medicineDatabase.honeyBee;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $medicinTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Medicine>> getMedicineList() async {
    var medicineMapList =
    await getMedicineMapList(); // Get 'Map List' from database
    int count =
        medicineMapList.length; // Count the number of map entries in db table
    List<Medicine> medicineList = List<Medicine>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      medicineList.add(Medicine.fromMapObject(medicineMapList[i]));
    }

    return medicineList;
  }



  Future<int> getIdMedicine(table,String title) async {
    // get a reference to the database
    Database db = await this._medicineDatabase.honeyBee;
    // get single row
    List<String> columnsToSelect = [medId];
    String whereString = '${medTitle} = ?';
    int rowId = 0;
    List<dynamic> whereArguments = ['$title'];
    List<Map> result = await db.query(table,
        columns: columnsToSelect,
        where: whereString,
        whereArgs: whereArguments);
    // print the results
    rowId = Sqflite.firstIntValue(result);
    return rowId;
  }


}