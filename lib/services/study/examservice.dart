import 'package:honeyBee/models/study/exam.dart';

import '../../utils/databaseconfig.dart';

import 'dart:async';

import 'package:sqflite/sqflite.dart';

class ExamService {
  static Database _honeyBee;

  final String exams = 'exams';
  final String examid = 'id';
  final String columnexamcourse = 'examcourse';
  final String columndateexam = 'dateexam';
  final String columntimeexam = 'timeexam';

  final DatabaseConfig db = new DatabaseConfig();

  Future<int> saveexam(Exam exam) async {
    var dbClient = await db.honeyBee;
    int result = await dbClient.insert("$exams", exam.toMap());
    print('baseeeeeeeeeeeeeeeeeeeeel:$result');
    return result;
  }

  Future<List> getAllexam() async {
    var dbClient = await db.honeyBee;
    var sql = "SELECT * FROM $exams";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<int> updateExam(Exam exam) async {
    var dbClient = await db.honeyBee;
    return await dbClient
        .update(exams, exam.toMap(), where: "$examid", whereArgs: [exam.id]);
  }

  Future<int> deleteexam(Exam exam) async {
    var dbClient = await db.honeyBee;
    return await dbClient.delete(exams, where: "$examid = ${exam.id}");
  }

  Future<List<Map<String, dynamic>>> getInfo(table) async {
    var db = await this.db.honeyBee;
    var result = await db.query(table);

    return result;
  }

  close() async {
    var dbClient = await db.honeyBee;
    return await dbClient.close();
  }
}
