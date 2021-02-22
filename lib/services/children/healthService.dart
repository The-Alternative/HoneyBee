import 'package:bassel/models/children/health.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:bassel/utils/databaseConfig.dart';

class HealthService {
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


  Future<int> saveHealth(Health health) async{
    var dbClient = await db.honeyBee;
    int result = await dbClient.insert("$healthTable", health.toMap());
    return result;
  }

  Future<List> getAllHealth() async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $healthTable";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<List> getChildHealths(int id) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $healthTable Where $cloumnChildId = $id";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<List> searchChildHealths(int id,String text) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $healthTable Where $cloumnChildId = $id AND ($cloumnName LIKE '%$text%' OR $cloumnNote LIKE '%$text%')";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<List> getChildHealth(int id,int healthId) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $healthTable Where $cloumnChildId = $id AND $cloumnId = $healthId";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<int> getHealthCount () async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT COUNT(*) FROM $healthTable";
    return Sqflite.firstIntValue(
        await dbClient.rawQuery(sql)
    );
  }

  Future<Health> getHealth (int id) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $healthTable WHERE $cloumnId = $id";
    var result = await dbClient.rawQuery(sql);
    if(result.length == 0) return null;
    return new Health.fromeMap(result.first);
  }

  Future<int> updateHealth(Health health) async{
    var dbClient = await db.honeyBee;
    return await dbClient.update(
        healthTable, health.toMap(),where: "$cloumnId",whereArgs: [health.id]
    );
  }

  Future<int> deleteHealth(Health health) async{
    var dbClient = await db.honeyBee;
    Health dHealth = new Health(health.name, health.note, health.tall, health.weight, health.tempreture,
        0, health.childId, health.createdDate);
    return await dbClient.update(
        healthTable, dHealth.toMap(),where: "$cloumnId",whereArgs: [health.id]
    );
  }

  close() async{
    var dbClient = await db.honeyBee;
    return await dbClient.close();
  }
}