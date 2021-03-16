import '../../database/databaseconfig.dart';
import '../../models/medicine/Diagon.dart';
import 'package:sqflite/sqflite.dart';

class DiagonController{
  String diagonTable = 'diagon_table';
  String diagid = 'd_id'; //primry/forign..key

  DatabaseConfig _medicineDatabase = DatabaseConfig();

  //init database

//////////////////////////////////////////////////diagon///////////////////////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getDiagonMapList() async {
    Database db = await this._medicineDatabase.honeyBee;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(diagonTable, orderBy: '$diagid ASC');
    return result;
  }

  Future<int> insertDiagon(Diagon diagon) async {
    Database db = await this._medicineDatabase.honeyBee;
    var result = await db.insert(diagonTable, diagon.toMap());
    return result;
  }

  Future<int> updateDiagon(Diagon diagon) async {
    var db = await this._medicineDatabase.honeyBee;
    var result = await db.update(diagonTable, diagon.toMap(),
        where: '$diagid = ?', whereArgs: [diagon.diagonId]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteDiagon(int id) async {
    var db = await this._medicineDatabase.honeyBee;
    int result =
    await db.rawDelete('DELETE FROM $diagonTable WHERE $diagid = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCountDiagon() async {
    Database db = await this._medicineDatabase.honeyBee;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $diagonTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Diagon>> getDiagonList() async {
    var diagonMapList =
    await getDiagonMapList(); // Get 'Map List' from database
    int count =
        diagonMapList.length; // Count the number of map entries in db table
    List<Diagon> diagonList = List<Diagon>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      diagonList.add(Diagon.fromMapObject(diagonMapList[i]));
    }
    return diagonList;
  }


  }

