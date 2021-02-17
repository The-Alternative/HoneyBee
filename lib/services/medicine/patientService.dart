import 'package:bassel/utils/databaseconfig.dart';
import 'package:bassel/models/medicine/Patient.dart';
import 'package:sqflite/sqflite.dart';

class PatientService{

  String patientTable = 'patent_table';
  String patname = 'p_name';
  String patId = 'p_id'; //primry/forign..key
  DatabaseConfig _medicineDatabase = DatabaseConfig();



  ////////////////////////////////////////////patient///////////////////////////////

  Future<List<Map<String, dynamic>>> getPatientMapList() async {
    Database db = await this._medicineDatabase.honeyBee;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = db.query(patientTable, orderBy: '$patId ASC');
    return result;
  }


  Future<int> insertPatient(Patient patient) async {
    Database db = await this._medicineDatabase.honeyBee;
    try {
      var result = await db.insert(patientTable, patient.toMap());
      return result;
    } catch (e) {
      return getIdPatient(patient.patName);
    }
  }

  Future<int> updatePatient(Patient patient) async {
    var db = await this._medicineDatabase.honeyBee;
    var result = db.update(patientTable, patient.toMap(),
        where: '$patId = ?', whereArgs: [patient.patId]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deletePatient(int id) async {
    var db = await this._medicineDatabase.honeyBee;
    int result =
    await db.rawDelete('DELETE FROM $patientTable WHERE $patId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCountPatient() async {
    Database db = await this._medicineDatabase.honeyBee;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $patientTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Patient>> getPatientList() async {
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
  Future<List<Patient>> getPatientNameList() async {
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
  Future<int> getIdPatient(String name) async {
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

  }