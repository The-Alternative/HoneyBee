import '../../model/MedicineTimes.dart';

abstract class TimesDayesService {
  Future<List<Map<String, dynamic>>> getDayTimesMapList();
  Future<int> insert_DayTimes(MedicineTimes medicineTimes);
  Future<int> updateDayTimes(MedicineTimes medicineTimes);
  // Delete Operation: Delete a Note object from database
  Future<int> deleteDayTimes(int id, int day);
  Future<int> getCountDayesTime(int id);
  // Delete Operation: Delete a Note object from database
  Future<int> deleteDayes(int id);
  // Get number of Note objects in database
  Future<int> getCountDayTimes();
  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<MedicineTimes>> getDayTimesList();
  testDay();
  Future<int> getIdDay(String name);

}