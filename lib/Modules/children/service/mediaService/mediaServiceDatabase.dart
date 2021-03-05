import '../../model/media.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../utils/databaseconfig.dart';
import 'mediaService.dart';

class MediaServiceDatabase extends MediaService{

  final String mediaTable = 'mediaTable';
  final String cloumnId = 'id';
  final String cloumnMediaUrl = 'mediaUrl';
  final String cloumnTableId = 'tableId';
  final String cloumnItemId = 'itemId';
  final String cloumnCreatedDate = 'createdDate';
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
  Future<int> deleteMedia(Media media) async {
    // TODO: implement deleteMedia
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.delete(mediaTable, where: "$cloumnId = ${media.id}");
    }catch(e){
      return -1;
    }
  }

  @override
  Future<List> getAllMedia() async {
    // TODO: implement getAllMedia
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

  @override
  Future<List> getItemMedias(int tableid, int itemId) async {
    // TODO: implement getItemMedias
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

  @override
  Future<int> getMediaCount() async {
    // TODO: implement getMediaCount
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

  @override
  Future<int> saveMedia(Media media) async {
    // TODO: implement saveMedia
    try{
      var dbClient = await db.honeyBee;
      int result = await dbClient.insert("$mediaTable", media.toMap());
      return result;
    }catch(e){
      return -1;
    }
  }

  @override
  Future<int> updateMedia(Media media) async {
    // TODO: implement updateMedia
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.update(
          mediaTable, media.toMap(),where: "$cloumnId = ${media.id}"
      );
    }catch(e){
      return -1;
    }
  }

}