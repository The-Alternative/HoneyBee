import 'package:bassel/models/children/childHabit.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:bassel/utils/databaseConfig.dart';

class ChildHabitService {

  final String childHabitTable = 'childHabitTable';
  final String cloumnId = 'id';
  final String cloumnIsActive = 'isActive';
  final String cloumnCreatedDate = 'createdDate';
  final String cloumnHabitId = 'habitId';
  final String cloumnChildId = 'childId';
  final DatabaseConfig db = new DatabaseConfig();

  Future<int> saveChildHabit(ChildHabit childHabit) async{
    var dbClient = await db.honeyBee;
    int result = await dbClient.insert("$childHabitTable", childHabit.toMap());
    return result;
  }

  Future<List> getAllChildHabits() async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $childHabitTable";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<List> getNegativeChildHabits(int id) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $childHabitTable WHERE $cloumnChildId=$id AND $cloumnIsActive = 1";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<List> getNegativeChildHabit(int id,int childHabitId) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $childHabitTable WHERE $cloumnChildId=$id AND $cloumnIsActive = 1 AND $cloumnId = $childHabitId";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<List> getPositiveChildHabits(int id) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $childHabitTable WHERE $cloumnChildId=$id AND $cloumnIsActive = 1";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<int> getChildHabitsCount () async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT COUNT(*) FROM $childHabitTable";
    return Sqflite.firstIntValue(
        await dbClient.rawQuery(sql)
    );
  }

  Future<int>childHabitExist (int childId,int habitId) async {
    var dbClient = await db.honeyBee;
    var sql = "SELECT COUNT(*) FROM $childHabitTable WHERE $cloumnChildId = $childId AND $cloumnHabitId=$habitId";
    return Sqflite.firstIntValue(
        await dbClient.rawQuery(sql)
    );

  }

  Future<List> getChildHabits (int id) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $childHabitTable WHERE $cloumnChildId = $id";
    var result = await dbClient.rawQuery(sql);
    if(result.length == 0) return null;
    return result.toList();
  }


  Future<int> updateChildHabit(ChildHabit childHabit) async{
    var dbClient = await db.honeyBee;
    return await dbClient.update(
        childHabitTable, childHabit.toMap(),where: "$cloumnId",whereArgs: [childHabit.id]
    );
  }

  Future<int> deleteChildHabit(ChildHabit childHabit) async{
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
  }

  close() async{
    var dbClient = await db.honeyBee;
    return await dbClient.close();
  }
}