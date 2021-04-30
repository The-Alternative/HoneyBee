import 'package:flutter_task/models/imageDto.dart';
import 'package:flutter_task/models/notice.dart';
import 'package:flutter_task/models/person.dart';
import 'package:flutter_task/models/stageModel.dart';
import 'package:flutter_task/models/taskInfo.dart';
import 'package:sqflite/sqflite.dart';

import '../models/eventDTO.dart';
import '../models/eventModel.dart';
import '../utils/databaseconfig.dart';

class EventController {
  static Database _honeyBee;
  //==============================================================================
  final String StageTable = 'stage';
  final String taskId = 'tid';
  final String stageId = 'sid';
  //==============================================================================
  final String PersonTable = 'person';
  final String personId = 'pid';
  final String name = 'name';
  //==============================================================================
  final String noticeTable = 'notice';
  final String noticeId = 'nid';
  final String columnNoticse = 'cnotice';
  //==============================================================================
  final String imageTable = 'image';
  final String imgId = 'imgid';
  final String path = 'path';
  //==============================================================================
  final String taskTable = 'event';
  final String columnId = 'id';
  final String columntitle = 'title';
  final String columnDescription = 'description';
  final String columnPiriority = 'piriority';
  final String taskCase = 'tcase';
  final String columnPlaces = 'places';
  final String columnDate = 'eventDate';
  final String columnTime = 'time';
  final DatabaseConfig db = new DatabaseConfig();
  //============================================================================================
  EventController() {
    initDatabase();
  }

  //============================================================================================

  Future initDatabase() async => _honeyBee = await this.db.honeyBee;

  //============================================================================================

  Future<int> saveTask(EventModel eventModel) async {
    DateTime now = new DateTime.now();
    print("  befor:::${eventModel.eventDate}");
    now = new DateTime(now.year, now.month, now.day);
    EventDTO eventDTO = EventDTO();
    eventDTO.title = eventModel.title;
    eventDTO.piriority=eventModel.piriority;
    eventDTO.columnPlaces=eventModel.columnPlaces;
    eventDTO.tcase=0;
    if (eventModel.columnPath1 != null )
    eventDTO.columnPath1 =eventModel.columnPath1;
    eventDTO.description = eventModel.description;
    eventDTO.eventDate = new DateTime(eventModel.eventDate.year,
        eventModel.eventDate.month, eventModel.eventDate.day)
        .toString();
    eventDTO.time = (eventModel.time.hour.toString() +
        ':' +
        eventModel.time.minute.toString());
    // eventDTO.time = eventModel.time.toString();
    int result = await _honeyBee.insert("$taskTable", eventDTO.toMap());

    print(eventDTO.time.toString() + " --- " + eventDTO.eventDate);
    print(now);

    return result;
  }
  //============================================================================================
  Future<int> Suspension(EventModel task) async {
    var result = await _honeyBee.update(taskTable, task.toMap(),
        where: "$columnId = ? ", whereArgs: [task.id]);
    return result;
  }

  //============================================================================================

  Future<List> searchTask(int id, String text) async {
    var sql =
        "SELECT * FROM $taskTable Where $columnId = $id AND ($columntitle LIKE '%$text%')";
    List result = await _honeyBee.rawQuery(sql);
    return result.toList();
  }
  //============================================================================================

  Future<List<EventModel>> getAll(int i) async {
    List<EventModel> _cardlist = [];
    var result = await _honeyBee.query(taskTable,
        orderBy:'$columnId DESC',where:'$taskCase = $i' );
    result.forEach((element) {
      var diary = EventModel.fromMap(element);
      _cardlist.add(diary);
    });
    return _cardlist;
  }
  //============================================================================================

  Future<List<EventModel>> getTaskList() async {
    var get = await getTaskMapList();
    int count = get.length;

    List<EventModel> tasks = new List<EventModel>();
    for (int i; i < count; i++) {
      tasks.add(EventModel.fromMap(get[i]));
    }
    return tasks;
  }
  //============================================================================================

  Future<List<EventModel>> getInfo(table, String title,int tcase ) async {
    List<EventModel> _cardlist = [];
    var result = await _honeyBee
        .rawQuery('SELECT * FROM $taskTable WHERE $taskCase = $tcase AND $columnDate =?', ['$title']);

    result.forEach((element) {
      var task = EventModel.fromMap(element);
      _cardlist.add(task);
    });
    return _cardlist;
  }
  //============================================================================================

  Future <List<Map<String, dynamic>>> getTaskMapList()  {
    var result =  _honeyBee.query(taskTable, orderBy: "$columnId DESC ");
    return result;
  }
  //============================================================================================

  Future<List> getAllTask() async {
    var result = await _honeyBee.query(taskTable, orderBy: "$columnId DESC ");
    return result.toList();
  }
  //============================================================================================

