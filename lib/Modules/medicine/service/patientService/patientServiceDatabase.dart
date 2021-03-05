import 'package:sqflite/sqflite.dart';
import '../../../../Config/general.dart';
import '../../model/Patient.dart';

import 'patientService.dart';
import '../../../../utils/databaseconfig.dart';

class PatientServiceDatabase extends PatientService{

  String patientTable = 'patent_table';
  String patname = 'p_name';
  String patId = 'p_id'; //primry/forign..key
  DatabaseConfig _medicineDatabase = DatabaseConfig();

  @override
  Future<int> deletePatient(int id) async {
    // TODO: implement deletePatient
    var db = await this._medicineDatabase.honeyBee;
    int result =
    await db.rawDelete('DELETE FROM $patientTable WHERE $patId = $id');
    return result;
  }

  @override
  Future<int> getCountPatient() async {
    // TODO: implement getCountPatient
    Database db = await this._medicineDatabase.honeyBee;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $patientTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  @override
  Future<int> getIdPatient(String name) async {
    // TODO: implement getIdPatient
    // get a reference to the database
    Database db = await this._medicineDatabase.honeyBee;

    // get single row
    List<String> columnsToSelect = [patId];
    String whereString = '${patname} = ?';
    int rowId = 0;
    List<dynamic> whereArguments = [name];
    List<Map> result = await db.query(patientTable,
        columns: columnsToSelect,
        where: whereString,
        whereArgs: whereArguments);

    // print the results
    rowId = Sqflite.firstIntValue(result);
    return rowId;
  }

  @override
  Future<List<Patient>> getPatientList() async {
    // TODO: implement getPatientList
    var patientMapList = await getPatientMapList(); // Get 'Map List' from database
    int count =
        patientMapList.length; // Count the number of map entries in db table

    List<Patient> patientList = List<Patient>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      patientList.add(Patient.fromMapObject(patientMapList[i]));
    }

    return patientList;
  }

  @override
  Future<List<Map<String,dynamic>>> getPatientMapList() async {
    // TODO: implement getPatientMapList
    Database db = await this._medicineDatabase.honeyBee;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = db.query(patientTable, orderBy: '$patId ASC');
    return result;
  }

  @override
  Future<List<Patient>> getPatientNameList() async {
    // TODO: implement getPatientNameList
    var patientMapList =
    await getPatientMapList(); // Get 'Map List' from database
    int count =
        patientMapList.length; // Count the number of map entries in db table

    List<Patient> patientList = List<Patient>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      patientList.add(Patient.fromMapObject(patientMapList[i]));
    }

    return patientList;
  }

  @override
  Future<int> insertPatient(Patient patient) async {
    // TODO: implement insertPatient
    bool test = await testPatientNumber();
    if( test)
    {
      Database db = await this._medicineDatabase.honeyBee;
      try {
        var result = await db.insert(patientTable, patient.toMap());
        return result;
      } catch (e) {
        return getIdPatient(patient.patName);
      }
    }
    else return 0;
  }

  @override
  Future<bool> testPatientNumber() async {
    // TODO: implement testPatientNumber
    int count =await getCountPatient();
    if (count< limitUser)
      return true;
    else
      return false;
  }

  @override
  Future<int> updatePatient(Patient patient) async {
    // TODO: implement updatePatient
    var db = await this._medicineDatabase.honeyBee;
    var result = db.update(patientTable, patient.toMap(),
        where: '$patId = ?', whereArgs: [patient.patId]);
    return result;
  }

}