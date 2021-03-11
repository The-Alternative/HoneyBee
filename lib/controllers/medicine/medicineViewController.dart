
import '../../models/medicine/MedicineInfo.dart';
import '../../services/medicine/medicineViewService.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class MedicineViewController {
  final MedicineView _medicineView  =  MedicineView();

  Future<int> insertRecordMedicine(MedicineInfo medicine) async {
    return await this._medicineView.insertRecordMedicine(medicine);
  }
  Future<List<Map<String,dynamic>>> getInfo(table) async {
    await this._medicineView.getInfo(table);

  }
  Future<List<MedicineInfo>> getselectRMedicine(String name) async {
    return await this._medicineView.getselectRMedicine(name);

  }

}