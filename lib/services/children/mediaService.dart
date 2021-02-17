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
    var dbClient = await db.honeyBee;
    int result = await dbClient.insert("$mediaTable", media.toMap());
    print("h4h4h4h4h4h");
    print("$result h4h4h4h4h4h");
    print("${media.itemId}");
    print("${media.mediaUrl}");
    return result;
  }

  Future<List> getAllMedia() async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $mediaTable";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<List> getItemMedias(int tableid,int itemId) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $mediaTable Where $cloumnTableId = $tableid AND $cloumnItemId = $itemId";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }



  Future<int> getMediaCount () async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT COUNT(*) FROM $mediaTable";
    return Sqflite.firstIntValue(
        await dbClient.rawQuery(sql)
    );
  }



  Future<int> updateMedia(Media media) async{
    var dbClient = await db.honeyBee;
    return await dbClient.update(
        mediaTable, media.toMap(),where: "$cloumnId = ${media.id}"
    );
  }

  Future<int> deleteMedia(Media media) async{
    var dbClient = await db.honeyBee;

    return await dbClient.delete(mediaTable, where: "$cloumnId = ${media.id}");
  }

  close() async{
    var dbClient = await db.honeyBee;
    return await dbClient.close();
  }
}