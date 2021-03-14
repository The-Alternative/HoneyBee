import '../../models/children/habitType.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../../utils/databaseConfig.dart';

class HabitTypeController {

  final String habitTypeTable = 'habitTypeTable';
  final String cloumnId = 'id';
  final String cloumnName = 'name';
  final DatabaseConfig db = new DatabaseConfig();

  Future<int> saveHabitType(HabitType habitType) async{
    try{
      var dbClient = await db.honeyBee;
      int result = await dbClient.insert("$habitTypeTable", habitType.toMap());
      return result;
    }catch(e){
      return -1;
    }

  }

  Future<List> getAllHabitTypes() async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $habitTypeTable";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }

  }

  Future<int> getHabitTypesCount () async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT COUNT(*) FROM $habitTypeTable";
      return Sqflite.firstIntValue(
          await dbClient.rawQuery(sql)
      );
    }catch(e){
      return -1;
    }

  }

  Future<HabitType> getHabitType (int id) async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $habitTypeTable WHERE $cloumnId = $id";
      var result = await dbClient.rawQuery(sql);
      if(result.length == 0) return null;
      return new HabitType.fromeMap(result.first);
    }catch(e){
      HabitType err = new HabitType(e);
      return err;
    }

  }

  Future<int> updateHabitType(HabitType habitType) async{
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.update(
          habitTypeTable, habitType.toMap(),where: "$cloumnId",whereArgs: [habitType.id]
      );
    }catch(e){
      return -1;
    }

  }

  Future<int> deleteHabitType(int id) async {
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.delete(
          habitTypeTable, where: "$cloumnId", whereArgs: [id]);
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