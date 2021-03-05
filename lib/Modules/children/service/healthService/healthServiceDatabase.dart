import '../../model/health.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../utils/databaseconfig.dart';
import 'healthService.dart';

class HealthServiceDatabase extends HealthService{

  final String healthTable = 'healthTable';
  final String cloumnId = 'id';
  final String cloumnName = 'name';
  final String cloumnNote = 'note';
  final String cloumnTall = 'tall';
  final String cloumnWeight = 'weight';
  final String cloumnTempreture = 'tempreture';
  final String cloumnIsActive = 'isActive';
  final String cloumnCreatedDate = 'createdDate';
  final String cloumnChildId = 'childId';
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
  Future<int> deleteHealth(Health health) async {
    // TODO: implement deleteHealth
    try{
      var dbClient = await db.honeyBee;
      Health dHealth = new Health(health.name, health.note, health.tall, health.weight, health.tempreture,
          0, health.childId, health.createdDate);
      return await dbClient.update(
          healthTable, dHealth.toMap(),where: "$cloumnId",whereArgs: [health.id]
      );
    }catch(e){
      return -1;
    }
  }

  @override
  Future<List> getAllHealth() async {
    // TODO: implement getAllHealth
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $healthTable";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }
  }

  @override
  Future<List> getChildHealth(int id, int healthId) async {
    // TODO: implement getChildHealth
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $healthTable Where $cloumnChildId = $id AND $cloumnId = $healthId";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }
  }

  @override
  Future<List> getChildHealths(int id) async {
    // TODO: implement getChildHealths
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $healthTable Where $cloumnChildId = $id";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }
  }

  @override
  Future<Health> getHealth(int id) async {
    // TODO: implement getHealth
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $healthTable WHERE $cloumnId = $id";
      var result = await dbClient.rawQuery(sql);
      if(result.length == 0) return null;
      return new Health.fromeMap(result.first);
    }catch(e){
      Health err = new Health(e,e,e,e,e,e,e,e);
    }
  }

  @override
  Future<int> getHealthCount() async {
    // TODO: implement getHealthCount
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT COUNT(*) FROM $healthTable";
      return Sqflite.firstIntValue(
          await dbClient.rawQuery(sql)
      );
    }catch(e){
      return -1;
    }
  }

  @override
  Future<int> saveHealth(Health health) async {
    // TODO: implement saveHealth
    try{
      var dbClient = await db.honeyBee;
      int result = await dbClient.insert("$healthTable", health.toMap());
      return result;
    }catch(e){
      return -1;
    }
  }

  @override
  Future<List> searchChildHealths(int id, String text) async {
    // TODO: implement searchChildHealths
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $healthTable Where $cloumnChildId = $id AND ($cloumnName LIKE '%$text%' OR $cloumnNote LIKE '%$text%')";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }
  }

  @override
  Future<int> updateHealth(Health health) async {
    // TODO: implement updateHealth
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.update(
          healthTable, health.toMap(),where: "$cloumnId",whereArgs: [health.id]
      );
    }catch(e){
      return -1;
    }
  }

}