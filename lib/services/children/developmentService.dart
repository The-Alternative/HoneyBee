import 'package:HoneyBee/models/children/development.dart';
import 'package:HoneyBee/utils/databaseconfig.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

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
    try{
      var dbClient = await db.honeyBee;
      int result = await dbClient.insert("$developmentTable", development.toMap());
      return result;
    }catch(e){
      return -1;
    }

  }

  Future<List> getAllDevelopments() async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $developmentTable";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }

  }

  Future<List> getChildDevelopments(int id) async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $developmentTable WHERE $cloumnChildId = $id";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }

  }

  Future<List> searchChildDevelopments(int id,String text) async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $developmentTable WHERE $cloumnChildId = $id AND ($cloumnName LIKE '%$text%' OR $cloumnNote LIKE '%$text%')";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }

  }

  Future<List> getChildDevelopment(int id,int developmentId) async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $developmentTable WHERE $cloumnChildId = $id AND $cloumnId = $developmentId";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }

  }

  Future<int> getDevelopmentsCount () async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT COUNT(*) FROM $developmentTable";
      return Sqflite.firstIntValue(
          await dbClient.rawQuery(sql)
      );
    }catch(e){
      return -1;
    }

  }

  Future<Development> getDevelopment (int id) async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $developmentTable WHERE $cloumnId = $id";
      var result = await dbClient.rawQuery(sql);
      if(result.length == 0) return null;
      return new Development.fromeMap(result.first);
    }catch(e){
      Development err = new Development(e,e,e,e,e,e,e,e);
      return err;
    }

  }

  Future<int> updateDevelopment(Development development) async{
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.update(
          developmentTable, development.toMap(),where: "$cloumnId",whereArgs: [development.id]
      );
    }catch(e){
      return -1;
    }

  }

  Future<int> deleteDevelopment(Development development) async{
    try{
      var dbClient = await db.honeyBee;
      Development ddevelopment = new Development(development.name, development.note, development.tall, development.weight, development.tempreture,
          0, development.childId, development.createdDate);
      return await dbClient.update(
          developmentTable, ddevelopment.toMap(),where: "$cloumnId",whereArgs: [development.id]
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