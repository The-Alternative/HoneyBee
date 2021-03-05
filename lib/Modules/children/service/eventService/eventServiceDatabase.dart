import '../../model/event.dart';
import 'package:sqflite/sqflite.dart';

import 'eventService.dart';
import '../../../../utils/databaseConfig.dart';


class EventServiceDatabase extends EventService{

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
  Future<int> deleteEvent(Event event) async {
    // TODO: implement deleteEvent
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

  @override
  Future<List> getAllEvents() async {
    // TODO: implement getAllEvents
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

  @override
  Future<List> getChildEvent(int id, int eventId) async {
    // TODO: implement getChildEvent
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

  @override
  Future<List> getChildEvents(int id) async {
    // TODO: implement getChildEvents
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

  @override
  Future<Event> getEvent(int id) async {
    // TODO: implement getEvent
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

  @override
  Future<int> getEventsCount() async {
    // TODO: implement getEventsCount
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

  @override
  Future<int> saveEvent(Event event) async {
    // TODO: implement saveEvent
    try{
      var dbClient = await db.honeyBee;
      int result = await dbClient.insert("$eventTable", event.toMap());
      return result;
    }catch(e){
      return -1;
    }
  }

  @override
  Future<List> searchChildEvents(int id, String text) async {
    // TODO: implement searchChildEvents
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

  @override
  Future<int> updateEvent(Event event) async {
    // TODO: implement updateEvent
    try{
      var dbClient = await db.honeyBee;
      return await dbClient.update(
          eventTable, event.toMap(),where: "$cloumnId",whereArgs: [event.id]
      );
    }catch(e){
      return -1;
    }
  }

}