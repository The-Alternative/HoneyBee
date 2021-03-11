import '../../models/children/habit.dart';
import '../../services/children/habitService.dart';
import 'dart:async';

class HabitController {

  final HabitService habitService = new HabitService();

  Future<int> savehabit(Habit habit) async{
    return await this.habitService.savehabit(habit);
  }

  Future<List> getAllHabits() async{
    return await this.habitService.getAllHabits();
  }

  Future<List> getNegaiveHabits() async{
    return await this.habitService.getNegaiveHabits();
  }

  Future<List> getPositiveHabits() async{
    return await this.habitService.getPositiveHabits();
  }

  Future<int> getHabitsCount () async{
    return await this.habitService.getHabitsCount();
  }

  Future<Habit> getHabit (int id) async{
    return await this.habitService.getHabit(id);
  }

  Future<int> updateHabit(Habit habit) async{
    return await this.habitService.updateHabit(habit);
  }

  Future<int> deleteHabit(Habit habit) async{
    return await this.habitService.deleteHabit(habit);
  }

  close() async{
    return await this.habitService.close();
  }
}