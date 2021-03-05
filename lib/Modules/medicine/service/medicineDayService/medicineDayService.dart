import '../../model/medicineDays.dart';
import '../../model/MedicineTimes.dart';

abstract class MedicineDayService{
  Future<List<Map<String, dynamic>>> getmidDayesMapList(String name);
  Future<int> insertDayes(MedicineDays days);
  Future<int> getIdDay(String name);
  Future<int> updateDayes(MedicineDays days);
  Future<int> deleteDayes(int id);
  Future<int> getCountDayes();
  Future<int> getCountDayesTime(int id);
  Future<List<MedicineDays>> getselectmidDayesList(String name);
  Future<int> updateDayTimes(MedicineTimes medicineTimes);
}