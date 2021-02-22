import 'package:bassel/models/medicine/MedicineInfo.dart';
import 'package:bassel/services/medicine/cardinfoService.dart';
import 'package:bassel/services/medicine/medicineDayService.dart';
import 'package:bassel/services/medicine/medicineService.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class MedicineController {

  final MedicineService _medicineinfoService = MedicineService();


  Future<int> insert(medicine) async {
    return await this._medicineinfoService.insert_medicine(medicine);
  }

  Future<int> deleteMedicine(int id) async {
    return await this._medicineinfoService.deleteMedicine(id);
  }

  Future<int> deleteselectedMedicine( medicineInfo) async {
    return await this._medicineinfoService.deleteselectedMedicine(medicineInfo);
  }

  Future<List<MedicineInfo>> getFMedicine() async {
    return await this._medicineinfoService.getFMedicine();

  }

  Future<List<MedicineInfo>> getselectMedicine( name) async {
    return await this._medicineinfoService.getselectMedicine(name);

  }

}