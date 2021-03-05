import 'package:sqflite/sqflite.dart';

import '../../model/MedicineInfo.dart';
import '../../../../utils/databaseconfig.dart';
import 'medicineViewService.dart';

class MedicineViewServiceDatabase extends MedicineViewService{

  String medicinView = 'med_view';
  String medId = 'id'; //primry/forign..key
  String medTitle = 'title';
  String patname = 'p_name';


  DatabaseConfig _medicineDatabase = DatabaseConfig();

  @override
  Future<int> getIdMedicine(table, String title) async {
    // TODO: implement getIdMedicine
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

  @override
  Future<List<Map<String,dynamic>>> getInfo(table) async {
    // TODO: implement getInfo
    Database db = await this._medicineDatabase.honeyBee;
    var result = await db.query(table);

    return result;
  }

  @override
  Future<List<MedicineInfo>> getselectRMedicine(String name) async {
    // TODO: implement getselectRMedicine
    List<MedicineInfo> _medicn = [];

    Database db = await this._medicineDatabase.honeyBee;
    var result = await db.rawQuery(
        'SELECT * FROM $medicinView WHERE $patname =?', ['$name']);
    result.forEach((element) {
      var medicineInfo = MedicineInfo.fromMap(element);
      _medicn.add(medicineInfo);
    });

    return _medicn;
  }

  @override
  Future<int> insertRecordMedicine(MedicineInfo medicine) async {
    // TODO: implement insertRecordMedicine
    Database db = await this._medicineDatabase.honeyBee;
    int id;
    try {
      id = await db.insert(medicinView, medicine.toMap());
      return id;
    } catch (e) {
      id =await getIdMedicine(medicinView,medicine.medTitle);
      print('mosa $id');
      await db.update(medicinView,medicine.toMap(), where: "$medId = ?",whereArgs: [id]);
    }
    return 1;
  }

}