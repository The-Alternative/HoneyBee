import 'package:bassel/models/children/event.dart';
import 'package:bassel/services/children/eventService.dart';
import 'dart:async';

class EventController {


  final EventService eventService =new EventService();

  Future<int> saveEvent(Event event) async{
    return await this.eventService.saveEvent(event);
  }

  Future<List> getAllEvents() async{
    return await this.eventService.getAllEvents();
  }

  Future<List> getChildEvents(int id) async{
    return await this.eventService.getChildEvents(id);
  }

  Future<List> searchChildEvents(int id,String text) async{
    return await this.eventService.searchChildEvents(id, text);
  }

  Future<List> getChildEvent(int id,int eventId) async{
    return await this.eventService.getChildEvent(id, eventId);
  }

  Future<int> getEventsCount () async{
    return await this.eventService.getEventsCount();
  }

  Future<Event> getEvent (int id) async{
    return await this.eventService.getEvent(id);
  }

  Future<int> updateEvent(Event event) async{
    return await this.eventService.updateEvent(event);
  }

  Future<int> deleteEvent(Event event) async{
    return await this.eventService.deleteEvent(event);
  }

  close() async{
    return await this.eventService.close();
  }
}