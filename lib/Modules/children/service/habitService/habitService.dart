import '../../model/habit.dart';

abstract class HabitService {
  Future<int> savehabit(Habit habit);
  Future<List> getAllHabits();
  Future<List> getNegaiveHabits();
  Future<List> getPositiveHabits();
  Future<int> getHabitsCount ();
  Future<Habit> getHabit (int id);
  Future<int> updateHabit(Habit habit);
  Future<int> deleteHabit(Habit habit);
  close();


}