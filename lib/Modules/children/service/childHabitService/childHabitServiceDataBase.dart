import '../../model/childHabit.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../../../../utils/databaseConfig.dart';
import 'childHabitService.dart';

class ChildHabitServiceDatabase extends ChildHabitService {
  final String childHabitTable = 'childHabitTable';
  final String cloumnId = 'id';
  final String cloumnIsActive = 'isActive';
  final String cloumnCreatedDate = 'createdDate';
  final String cloumnHabitId = 'habitId';
  final String cloumnChildId = 'childId';
  final DatabaseConfig db = new DatabaseConfig();

  @override
  Future<int> childHabitExist(int childId, int habitId) async {
    // TODO: implement childHabitExist
    try{
      var dbClient = await db.honeyBee;
      var sql = "SELECT COUNT(*) FROM $childHabitTable WHERE $cloumnChildId = $childId AND $cloumnHabitId=$habitId";
      return Sqflite.firstIntValue(
          await dbClient.rawQuery(sql)
      );
    }catch(e){
      return -1;
    }
  }

  @override
  close() async {
    // TODO: implement close
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.close();
    }catch(e){
      return -1;
    }
  }

  @override
  Future<int> deleteChildHabit(ChildHabit childHabit) async {
    // TODO: implement deleteChildHabit
    try{
      var dbClient = await db.honeyBee;
//    ChildHabit dchildhabit = new ChildHabit.fromeMap(
//      {
//        'id' : childHabit.id,
//        'isActive' : 0,
//        'createdDate' : childHabit.createdDate,
//        'habitId' : childHabit.habitId,
//        'childId' : childHabit.childId
//      }

//    );
      return await dbClient.delete(
          childHabitTable,where: "$cloumnId = ${childHabit.id}"
      );
    }catch(e){
      return -1;
    }
  }

  @override
  Future<List> getAllChildHabits() async  {
    // TODO: implement getAllChildHabits
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $childHabitTable";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }
  }

  @override
  Future<List> getChildHabits(int id) async {
    // TODO: implement getChildHabits
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $childHabitTable WHERE $cloumnChildId = $id";
      var result = await dbClient.rawQuery(sql);
      if(result.length == 0) return null;
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }
  }

  @override
  Future<int> getChildHabitsCount()async {
    // TODO: implement getChildHabitsCount
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT COUNT(*) FROM $childHabitTable";
      return Sqflite.firstIntValue(
          await dbClient.rawQuery(sql)
      );
    }catch(e){
      return -1;
    }
  }

  @override
  Future<List> getNegativeChildHabit(int id, int childHabitId)async {
    // TODO: implement getNegativeChildHabit
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $childHabitTable WHERE $cloumnChildId=$id AND $cloumnIsActive = 1 AND $cloumnId = $childHabitId";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }
  }

  @override
  Future<List> getNegativeChildHabits(int id) async {
    // TODO: implement getNegativeChildHabits
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $childHabitTable WHERE $cloumnChildId=$id AND $cloumnIsActive = 1";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }
  }

  @override
  Future<List> getPositiveChildHabits(int id)async {
    // TODO: implement getPositiveChildHabits
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $childHabitTable WHERE $cloumnChildId=$id AND $cloumnIsActive = 1";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }
  }

  @override
  Future<int> saveChildHabit(ChildHabit childHabit)async {
    // TODO: implement saveChildHabit
    try{
      var dbClient = await db.honeyBee;
      int result = await dbClient.insert("$childHabitTable", childHabit.toMap());
      return result;
    }catch(e){
      print(e);
      return -1;
    }
  }

  @override
  Future<int> updateChildHabit(ChildHabit childHabit)async {
    // TODO: implement updateChildHabit
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.update(
          childHabitTable, childHabit.toMap(),where: "$cloumnId",whereArgs: [childHabit.id]
      );
    }catch(e){
      return -1;
    }
  }

}