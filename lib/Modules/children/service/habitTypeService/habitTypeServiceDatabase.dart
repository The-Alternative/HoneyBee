import '../../model/habitType.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../utils/databaseconfig.dart';
import 'habitTypeService.dart';

class HabitTypeServiceDatabase extends HabitTypeService{
  final String habitTypeTable = 'habitTypeTable';
  final String cloumnId = 'id';
  final String cloumnName = 'name';
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
  Future<int> deleteHabitType(int id) async {
    // TODO: implement deleteHabitType
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.delete(
          habitTypeTable, where: "$cloumnId", whereArgs: [id]);
    }catch(e){
      return -1;
    }
  }

  @override
  Future<List> getAllHabitTypes() async {
    // TODO: implement getAllHabitTypes
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

  @override
  Future<HabitType> getHabitType(int id) async {
    // TODO: implement getHabitType
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

  @override
  Future<int> getHabitTypesCount() async {
    // TODO: implement getHabitTypesCount
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

  @override
  Future<int> saveHabitType(HabitType habitType) async {
    // TODO: implement saveHabitType
    try{
      var dbClient = await db.honeyBee;
      int result = await dbClient.insert("$habitTypeTable", habitType.toMap());
      return result;
    }catch(e){
      return -1;
    }
  }

  @override
  Future<int> updateHabitType(HabitType habitType) async {
    // TODO: implement updateHabitType
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.update(
          habitTypeTable, habitType.toMap(),where: "$cloumnId",whereArgs: [habitType.id]
      );
    }catch(e){
      return -1;
    }
  }

}