import '../../model/habitType.dart';

abstract class HabitTypeService{
  Future<int> saveHabitType(HabitType habitType);
  Future<List> getAllHabitTypes();
  Future<int> getHabitTypesCount ();
  Future<HabitType> getHabitType (int id);
  Future<int> updateHabitType(HabitType habitType);
  Future<int> deleteHabitType(int id);
  close();
}