import 'package:flutter/material.dart';

class EventModel {
  final int id;
  final int tcase;
  final String title;
  final String description;
  final String piriority;
  final String columnPerson;
  final String columnPath1 ;
  final String columnPath2 ;
  final String columnNoticse;
  final String columnPlaces;
  final DateTime eventDate;
  final TimeOfDay time;
  //==============================================================================
  EventModel(
      {this.columnPerson,
      this.tcase,
      this.columnNoticse,
      this.columnPlaces,
      this.id,
      this.title,
      this.description,
      this.piriority,
      this.eventDate,
      this.time, this.columnPath1
        , this.columnPath2});
  //==============================================================================
  factory EventModel.fromMap(Map data) {
    return EventModel(
        id: data['id'],
        tcase: data['tcase'],
        title: data['title'],
        description: data['description'],
        piriority: data['piriority'],
        columnNoticse: data['notice'],
        columnPerson: data['person'],
        columnPath1: data['path1'],
        columnPath2: data['path2'],
        columnPlaces: data['places'],
        eventDate: DateTime.parse(data['eventDate']),
        time: TimeOfDay(hour: int.parse(data['time'].split(":")[0]), minute: int.parse(data['time'].split(":")[1])));
  }
  //==============================================================================
  factory EventModel.fromJson(int id, Map<String, dynamic> data) {
    return EventModel(
        id: id,
        title: data['title'],
        description: data['description'],
        piriority: data['piriority'],
        columnNoticse: data['notice'],
        tcase: data['tcase'],
        columnPerson: data['person'],
        columnPath1: data['path1'],
        columnPath2: data['path2'],
        columnPlaces: data['places'],
        eventDate: data['eventDate'].toDate(),
        time: TimeOfDay(hour: data['time'].split(":")[0], minute: data['time'].split(":")[1]));
  }
  //==============================================================================
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      'piriority': piriority,
      "eventDate": eventDate,
      "time": time,
      'tcase': tcase,
      'person': columnPerson,
      'notice': columnNoticse,
      'places': columnPlaces,
      'path1':columnPath1,
      'path2':columnPath2
    };
  }
}
