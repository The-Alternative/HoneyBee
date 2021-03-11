
import 'dart:async';

import 'package:HoneyBee/models/medicine/MedicineInfo.dart';
import 'package:HoneyBee/services/medicine/medicineService.dart';

class MedicineController {

  final MedicineService _medicineinfoService = MedicineService();


  Future<int> insert(medicine) async {
    return this._medicineinfoService.insert_medicine(medicine);
  }

  Future<int> deleteMedicine(int id) async {
    return this._medicineinfoService.deleteMedicine(id);
  }

  Future<int> deleteselectedMedicine( medicineInfo) async {
    return this._medicineinfoService.deleteselectedMedicine(medicineInfo);
  }

  Future<List<MedicineInfo>> getFMedicine() async {
    return this._medicineinfoService.getFMedicine();

  }

  Future<List<MedicineInfo>> getselectMedicine( name) async {
    return this._medicineinfoService.getselectMedicine(name);

  }
  Future<int> updateMedicine( medicine) async {
    return this._medicineinfoService.updateMedicine(medicine);

  }
}