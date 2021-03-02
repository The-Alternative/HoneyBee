import 'package:bassel/models/children/media.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:bassel/utils/databaseConfig.dart';

class MediaService {
  final String mediaTable = 'mediaTable';
  final String cloumnId = 'id';
  final String cloumnMediaUrl = 'mediaUrl';
  final String cloumnTableId = 'tableId';
  final String cloumnItemId = 'itemId';
  final String cloumnCreatedDate = 'createdDate';
  final DatabaseConfig db = new DatabaseConfig();


  Future<int> saveMedia(Media media) async{
    try{
      var dbClient = await db.honeyBee;
      int result = await dbClient.insert("$mediaTable", media.toMap());
      return result;
    }catch(e){
      return -1;
    }

  }

  Future<List> getAllMedia() async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $mediaTable";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }

  }

  Future<List> getItemMedias(int tableid,int itemId) async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $mediaTable Where $cloumnTableId = $tableid AND $cloumnItemId = $itemId";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }

  }



  Future<int> getMediaCount () async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT COUNT(*) FROM $mediaTable";
      return Sqflite.firstIntValue(
          await dbClient.rawQuery(sql)
      );
    }catch(e){
      return -1;
    }

  }



  Future<int> updateMedia(Media media) async{
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.update(
          mediaTable, media.toMap(),where: "$cloumnId = ${media.id}"
      );
    }catch(e){
      return -1;
    }

  }

  Future<int> deleteMedia(Media media) async{
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.delete(mediaTable, where: "$cloumnId = ${media.id}");
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