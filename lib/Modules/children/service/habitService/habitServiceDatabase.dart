import '../../model/habit.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../utils/databaseconfig.dart';
import 'habitService.dart';

class HabitServiceDatabase extends HabitService{

  final String habitTable = 'habitTable';
  final String cloumnId = 'id';
  final String cloumnName = 'name';
  final String cloumnIsActive = 'isActive';
  final String cloumnCreatedDate = 'createdDate';
  final String cloumnTypeId = 'typeId';
  final DatabaseConfig db = new DatabaseConfig();

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
  Future<int> deleteHabit(Habit habit) async {
    // TODO: implement deleteHabit
    try{
      var dbClient = await db.honeyBee;
      Habit dhabit = new Habit(habit.name, 0, habit.typeId, habit.createdDate);
      return await dbClient.update(
          habitTable, dhabit.toMap(),where: "$cloumnId",whereArgs: [habit.id]
      );
    }catch(e){
      return -1;
    }
  }

  @override
  Future<List> getAllHabits() async {
    // TODO: implement getAllHabits
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $habitTable";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }
  }

  @override
  Future<Habit> getHabit(int id) async {
    // TODO: implement getHabit
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $habitTable WHERE $cloumnId = $id";
      var result = await dbClient.rawQuery(sql);
      if(result.length == 0) return null;
      return new Habit.fromeMap(result.first);
    }catch(e){
      Habit err = new Habit(e,e,e,e);
      return err;
    }
  }

  @override
  Future<int> getHabitsCount() async {
    // TODO: implement getHabitsCount
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT COUNT(*) FROM $habitTable";
      return Sqflite.firstIntValue(
          await dbClient.rawQuery(sql)
      );
    }catch(e){
      return -1;
    }
  }

  @override
  Future<List> getNegaiveHabits() async {
    // TODO: implement getNegaiveHabits
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $habitTable WHERE $cloumnTypeId = 1";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }
  }

  @override
  Future<List> getPositiveHabits() async {
    // TODO: implement getPositiveHabits
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $habitTable WHERE $cloumnTypeId = 2";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }
  }

  @override
  Future<int> savehabit(Habit habit) async {
    // TODO: implement savehabit
    try{
      var dbClient = await db.honeyBee;
      int result = await dbClient.insert("$habitTable", habit.toMap());
      return result;
    }catch(e){
      return -1;
    }
  }

  @override
  Future<int> updateHabit(Habit habit) async {
    // TODO: implement updateHabit
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.update(
          habitTable, habit.toMap(),where: "$cloumnId",whereArgs: [habit.id]
      );
    }catch(e){
      return -1;
    }
  }
  
}