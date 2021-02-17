import 'package:bassel/models/children/habitType.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:bassel/utils/databaseConfig.dart';

class HabitTypeService {

  final String habitTypeTable = 'habitTypeTable';
  final String cloumnId = 'id';
  final String cloumnName = 'name';
  final DatabaseConfig db = new DatabaseConfig();

  Future<int> saveHabitType(HabitType habitType) async{
    var dbClient = await db.honeyBee;
    int result = await dbClient.insert("$habitTypeTable", habitType.toMap());
    return result;
  }

  Future<List> getAllHabitTypes() async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $habitTypeTable";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<int> getHabitTypesCount () async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT COUNT(*) FROM $habitTypeTable";
    return Sqflite.firstIntValue(
        await dbClient.rawQuery(sql)
    );
  }

  Future<HabitType> getHabitType (int id) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $habitTypeTable WHERE $cloumnId = $id";
    var result = await dbClient.rawQuery(sql);
    if(result.length == 0) return null;
    return new HabitType.fromeMap(result.first);
  }

  Future<int> updateHabitType(HabitType habitType) async{
    var dbClient = await db.honeyBee;
    return await dbClient.update(
        habitTypeTable, habitType.toMap(),where: "$cloumnId",whereArgs: [habitType.id]
    );
  }

  Future<int> deleteHabitType(int id) async {
    var dbClient = await db.honeyBee;
    return await dbClient.delete(
        habitTypeTable, where: "$cloumnId", whereArgs: [id]);
  }

  close() async{
    var dbClient = await db.honeyBee;
    return await dbClient.close();
  }
}