import 'package:bassel/models/children/child.dart';
import 'package:bassel/utils/databaseConfig.dart';
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
    var dbClient = await db.honeyBee;
    int result = await dbClient.insert("$childTable", child.toMap());
    return result;
  }

  Future<List> getAllChild() async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $childTable";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<int> getChildCount () async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT COUNT(*) FROM $childTable";
    return Sqflite.firstIntValue(
        await dbClient.rawQuery(sql)
    );
  }

  Future<Child> getChild (int id) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $childTable WHERE $cloumnId = $id";
    var result = await dbClient.rawQuery(sql);
    if(result.length == 0) return null;
    return new Child.fromeMap(result.first);
  }

//  Future<int> updateChild(Map x) async{
//    var dbClient = await db.honeyBee;
//    return await dbClient.update(
//        childTable, x,where: "$cloumnId = ${x['id']}"
//    );
//  }
  Future<int> updateChild(Child child) async{
    var dbClient = await db.honeyBee;
    return await dbClient.update(
        childTable, child.toMap(),where: "$cloumnId = ${child.id}"
    );
  }

  Future<int> deleteChild(Child child) async{
    var dbClient = await db.honeyBee;
    Child dChild = new Child(child.name, child.sex, child.birthDate, child.image, 0);
    return await dbClient.update(
        childTable, dChild.toMap(),where: "$cloumnId",whereArgs: [child.id]
    );
  }

  close() async{
    var dbClient = await db.honeyBee;
    return await dbClient.close();
  }
}