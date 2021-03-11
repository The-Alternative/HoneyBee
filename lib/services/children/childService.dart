import 'package:HoneyBee/models/children/child.dart';
import 'package:HoneyBee/utils/databaseconfig.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class ChildService {
  static Database _honeyBee ;
  final String childTable = 'childTable';
  final String cloumnId = 'id';
  final String cloumnName = 'name';
  final String cloumnSex = 'sex';
  final String cloumnBirthDate = 'birthDate';
  final String cloumnImage = 'image';
  final String cloumnIsActive = 'isActive';
  final DatabaseConfig db = new DatabaseConfig();


//  Future<int> saveChild(Map x) async{
//    var dbClient = await db.honeyBee;
//    int result = await dbClient.insert("$childTable", x);
//    return result;
//  }
  Future<int> saveChild(Child child) async{
    try{
      var dbClient = await db.honeyBee;
      int result = await dbClient.insert("$childTable", child.toMap());
      return result;
    }catch(e){}
      return -1;
  }

  Future<List> getAllChild() async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $childTable";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List x =new List();
      x.add(e);
      return x;
    }

  }

  Future<int> getChildCount () async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT COUNT(*) FROM $childTable";
      return Sqflite.firstIntValue(
          await dbClient.rawQuery(sql)
      );
    }catch(e){
      return -1;
    }

  }

  Future<Child> getChild (int id) async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $childTable WHERE $cloumnId = $id";
      var result = await dbClient.rawQuery(sql);
      if(result.length == 0) return null;
      return new Child.fromeMap(result.first);
    }catch(e){
      Child x = new Child(e,e,e,e,e);
      return x;
    }

  }

//  Future<int> updateChild(Map x) async{
//    var dbClient = await db.honeyBee;
//    return await dbClient.update(
//        childTable, x,where: "$cloumnId = ${x['id']}"
//    );
//  }
  Future<int> updateChild(Child child) async{
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.update(
          childTable, child.toMap(),where: "$cloumnId = ${child.id}"
      );
    }catch(e){
      return -1;
    }

  }

  Future<int> deleteChild(Child child) async{
    try{
      var dbClient = await db.honeyBee;
      Child dChild = new Child(child.name, child.sex, child.birthDate, child.image, 0);
      return await dbClient.update(
          childTable, dChild.toMap(),where: "$cloumnId",whereArgs: [child.id]
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