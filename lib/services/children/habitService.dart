import 'package:bassel/models/children/habit.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:bassel/utils/databaseConfig.dart';

class HabitService {

  final String habitTable = 'habitTable';
  final String cloumnId = 'id';
  final String cloumnName = 'name';
  final String cloumnIsActive = 'isActive';
  final String cloumnCreatedDate = 'createdDate';
  final String cloumnTypeId = 'typeId';
  final DatabaseConfig db = new DatabaseConfig();

  Future<int> savehabit(Habit habit) async{
    var dbClient = await db.honeyBee;
    int result = await dbClient.insert("$habitTable", habit.toMap());
    return result;
  }

  Future<List> getAllHabits() async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $habitTable";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<List> getNegaiveHabits() async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $habitTable WHERE $cloumnTypeId = 1";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<List> getPositiveHabits() async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $habitTable WHERE $cloumnTypeId = 2";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<int> getHabitsCount () async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT COUNT(*) FROM $habitTable";
    return Sqflite.firstIntValue(
        await dbClient.rawQuery(sql)
    );
  }

  Future<Habit> getHabit (int id) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $habitTable WHERE $cloumnId = $id";
    var result = await dbClient.rawQuery(sql);
    if(result.length == 0) return null;
    return new Habit.fromeMap(result.first);
  }

  Future<int> updateHabit(Habit habit) async{
    var dbClient = await db.honeyBee;
    return await dbClient.update(
        habitTable, habit.toMap(),where: "$cloumnId",whereArgs: [habit.id]
    );
  }

  Future<int> deleteHabit(Habit habit) async{
    var dbClient = await db.honeyBee;
    Habit dhabit = new Habit(habit.name, 0, habit.typeId, habit.createdDate);
    return await dbClient.update(
        habitTable, dhabit.toMap(),where: "$cloumnId",whereArgs: [habit.id]
    );
  }

  close() async{
    var dbClient = await db.honeyBee;
    return await dbClient.close();
  }
}