import '../../model/Diagon.dart';
import 'package:sqflite/sqflite.dart';

import 'diagonService.dart';
import '../../../../utils/databaseconfig.dart';

class DiagonServiceDatabase extends DiagonService{

  String diagonTable = 'diagon_table';
  String diagid = 'd_id'; //primry/forign..key

  DatabaseConfig _medicineDatabase = DatabaseConfig();

  @override
  Future<int> deleteDiagon(int id) async {
    // TODO: implement deleteDiagon
    var db = await this._medicineDatabase.honeyBee;
    int result =
    await db.rawDelete('DELETE FROM $diagonTable WHERE $diagid = $id');
    return result;
  }

  @override
  Future<int> getCountDiagon() async {
    // TODO: implement getCountDiagon
    Database db = await this._medicineDatabase.honeyBee;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $diagonTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  @override
  Future<List<Diagon>> getDiagonList() async {
    // TODO: implement getDiagonList
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

  @override
  Future<List<Map<String,dynamic>>> getDiagonMapList() async {
    // TODO: implement getDiagonMapList
    Database db = await this._medicineDatabase.honeyBee;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(diagonTable, orderBy: '$diagid ASC');
    return result;
  }

  @override
  Future<int> insertDiagon(Diagon diagon) async {
    // TODO: implement insertDiagon
    Database db = await this._medicineDatabase.honeyBee;
    var result = await db.insert(diagonTable, diagon.toMap());
    return result;
  }

  @override
  Future<int> updateDiagon(Diagon diagon) async {
    // TODO: implement updateDiagon
    var db = await this._medicineDatabase.honeyBee;
    var result = await db.update(diagonTable, diagon.toMap(),
        where: '$diagid = ?', whereArgs: [diagon.diagonId]);
    return result;
  }

}