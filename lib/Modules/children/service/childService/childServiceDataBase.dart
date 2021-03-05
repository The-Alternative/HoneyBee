
import 'package:sqflite/sqflite.dart';

import '../../../../utils/databaseConfig.dart';
import '../../model/child.dart';

import 'childService.dart';

class ChildServerDateBase extends ChildServic{
  final DatabaseConfig db = new DatabaseConfig();
  final String childTable = 'childTable';
  final String cloumnId = 'id';
  final String cloumnName = 'name';
  final String cloumnSex = 'sex';
  final String cloumnBirthDate = 'birthDate';
  final String cloumnImage = 'image';
  final String cloumnIsActive = 'isActive';

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
  Future<int> deleteChild(Child child) async {
    // TODO: implement deleteChild
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

  @override
  Future<List> getAllChild() async{
    // TODO: implement getAllChild
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

  @override
  Future<Child> getChild(int id) async{
    // TODO: implement getChild
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

  @override
  Future<int> getChildCount() async {
    // TODO: implement getChildCount
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

  @override
  Future<int> saveChild(Child child) async {
    // TODO: implement saveChild
    try{
      var dbClient = await db.honeyBee;
      int result = await dbClient.insert("$childTable", child.toMap());
      return result;
    }catch(e){
      return -1;
    }
  }

  @override
  Future<int> updateChild(Child child) async {
    // TODO: implement updateChild
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.update(
          childTable, child.toMap(),where: "$cloumnId = ${child.id}"
      );
    }catch(e){
      return -1;
    }
  }

}