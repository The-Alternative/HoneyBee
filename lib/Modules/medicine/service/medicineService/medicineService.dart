import '../../model/Medicine.dart';
import '../../model/MedicineInfo.dart';
import '../../model/MedicineTimes.dart';

abstract class MedicineService{
  //insert something to database
  Future<int> insertData(String table, Map<String, dynamic> data);
  //get all data from database
  Future<List<Map<String, dynamic>>> getAllData(table);
  //delete data
  Future<int> deleteData(String table, int id);
  Future<List<Map<String, dynamic>>> getDayTimesMapList();
  Future<int> insert_DayTimes(MedicineTimes medicineTimes);
  Future<int> updateDayTimes(MedicineTimes medicineTimes);
  // Delete Operation: deleteDayTimes object from database
  Future<int> deleteDayTimes(int id, int day);
  // Get number of Times objects in database
  Future<int> getCountDayTimes();
  // Get the 'Map List' [ List<Map> ] and convert it to 'medicine List' [ List<medicine> ]
  Future<List<MedicineTimes>> getDayTimesList();
  Future<List<Map<String, dynamic>>> getMedicineMapList();
  Future<List<MedicineInfo>> getFMedicine();
  Future<int> insert_medicine(Medicine medicine);
  Future<List<MedicineInfo>> getselectMedicine(String name);
  Future<int> updateMedicine(Medicine medicine);
  // Delete Operation: Delete an  object from database
  Future<int> deleteMedicine(int id);
  Future<int> deleteselectedMedicine(MedicineInfo medicineInfo);
  testDay();
  Future<int> getCountDayesTime(int id);
  Future<int> deleteDayes(int id);
  // Get number of Note objects in database
  Future<int> getCount_Medicine();
  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Medicine>> getMedicineList();
  Future<int> getIdMedicine(table, String title);

}