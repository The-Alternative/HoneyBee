import '../../model/childHabit.dart';

abstract class ChildHabitService{
  Future<int> saveChildHabit(ChildHabit childHabit);
  Future<List> getAllChildHabits();
  Future<List> getNegativeChildHabits(int id);
  Future<List> getNegativeChildHabit(int id,int childHabitId);
  Future<List> getPositiveChildHabits(int id);
  Future<int> getChildHabitsCount ();
  Future<int>childHabitExist (int childId,int habitId);
  Future<List> getChildHabits (int id);
  Future<int> updateChildHabit(ChildHabit childHabit);
  Future<int> deleteChildHabit(ChildHabit childHabit);
  close();
}