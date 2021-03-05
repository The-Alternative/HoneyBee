import '../../../utils/service_locator.dart';
import '../model/MedicineInfo.dart';
import '../service/medicineViewService/medicineViewService.dart';
import 'dart:async';

class MedicineViewController {
  final MedicineViewService _medicineView  =  locator<MedicineViewService>();

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