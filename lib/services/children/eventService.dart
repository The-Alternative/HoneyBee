import 'package:bassel/models/children/event.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:bassel/utils/databaseConfig.dart';

class EventService {

  final String eventTable = 'eventTable';
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

  Future<int> saveEvent(Event event) async{
    try{
      var dbClient = await db.honeyBee;
      int result = await dbClient.insert("$eventTable", event.toMap());
      return result;
    }catch(e){
      return -1;
    }

  }

  Future<List> getAllEvents() async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $eventTable";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }

  }

  Future<List> getChildEvents(int id) async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $eventTable WHERE $cloumnChildId = $id";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }

  }

  Future<List> searchChildEvents(int id,String text) async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $eventTable WHERE $cloumnChildId = $id AND ($cloumnName LIKE '%$text%' OR $cloumnNote LIKE '%$text%')";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }

  }

  Future<List> getChildEvent(int id,int eventId) async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $eventTable WHERE $cloumnChildId = $id AND $cloumnId = $eventId";
      List result = await dbClient.rawQuery(sql);
      return result.toList();
    }catch(e){
      List error = new List();
      error.add(e);
      return error;
    }

  }

  Future<int> getEventsCount () async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT COUNT(*) FROM $eventTable";
      return Sqflite.firstIntValue(
          await dbClient.rawQuery(sql)
      );
    }catch(e){
      return -1;
    }

  }

  Future<Event> getEvent (int id) async{
    try{
      var dbClient = await db.honeyBee;
      var sql ="SELECT * FROM $eventTable WHERE $cloumnId = $id";
      var result = await dbClient.rawQuery(sql);
      if(result.length == 0) return null;
      return new Event.fromeMap(result.first);
    }catch(e){
      Event err = new Event(e,e,e,e,e,e,e,e);
      return err;
    }

  }

  Future<int> updateEvent(Event event) async{
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.update(
          eventTable, event.toMap(),where: "$cloumnId",whereArgs: [event.id]
      );
    }catch(e){
      return -1;
    }

  }

  Future<int> deleteEvent(Event event) async{
    try{
      var dbClient = await db.honeyBee;
      Event devent = new Event(event.name, event.note, event.tall, event.weight, event.tempreture,
          0, event.childId, event.createdDate);
      return await dbClient.update(
          eventTable, devent.toMap(),where: "$cloumnId",whereArgs: [event.id]
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