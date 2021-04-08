import 'package:honeyBee/models/study/homework.dart';
import 'package:honeyBee/models/study/program.dart';

import '../../utils/databaseconfig.dart';

import 'dart:async';

import 'package:sqflite/sqflite.dart';

class ProgramService {
  static Database _honeyBee;

  final String programs = 'programs';
  final String programid = 'id';
  final String course = 'course';
  final String dateprogram = 'dateprogram';
  final String timeprogram = 'timeprogram';
  final String noteprogram = 'noteprogram';
  final String subtitle = 'subtitle';
  final String title = 'title';

  final DatabaseConfig db = new DatabaseConfig();

  Future<int> saveprogram(Program program) async {
    var dbProgram = await db.honeyBee;
    int result = await dbProgram.insert("$programs", program.toMap());
    print('program:$result');
    return result;
  }

  Future<List> getAllprogram() async {
    var dbProgram = await db.honeyBee;
    var sql = "SELECT * FROM $programs";
    List result = await dbProgram.rawQuery(sql);
    return result.toList();
  }

  Future<int> updateprogram(Program program) async {
    var dbProgram = await db.honeyBee;
    return await dbProgram.update(programs, program.toMap(),
        where: "$programid", whereArgs: [program.id]);
  }

  Future<int> deleteprogram(Program program) async {
    var dbProgram = await db.honeyBee;
    return await dbProgram.delete(programs,
        where: "$programid = ${program.id}");
  }

  Future<List<Map<String, dynamic>>> getInfo(table) async {
    var db = await this.db.honeyBee;
    var result = await db.query(table);

    return result;
  }

  close() async {
    var dbExam = await db.honeyBee;
    return await dbExam.close();
  }
}
