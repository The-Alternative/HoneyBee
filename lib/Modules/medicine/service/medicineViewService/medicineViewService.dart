import '../../model/MedicineInfo.dart';

abstract class MedicineViewService{
  Future<int> insertRecordMedicine(MedicineInfo medicine);
  Future<int> getIdMedicine(table,String title);
  Future<List<Map<String,dynamic>>> getInfo(table);
  Future<List<MedicineInfo>> getselectRMedicine(String name);

}