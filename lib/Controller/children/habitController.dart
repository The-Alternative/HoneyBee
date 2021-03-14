import '../../models/children/habit.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../../utils/databaseConfig.dart';

class HabitController {

  final String habitTable = 'habitTable';
  final String cloumnId = 'id';
  final String cloumnName = 'name';
  final String cloumnIsActive = 'isActive';
  final String cloumnCreatedDate = 'createdDate';
  final String cloumnTypeId = 'typeId';
  final DatabaseConfig db = new DatabaseConfig();

  Future<int> savehabit(Habit habit) async{
    try{
      var dbClient = await db.honeyBee;
      int result = await dbClient.insert("$habitTable", habit.toMap());
      return result;
    }catch(e){
      return -1;
    }

  }

  Future<List> getAllHabits() async{
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

  Future<List> getNegaiveHabits() async{
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

  Future<List> getPositiveHabits() async{
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

  Future<int> getHabitsCount () async{
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

  Future<Habit> getHabit (int id) async{
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

  Future<int> updateHabit(Habit habit) async{
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.update(
          habitTable, habit.toMap(),where: "$cloumnId",whereArgs: [habit.id]
      );
    }catch(e){
      return -1;
    }

  }

  Future<int> deleteHabit(Habit habit) async{
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

  close() async{
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.close();
    }catch(e){
      return -1;
    }

  }
}