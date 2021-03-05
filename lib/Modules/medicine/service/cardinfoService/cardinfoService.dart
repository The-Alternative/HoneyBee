import '../../model/MedicineInfo.dart';

abstract class CardinfoService{
  Future<List<Map<String, dynamic>>> getptname(int id, String name);
  Future<List<MedicineInfo>> getAllTimes(String name);

}