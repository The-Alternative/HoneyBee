import 'package:bassel/models/children/childHabit.dart';
import 'package:bassel/services/children/childHabitService.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:bassel/utils/databaseConfig.dart';

class ChildHabitController {

  final ChildHabitService childHabitService = new ChildHabitService();

  Future<int> saveChildHabit(ChildHabit childHabit) async{
    return await this.childHabitService.saveChildHabit(childHabit);
  }

  Future<List> getAllChildHabits() async{
    return await this.childHabitService.getAllChildHabits();
  }

  Future<List> getNegativeChildHabits(int id) async{
    return await this.childHabitService.getNegativeChildHabits(id);
  }

  Future<List> getNegativeChildHabit(int id,int childHabitId) async{
    return await this.childHabitService.getNegativeChildHabit(id, childHabitId);
  }

  Future<List> getPositiveChildHabits(int id) async{
    return await this.childHabitService.getPositiveChildHabits(id);
  }

  Future<int> getChildHabitsCount () async{
    return await this.childHabitService.getChildHabitsCount();
  }

   Future<int>childHabitExist (int childId,int habitId) async {
     return await this.childHabitService.childHabitExist(childId, habitId);

  }

  Future<List> getChildHabits (int id) async{
    return await this.childHabitService.getChildHabits(id);
  }


  Future<int> updateChildHabit(ChildHabit childHabit) async{
    return await this.childHabitService.updateChildHabit(childHabit);
  }

  Future<int> deleteChildHabit(ChildHabit childHabit) async{
    return await this.childHabitService.deleteChildHabit(childHabit);
  }

  close() async{
    return await this.childHabitService.close();
  }
}