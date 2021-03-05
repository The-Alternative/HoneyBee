import '../model/childHabit.dart';
import '../service/childHabitService/childHabitService.dart';
import '../../../utils/service_locator.dart';
import 'dart:async';

class ChildHabitController {

  ChildHabitService _childHabitService =  locator<ChildHabitService>() ;

  Future<int> saveChildHabit(ChildHabit childHabit) async{
    return await this._childHabitService.saveChildHabit(childHabit);
  }

  Future<List> getAllChildHabits() async{
    return await this._childHabitService.getAllChildHabits();
  }

  Future<List> getNegativeChildHabits(int id) async{
    return await this._childHabitService.getNegativeChildHabits(id);
  }

  Future<List> getNegativeChildHabit(int id,int childHabitId) async{
    return await this._childHabitService.getNegativeChildHabit(id, childHabitId);
  }

  Future<List> getPositiveChildHabits(int id) async{
    return await this._childHabitService.getPositiveChildHabits(id);
  }

  Future<int> getChildHabitsCount () async{
    return await this._childHabitService.getChildHabitsCount();
  }

   Future<int>childHabitExist (int childId,int habitId) async {
     return await this._childHabitService.childHabitExist(childId, habitId);

  }

  Future<List> getChildHabits (int id) async{
    return await this._childHabitService.getChildHabits(id);
  }


  Future<int> updateChildHabit(ChildHabit childHabit) async{
    return await this._childHabitService.updateChildHabit(childHabit);
  }

  Future<int> deleteChildHabit(ChildHabit childHabit) async{
    return await this._childHabitService.deleteChildHabit(childHabit);
  }

  close() async{
    return await this._childHabitService.close();
  }
}