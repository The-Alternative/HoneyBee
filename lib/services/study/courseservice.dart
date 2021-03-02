import 'dart:async';
import 'package:bassel/models/study/course.dart';
import 'package:bassel/utils/databaseconfig.dart';
import 'package:sqflite/sqflite.dart';

class CourseService {
  static Database _honeyBee;
  final String courses = 'courses';
  final String columnid = 'id';
  final String columnnamecourse = 'namecourse';
  final String columnnameteachar = 'nameteachar';
  final String columnemail = 'email';
  final String columnteacharnumber = 'teacharnumber';
  final DatabaseConfig db = new DatabaseConfig();

  Future<int> saveCourse(Course course) async {
    var dbClient = await db.honeyBee;
    int result = await dbClient.insert("$courses", course.toMap());
    return result;
  }

  Future<List> getAllcourse() async {
    var dbClient = await db.honeyBee;
    var sql = "SELECT * FROM $courses";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<int> updateCourse(Course course) async {
    var dbClient = await db.honeyBee;
    return await dbClient.update(courses, course.toMap(),
        where: "$columnid", whereArgs: [course.id]);
  }

  Future<int> deleteCourse(Course course) async {
    var dbClient = await db.honeyBee;
    return await dbClient.delete(courses, where: "$columnid = ${course.id}");
  }

  close() async {
    var dbClient = await db.honeyBee;
    return await dbClient.close();
  }
}