  Future<int> updateTask(EventModel eventModel,int tcase) async {
    DateTime now = new DateTime.now();
    now = new DateTime(now.year, now.month, now.day);
    EventDTO eventDTO = EventDTO();
    print("  befor:::${eventModel.eventDate}");

    eventDTO.id=eventModel.id;
    eventDTO.title = eventModel.title;
    eventDTO.piriority=eventModel.piriority;
    eventDTO.tcase=tcase;
    if (eventModel.columnPath1 != null )
      eventDTO.columnPath1 =eventModel.columnPath1;
    eventDTO.columnPlaces=eventModel.columnPlaces;
    eventDTO.description = eventModel.description;
    eventDTO.columnPath1 =eventModel.columnPath1;
    eventDTO.eventDate = eventModel.eventDate.toString();
    eventDTO.time = (eventModel.time.hour.toString() +
        ':' +
        eventModel.time.minute.toString());
     var result=await _honeyBee.update(taskTable, eventDTO.toMap(),
      where: "$columnId = ? ", whereArgs: [eventModel.id]);
    print(eventDTO.time.toString() + " --- " + eventDTO.eventDate);
    print(now);
    return result;
  }
  //============================================================================================

  Future<int> deleteobj(int id) async {
    int result = await _honeyBee
        .rawDelete('DELETE FROM $taskTable WHERE $columnId = $id');
    return result;
  }
  //============================================================================================
  insertPerson(PersonModel person)  {
    try {
      _honeyBee.insert('person', person.toMap());
      print('person');

    } catch (e) {
    }
  }
  //============================================================================================

   delRelated(int id) async {
    try {
      _honeyBee.rawDelete('DELETE FROM $PersonTable WHERE $taskId = $id');
      _honeyBee.rawDelete('DELETE FROM $StageTable WHERE $taskId = $id');
      _honeyBee.rawDelete('DELETE FROM $noticeTable WHERE $taskId = $id');
    }
    catch(e){
      print('error');
    }

   }
  //============================================================================================
  updatePerson(PersonModel person)  {
    try {
      _honeyBee.update(PersonTable, person.toMap(),
        where: "$personId = ? ", whereArgs: [person.personId]);

    } catch (e) {
    }
  }
  //============================================================================================
  insertStage(Stage stage)  {
    try {
      _honeyBee.insert('stage', stage.toMap());
      print('stageinserted');

    } catch (e) {
      print('error');
    }
  }
  //============================================================================================

  updatetStage(Stage stage)  {
    try {
      _honeyBee.update(StageTable, stage.toMap(),
          where: "$stageId = ? ", whereArgs: [stage.stageId]);

    } catch (e) {
      print('error');
    }
  }
  //============================================================================================
  insertnotice(NoticeModel notice)  {
    try {
      _honeyBee.insert('notice', notice.toMap());
      print('oknote');
    } catch (e) {
    }
  }
  //============================================================================================

  Future<int> updatenotice(NoticeModel notice) async {
    var result = await _honeyBee.update(noticeTable, notice.toMap(),
        where: "$noticeId = ? ", whereArgs: [notice.noticeId]);
    return result;
  }
  //============================================================================================

  insertimge(ImgModel img)  {
    try {
      _honeyBee.insert('image', img.toMap());
    } catch (e) {
    }
  }
  //============================================================================================
  Future<List<TaskInfo>> getRelatedInfo(int  Id) async {

    List<TaskInfo> _relatedTask = [];

    var result = await _honeyBee.rawQuery('SELECT $taskTable.$columnId as dd,'
        '$stageId,'
        '$StageTable.$columntitle as tt'
       ' FROM $taskTable,$StageTable'
        ' WHERE  $taskTable.$columnId = $StageTable.$taskId AND $taskTable.$columnId = $Id'
         );

    result.forEach((element) {
      var taskInfo = TaskInfo.fromMap(element);
      _relatedTask.add(taskInfo);
    });

    return _relatedTask;
  }
  //============================================================================================

  Future<List<TaskInfo>> getPersonInfo(int  Id) async {

    List<TaskInfo> _relatedTask = [];

    var result = await _honeyBee.rawQuery('SELECT $taskTable.$columnId as dd,'
        '$personId,'
        '$name'
        ' FROM $taskTable,$PersonTable'
        ' WHERE  $taskTable.$columnId = $PersonTable.$taskId AND $taskTable.$columnId = $Id'
    );

    result.forEach((element) {
      var taskInfo = TaskInfo.fromMap(element);
      _relatedTask.add(taskInfo);
    });

    return _relatedTask;
  }
  //============================================================================================

  Future<List<TaskInfo>> getNoticeInfo(int  Id) async {

    List<TaskInfo> _relatedTask = [];

    var result = await _honeyBee.rawQuery('SELECT $taskTable.$columnId as dd,'
        '$noticeId,'
        '$columnNoticse'
        ' FROM $taskTable,$noticeTable'
        ' WHERE  $taskTable.$columnId = $noticeTable.$taskId AND $taskTable.$columnId = $Id'
    );

    result.forEach((element) {
      var taskInfo = TaskInfo.fromMap(element);
      _relatedTask.add(taskInfo);
    });

    return _relatedTask;
  }
  //============================================================================================
  close() async {
    return await _honeyBee.close();
  }
}
