
import 'package:sqflite/sqflite.dart';

import '../../../../utils/databaseConfig.dart';
import '../../model/development.dart';

import 'developmentService.dart';

class DevelopmentServiceDatabase extends DevelopmentService{
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

  @override
  close() async{
    // TODO: implement close
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.close();
    }catch(e){
      return -1;
    }
  }

  @override
  Future<int> deleteDevelopment(Development development) async{
    // TODO: implement deleteDevelopment
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

  @override
  Future<List> getAllDevelopments() async {
    // TODO: implement getAllDevelopments
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

  @override
  Future<List> getChildDevelopment(int id, int developmentId)async {
    // TODO: implement getChildDevelopment
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

  @override
  Future<List> getChildDevelopments(int id) async {
    // TODO: implement getChildDevelopments
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

  @override
  Future<Development> getDevelopment(int id) async {
    // TODO: implement getDevelopment
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

  @override
  Future<int> getDevelopmentsCount() async {
    // TODO: implement getDevelopmentsCount
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

  @override
  Future<int> saveDevelopment(Development development) async {
    // TODO: implement saveDevelopment
    try{
      var dbClient = await db.honeyBee;
      int result = await dbClient.insert("$developmentTable", development.toMap());
      return result;
    }catch(e){
      return -1;
    }
  }

  @override
  Future<List> searchChildDevelopments(int id, String text) async {
    // TODO: implement searchChildDevelopments
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

  @override
  Future<int> updateDevelopment(Development development) async{
    // TODO: implement updateDevelopment
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.update(
          developmentTable, development.toMap(),where: "$cloumnId",whereArgs: [development.id]
      );
    }catch(e){
      return -1;
    }
  }

}