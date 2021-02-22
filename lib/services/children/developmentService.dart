import 'package:bassel/models/children/development.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:bassel/utils/databaseConfig.dart';

class DevelopmentService {

  final String developmentTable = 'developmentTable';
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

  Future<int> saveDevelopment(Development development) async{
    var dbClient = await db.honeyBee;
    int result = await dbClient.insert("$developmentTable", development.toMap());
    return result;
  }

  Future<List> getAllDevelopments() async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $developmentTable";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<List> getChildDevelopments(int id) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $developmentTable WHERE $cloumnChildId = $id";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<List> searchChildDevelopments(int id,String text) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $developmentTable WHERE $cloumnChildId = $id AND ($cloumnName LIKE '%$text%' OR $cloumnNote LIKE '%$text%')";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<List> getChildDevelopment(int id,int developmentId) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $developmentTable WHERE $cloumnChildId = $id AND $cloumnId = $developmentId";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<int> getDevelopmentsCount () async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT COUNT(*) FROM $developmentTable";
    return Sqflite.firstIntValue(
        await dbClient.rawQuery(sql)
    );
  }

  Future<Development> getDevelopment (int id) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $developmentTable WHERE $cloumnId = $id";
    var result = await dbClient.rawQuery(sql);
    if(result.length == 0) return null;
    return new Development.fromeMap(result.first);
  }

  Future<int> updateDevelopment(Development development) async{
    var dbClient = await db.honeyBee;
    return await dbClient.update(
        developmentTable, development.toMap(),where: "$cloumnId",whereArgs: [development.id]
    );
  }

  Future<int> deleteDevelopment(Development development) async{
    var dbClient = await db.honeyBee;
    Development ddevelopment = new Development(development.name, development.note, development.tall, development.weight, development.tempreture,
        0, development.childId, development.createdDate);
    return await dbClient.update(
        developmentTable, ddevelopment.toMap(),where: "$cloumnId",whereArgs: [development.id]
    );
  }

  close() async{
    var dbClient = await db.honeyBee;
    return await dbClient.close();
  }
}