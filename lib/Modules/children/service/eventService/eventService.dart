import '../../model/event.dart';

abstract class EventService{
  Future<int> saveEvent(Event event);
  Future<List> getAllEvents();
  Future<List> getChildEvents(int id);
  Future<List> searchChildEvents(int id,String text);
  Future<List> getChildEvent(int id,int eventId);
  Future<int> getEventsCount ();
  Future<Event> getEvent (int id);
  Future<int> updateEvent(Event event);
  Future<int> deleteEvent(Event event);
  close();
}